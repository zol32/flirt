import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flirt/blocs/blocs.dart';
import 'package:flirt/services/services.dart';
import '/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseService _databaseService;
  StreamSubscription? _authSubscription;

  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseService databaseService,
  })  : _authBloc = authBloc,
        _databaseService = databaseService,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    log('USERS Loaded');
    on<UpdateHome>(_onUpdateHome);
    log('HOME Loaded');
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);
    log('SWIPES Loaded');

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUsers(userId: state.user!.uid));
      }
    });
    log('AUTH complete');
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _databaseService.getUsers(event.userId, 'Male').listen((users) {
      add(
        UpdateHome(users: users),
      );
    });
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<SwipeState> emit,
  ) {
    log('UPDATING HOME');
    if (event.users != null) {
      List<User> usersFake = User.users;
      emit(SwipeLoaded(users: usersFake));
      // emit(SwipeLoaded(users: event.users!));
      log('FAKE USERS LOADED');
    } else {
      emit(SwipeError());
    }
  }

  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  void _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
