import 'package:flirt/blocs/blocs.dart';
import 'package:flirt/blocs/swipe/swipe_bloc.dart';
import 'package:flirt/constants/routes.dart';
import 'package:flirt/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? OnboardingScreen()
              : HomePage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        hasActions: true,
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(builder: (context, state) {
        if (state is SwipeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SwipeLoaded) {
          return Column(
            children: [
              InkWell(
                onDoubleTap: () {
                  Navigator.pushNamed(
                    context,
                    '/users',
                    arguments: state.users[0],
                  );
                },
                child: Draggable(
                  child: UserCard(user: state.users[0]),
                  feedback: UserCard(user: state.users[0]),
                  childWhenDragging: UserCard(user: state.users[1]),
                  onDragEnd: (drag) {
                    if (drag.velocity.pixelsPerSecond.dx < 0) {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeLeft(user: state.users[0]));
                      print('Swipe left');
                    } else {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeRight(user: state.users[0]));
                      print('Swipe right');
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeLeft(user: state.users[0]));
                        print('Swipe left');
                      },
                      child: ChoiceButton(
                        width: 60,
                        height: 60,
                        hasGradient: false,
                        size: 35,
                        color: Theme.of(context).colorScheme.secondary,
                        icon: Icons.clear_rounded,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeRight(user: state.users[0]));
                        print('Swipe right');
                      },
                      child: const ChoiceButton(
                        width: 60,
                        height: 60,
                        size: 35,
                        hasGradient: true,
                        color: Colors.white,
                        icon: Icons.favorite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Text('Something went wrong');
        }
      }),
    );
  }
}
