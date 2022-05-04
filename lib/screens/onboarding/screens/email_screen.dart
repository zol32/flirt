import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '/cubits/cubits.dart';
import '/screens/onboarding/widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child:
                        Center(child: CustomTextHeader(text: 'Email Address')),
                  ),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                    },
                  ),
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(
                        child: CustomTextHeader(text: 'Choose a Password')),
                  ),
                  CustomPasswordField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).colorScheme.secondary,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(tabController: tabController, text: 'NEXT STEP'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
