import 'package:flirt/blocs/swipe/swipe_bloc.dart';
import 'package:flirt/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<SwipeBloc, SwipeState>(builder: (context, state) {
        if (state is SwipeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SwipeLoaded) {
          return Column(
            children: [
              Draggable(
                child: UserCard(user: state.users[0]),
                feedback: UserCard(user: state.users[0]),
                childWhenDragging: UserCard(user: state.users[1]),
                onDragEnd: (drag) {
                  if (drag.velocity.pixelsPerSecond.dx < 0) {
                    context.read<SwipeBloc>()
                      ..add(SwipeLeftEvent(user: state.users[0]));
                    print('Swipe left');
                  } else {
                    context.read<SwipeBloc>()
                      ..add(SwipeRightEvent(user: state.users[0]));
                    print('Swipe right');
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<SwipeBloc>()
                          ..add(SwipeLeftEvent(user: state.users[0]));
                        print('Swipe left');
                      },
                      child: ChoiceButton(
                        width: 60,
                        height: 60,
                        hasGradient: false,
                        size: 25,
                        color: Theme.of(context).colorScheme.secondary,
                        icon: Icons.clear_rounded,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<SwipeBloc>()
                          ..add(SwipeRightEvent(user: state.users[0]));
                        print('Swipe right');
                      },
                      child: ChoiceButton(
                        width: 60,
                        height: 60,
                        size: 30,
                        hasGradient: true,
                        color: Colors.white,
                        icon: Icons.favorite,
                      ),
                    ),
                    ChoiceButton(
                      width: 60,
                      height: 60,
                      hasGradient: false,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                      icon: Icons.watch_later,
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
