import 'package:flirt/constants/routes.dart';
import 'package:flirt/constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flirt/screens/screens.dart';
import 'package:flirt/services/services.dart';
import 'cubits/cubits.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthService(),
          ),
          RepositoryProvider(
            create: (context) => DatabaseService(),
          ),
          RepositoryProvider(
            create: (context) => StorageService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authService: context.read<AuthService>(),
              ),
            ),
            BlocProvider<SignupCubit>(
              create: (context) =>
                  SignupCubit(authService: context.read<AuthService>()),
            ),
            BlocProvider<OnboardingBloc>(
              create: (context) => OnboardingBloc(
                databaseService: context.read<DatabaseService>(),
                storageService: context.read<StorageService>(),
              ),
            ),
            BlocProvider(
              create: (context) => SwipeBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                databaseService: context.read<DatabaseService>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Flirt',
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
          ),
        ));
  }
}
