import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yntymak/feature/profile/presentation/screens/qr_code_scanner_screen.dart';

import '../../feature/authorization/presentation/screens/login_screen.dart';
import '../../feature/calendar/presentation/screen/calendar_screen.dart';
import '../../feature/events/data/models/events_model.dart';
import '../../feature/events/presentation/screens/events_detail_screen.dart';
import '../../feature/events/presentation/screens/events_screen.dart';
import '../../feature/profile/presentation/screens/profile_screen.dart';
import '../../feature/services/presentation/screens/services_screen.dart';
import '../../feature/splash/splash_screen.dart';
import '../commons/bottom_nav_bar.dart';
import 'app_routes_name.dart';
import 'error_page.dart';

final GoRouter router = GoRouter(
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: ErrorPage());
  },
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutesNames.authScreen,
      path: '/auth',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavBar(
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: AppRoutesNames.eventsScreen,
          path: '/',
          pageBuilder: (context, state) {
            final newsModel = state.extra as EventsModel?;
            return MaterialPage(
              child: EventsScreen(newsModel: newsModel),
            );
          },
          routes: [
            GoRoute(
              path: 'event_detail/:id',
              builder: (context, state) {
                final eventId = state.pathParameters['id'];
                return EventsDetailPage(eventId: eventId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) {
            return const CalendarScreen();
          },
        ),
        GoRoute(
          name: AppRoutesNames.servicesScreen,
          path: '/services',
          builder: (context, state) => const ServicesScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return const ProfileScreen();
          },
        ),
        GoRoute(
          path: '/qr_scanner',
          builder: (context, state) {
            return const QRCodeScannerScreen();
          },
        ),
      ],
    ),
  ],
);
