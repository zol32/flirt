import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flirt/blocs/blocs.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '/screens/onboarding/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatelessWidget {
  final TabController tabController;

  const Location({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      var _latitude;
      var _longitude;
      var _location;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position pos = await Geolocator.getCurrentPosition();

      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();

      _location = _latitude + ' ' + _longitude;

      return _location;
    }

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
                    const CustomTextHeader(
                        text:
                            'ALMOST DONE! TAP BUTTON TO ADD LOCATION IF WANTED!'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            String location = await _determinePosition();
                            context.read<OnboardingBloc>().add(
                                  UpdateUser(
                                    user:
                                        state.user.copyWith(location: location),
                                  ),
                                );
                          },
                          child: const Text('GET LOCATION'),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(tabController: tabController, text: 'DONE'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
