import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtheye/data/user.dart';
import 'package:healtheye/feature/wallet/user_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/auth.dart';

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

final ValueListenable<AuthState> authChangeNotifier =
    ValueNotifier<AuthState>(const AuthState.unauthenticated());

class AuthNotifier extends Notifier<AuthState> {
  AuthNotifier();

  @override
  AuthState build() {
    _hydrateUser();
    return authChangeNotifier.value;
  }

  void setCredentials(User user) async {
    state = AuthState.processing(user);
    _loadKeysFromWallet(user);
  }

  void _loadKeysFromWallet(User user) async {
    final keys = await UserKeys.fetch(user);
    final current = state.user;
    if (current == null) return;
    state = AuthState.authenticated(current, keys);
  }

  final _preference = SharedPreferences.getInstance();

  static const _userPersistenceKey = 'frog#user';

  Future<void> _hydrateUser() async {
    final preference = await _preference;
    final userJson = preference.getString(_userPersistenceKey);
    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));
      state = AuthState.processing(user);
      _loadKeysFromWallet(user);
    }
  }

  Future<void> _saveUser(User? user) async {
    final preference = await _preference;
    if (user != null) {
      await preference.setString(
        _userPersistenceKey,
        json.encode(user.toJson()),
      );
    } else {
      await preference.remove(_userPersistenceKey);
    }
  }

  @override
  set state(AuthState value) {
    if (value != state) {
      Future.microtask(() {
        _saveUser(value.user);
        (authChangeNotifier as ValueNotifier).value = value;
      });
    }
    super.state = value;
  }

  void signOut() {
    state = const AuthState.unauthenticated();
  }
}
