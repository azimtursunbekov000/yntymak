import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/authorization/data/repositories/auth_repository_impl.dart';
import 'feature/authorization/domain/use_case/auth_use_case.dart';
import 'feature/authorization/presentation/logic/bloc/auth/auth_bloc.dart';
import 'feature/events/data/repositories/events_repository_impl.dart';
import 'feature/events/domain/use_case/events_use_case.dart';
import 'feature/events/presentation/logic/events_bloc.dart';
import 'feature/profile/presentation/logic/profile__cubit.dart';
import 'feature/profile/presentation/logic/theme_cubit.dart';
import 'internal/app_routes/app_routes.dart';
import 'internal/theme/change_theme.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print(details);
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print('Caught error: $error');
    print(stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            AuthUseCase(
              authRepository: AuthRepositoryImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => EventsBloc(
            EventsUseCase(
              newsRepository: EventsRepositoryImpl(),
            ),
          ),
        ),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            themeMode: themeMode,
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.darkTheme(context),
          );
        },
      ),
    );
  }
}
