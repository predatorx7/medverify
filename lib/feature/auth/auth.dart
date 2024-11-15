import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frog/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;

  bool get isAuthenticated => this is _Authenticated;
  User? get user =>
      this is _Authenticated ? (this as _Authenticated).user : null;
}

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

  void setCredentials(User user) {
    state = AuthState.authenticated(user);
  }

  final _preference = SharedPreferences.getInstance();

  static const _userPersistenceKey = 'frog#user';

  Future<void> _hydrateUser() async {
    final preference = await _preference;
    final userJson = preference.getString(_userPersistenceKey);
    if (userJson != null) {
      state = AuthState.authenticated(User.fromJson(jsonDecode(userJson)));
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
