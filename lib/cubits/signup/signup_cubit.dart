import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flirt/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireBase;
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthService _authService;

  SignupCubit({required AuthService authService})
      : _authService = authService,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      var user = await _authService.signUp(
        email: state.email,
        password: state.password,
      );
      log('NEW AUTH USER CREATED');
      emit(state.copyWith(status: SignupStatus.success, user: user));
    } catch (_) {}
  }
}
