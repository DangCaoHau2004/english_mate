import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/auth_repository.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/learning/flash_card_bloc.dart';
import 'package:english_mate/viewModels/learning/session_word.dart';
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
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  // khởi tạo flash card bloc
  Future<FlashCardBloc> _createFlashCardBloc() async {
    final prefs = await SharedPreferences.getInstance();
    //false là tiếng anh, true là tiếng việt
    final isFlipped = prefs.getBool('is_flipped_default') ?? false;
    final shuffleFlashCards = prefs.getBool('shuffle_flashcards') ?? false;

    final wordBox = Hive.box<Word>('wordsBox');
    List<SessionWord> sessionWords = List.generate(10, (index) {
      return SessionWord(
        word: wordBox.getAt(index)!,
        wordStatus: WordStatus.stillLearning,
      );
    });

    return FlashCardBloc(
      sessionWords: sessionWords,
      isFlippedDefault: isFlipped,
    );
  }

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
        builder: (context, state) => BlocProvider(
          create: (context) {
            final wordBox = Hive.box<Word>('wordsBox');
            List<SessionWord> sessionWords = List.generate(10, (index) {
              return SessionWord(
                word: wordBox.getAt(index)!,
                wordStatus: WordStatus.stillLearning,
              );
            });
            return FlashCardBloc(
              sessionWords: sessionWords,
              isFlippedDefault: true,
            );
          },
          child: const FlaskCardView(),
        ),
      ),

      GoRoute(
        path: RoutePath.auth,
        builder: (context, state) => BlocProvider(
          create: (context) {
            return SignInBloc(
              authRepository: AuthRepository(),
              userRepository: UserRepository(),
            );
          },
          child: const GettingStartedView(),
        ),
      ),
      GoRoute(
        path: RoutePath.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInBloc(
            authRepository: AuthRepository(),
            userRepository: UserRepository(),
          ),
          child: const SignInView(),
        ),
      ),
      GoRoute(
        path: RoutePath.signUp,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    SignUpBloc(authRepository: AuthRepository()),
              ),
              BlocProvider(
                create: (context) => SignInBloc(
                  authRepository: AuthRepository(),
                  userRepository: UserRepository(),
                ),
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
              create: (context) => UserInfoBloc(userInfoData: userInfoData),
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
