import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/screens/onboarding/widgets/widgets.dart';
import '/blocs/blocs.dart';

class Bio extends StatelessWidget {
  final TabController tabController;

  const Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: CustomTextHeader(text: 'Describe Yourself')),
                    ),
                    CustomTextField(
                      hint: 'ENTER YOUR BIO',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(bio: value),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 100),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: CustomTextHeader(text: 'What Do You Like?')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomTextContainer(text: 'MUSIC'),
                          CustomTextContainer(text: 'COFFEE'),
                          CustomTextContainer(text: 'ART'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomTextContainer(text: 'NATURE'),
                          CustomTextContainer(text: 'HIKING'),
                          CustomTextContainer(text: 'MOVIES'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
