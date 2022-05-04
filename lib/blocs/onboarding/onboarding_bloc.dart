import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '/services/services.dart';
import '/models/models.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseService _databaseService;
  final StorageService _storageService;

  OnboardingBloc({
    required DatabaseService databaseService,
    required StorageService storageService,
  })  : _databaseService = databaseService,
        _storageService = storageService,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    log('USER CREATING START');
    await _databaseService.createUser(event.user);
    log('USER CREATED');
    emit(OnboardingLoaded(user: event.user));
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      log('UPDATING USER');
      _databaseService.updateUser(event.user);
      log('UPDATED USER');
      emit(OnboardingLoaded(user: event.user));
      log('UPDATE COMPLETE');
    }
  }

  void _onUpdateUserImages(
    UpdateUserImages event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state is OnboardingLoaded) {
      User user = (state as OnboardingLoaded).user;
      await _storageService.uploadImage(user, event.image);

      _databaseService.getUser(user.id!).listen((user) {
        add(UpdateUser(user: user));
      });
    }
  }
}
