import 'package:flutter/material.dart';
import '/screens/onboarding/widgets/widgets.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/couple.jpg',
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome to FLIRT',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text(
                'Are you ready to take your next steps in the global dating marketplace? We encourage all forms of love and connections. Just always remember to be yourself! ',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(height: 1.8, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CustomButton(tabController: tabController, text: 'START')
        ],
      ),
    );
  }
}
