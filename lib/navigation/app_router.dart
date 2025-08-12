import 'package:english_mate/config/di.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_bloc.dart';
import 'package:english_mate/viewModels/learning/settings/settings_bloc.dart';
import 'package:english_mate/views/account/account_view.dart';
import 'package:english_mate/views/authentication/getting_started_view.dart';
import 'package:english_mate/views/authentication/signUp/sign_up_view.dart';
import 'package:english_mate/views/authentication/signUp/user_info_view.dart';
import 'package:english_mate/views/authentication/sign_in_view.dart';
import 'package:english_mate/views/home/home_view.dart';
import 'package:english_mate/views/home_navigation/home_navigation.dart';
import 'package:english_mate/views/review/review_view.dart';
import 'package:english_mate/views/statistics/statistics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:english_mate/views/learning/flash_card_view.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final router = GoRouter(
    initialLocation: RoutePath.flashCard,
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.review,
                builder: (context, state) => const ReviewView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.statistics,
                builder: (context, state) => const StatisticsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.account,
                builder: (context, state) => const AccountView(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: RoutePath.flashCard,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                return DI().sl<FlashCardBloc>(param1: 2);
              },
            ),
            BlocProvider(
              create: (context) {
                return DI().sl<SettingsBloc>();
              },
            ),
          ],
          child: const FlaskCardView(),
        ),
      ),

      GoRoute(
        path: RoutePath.auth,
        builder: (context, state) => BlocProvider(
          create: (context) {
            return DI().sl<SignInBloc>();
          },
          child: const GettingStartedView(),
        ),
      ),
      GoRoute(
        path: RoutePath.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) {
            return DI().sl<SignInBloc>();
          },
          child: const SignInView(),
        ),
      ),
      GoRoute(
        path: RoutePath.signUp,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return DI().sl<SignUpBloc>();
                },
              ),
              BlocProvider(
                create: (context) {
                  return DI().sl<SignInBloc>();
                },
              ),
            ],
            child: const SignUpView(), // Cung cấp bloc cho toàn bộ flow
          );
        },
      ),
      GoRoute(
        path: RoutePath.userInfo,
        builder: (context, state) {
          final UserInfoData? userInfoData = state.extra as UserInfoData?;
          if (userInfoData != null) {
            return BlocProvider(
              create: (context) {
                return DI().sl<UserInfoBloc>(param1: userInfoData);
              },
              child: const UserInfoView(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(
                  "Lỗi: Không có thông tin người dùng.",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          }
        },
      ),
    ],
  );
}
