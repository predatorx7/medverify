import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frog/data/user.dart';

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
    return authChangeNotifier.value;
  }

  void setCredentials(User user) {
    state = AuthState.authenticated(user);
  }

  @override
  set state(AuthState value) {
    if (value != state) {
      Future.microtask(() {
        (authChangeNotifier as ValueNotifier).value = value;
      });
    }
    super.state = value;
  }

  void signOut() {
    state = const AuthState.unauthenticated();
  }
}
