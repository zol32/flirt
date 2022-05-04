import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireBase;
import 'package:flirt/services/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  StreamSubscription<FireBase.User?>? _userSubscription;

  AuthBloc({
    required AuthService authService,
  })  : _authService = authService,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);

    _userSubscription = _authService.user.listen((user) {
      add(AuthUserChanged(user: user));
    });
  }

  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    event.user != null
        ? emit(AuthState.authenticated(user: event.user!))
        : emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
