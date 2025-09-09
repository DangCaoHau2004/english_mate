import 'package:english_mate/config/di.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/navigation/go_router_refresh_stream.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_bloc.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_event.dart';
import 'package:english_mate/views/account/account_view.dart';
import 'package:english_mate/views/account/edit_profile_view.dart';
import 'package:english_mate/views/account/linked_account_view.dart';
import 'package:english_mate/views/account/setting_view.dart';
import 'package:english_mate/views/authentication/getting_started_view.dart';
import 'package:english_mate/views/authentication/signUp/sign_up_view.dart';
import 'package:english_mate/views/authentication/signUp/user_info_view.dart';
import 'package:english_mate/views/authentication/sign_in_view.dart';
import 'package:english_mate/views/home/home_view.dart';
import 'package:english_mate/views/home_navigation/home_navigation.dart';
import 'package:english_mate/views/learning/word_detail_view.dart';
import 'package:english_mate/views/review/review_view.dart';
import 'package:english_mate/views/library/library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:english_mate/views/learning/flash_card_view.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter build(AuthGateCubit authGateCubit) {
    return GoRouter(
      initialLocation: RoutePath.home,
      navigatorKey: rootNavigatorKey,
      refreshListenable: GoRouterRefreshStream(authGateCubit.stream),
      redirect: (context, state) {
        final authState = authGateCubit.state;
        final loggedIn = authState.isLoggedIn;
        final isNewUser = authState.isNewUser;

        final onAuthFlow =
            state.matchedLocation == RoutePath.auth ||
            state.matchedLocation == RoutePath.signIn ||
            state.matchedLocation == RoutePath.signUp;

        final onUserInfo = state.matchedLocation == RoutePath.userInfo;

        // người dùng chưa đăng nhập
        if (!loggedIn) {
          return onAuthFlow ? null : RoutePath.auth;
        }

        // đã đăng nhập đang chờ check
        if (isNewUser == null) {
          return null;
        }

        // đã đăng nhập nhưng là người mới
        if (isNewUser) {
          // đã điều hướng thủ công
          return null;
        }

        // đã đăng nhập và nếu đang ở các trang đăng nhập hoặc điền thông tin thì cho về home
        if (onAuthFlow || onUserInfo) {
          return RoutePath.home;
        }

        // Mặc định: cho phép đi tiếp
        return null;
      },
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
                  path: RoutePath.library,
                  builder: (context, state) => const LibraryView(),
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
          path: "${RoutePath.flashCard}/:unitId",
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  final unitId = state.pathParameters['unitId'] ?? "1";
                  return DI().sl<FlashCardBloc>(param1: unitId)
                    ..add(CheckUnitFirstTimeLearningUnit());
                },
              ),
            ],
            child: const FlaskCardView(),
          ),
        ),

        GoRoute(
          path: RoutePath.setting,
          builder: (context, state) => const SettingView(),
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
            final UserInfoData? userInfoData = authGateCubit.state.userInfoData;
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
        GoRoute(
          path: RoutePath.wordDetail,
          builder: (context, state) {
            final Word word = state.extra as Word;
            return WordDetailView(word: word);
          },
        ),
        GoRoute(
          path: RoutePath.editProfile,
          builder: (context, state) {
            UserData userData = context.read<AuthGateCubit>().state.userData!;
            return BlocProvider(
              create: (context) => DI().sl<EditProfileBloc>(param1: userData),
              child: const EditProfileView(),
            );
          },
        ),
        GoRoute(
          path: RoutePath.linkedAccount,
          builder: (context, state) {
            List<AppAuthProvider> appAuthProvider = context
                .read<AuthGateCubit>()
                .state
                .userData!
                .authProvider;
            return BlocProvider(
              create: (context) =>
                  DI().sl<LinkedAccountBloc>(param1: appAuthProvider),
              child: const LinkedAccountView(),
            );
          },
        ),
      ],
    );
  }
}
