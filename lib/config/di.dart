// di.dart
import 'package:english_mate/data/local/setting_local_datasource.dart';
import 'package:english_mate/data/network/user_firestore_datasource.dart';
import 'package:english_mate/data/repository/setting_repository.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_bloc.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_bloc.dart';
import 'package:english_mate/viewModels/learning/settings/settings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/auth_repository.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_bloc.dart';
import 'package:english_mate/models/learning/session_word.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DI {
  DI._();
  static final DI _i = DI._();
  factory DI() => _i;

  final sl = GetIt.instance;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
    sl.registerLazySingleton<SettingLocalDatasource>(
      () => SettingLocalDatasource(prefs: sl<SharedPreferences>()),
    );
    sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

    sl.registerLazySingleton<Box<Word>>(() => Hive.box<Word>('wordsBox'));
    sl.registerLazySingleton<SettingRepository>(
      () => SettingRepository(local: sl<SettingLocalDatasource>()),
    );
    sl.registerFactory<SignInBloc>(
      () => SignInBloc(
        authRepository: sl<AuthRepository>(),
        userRepository: sl<UserRepository>(),
      ),
    );

    sl.registerFactory<SignUpBloc>(
      () => SignUpBloc(authRepository: sl<AuthRepository>()),
    );

    sl.registerFactory<SettingsBloc>(() {
      return SettingsBloc(
        settingRepository: sl<SettingRepository>(),
        isShuffleFlashCards: sl<SettingRepository>().shuffleFlashcards,
        isFlippedDefault: sl<SettingRepository>().isFlippedDefault,
        appThemeMode: sl<SettingRepository>().appThemeMode,
      );
    });

    sl.registerFactoryParam<FlashCardBloc, int, void>((unitId, _) {
      final wordBox = sl<Box<Word>>();

      final wordInUnit = wordBox.values
          .where((w) => w.unitId == unitId)
          .toList();
      final List<SessionWord> sessionWords = [];
      for (var i = 0; i < wordInUnit.length; i++) {
        final w = wordInUnit[i];
        sessionWords.add(
          SessionWord(word: w, wordStatus: WordStatus.stillLearning),
        );
      }

      return FlashCardBloc(
        sessionWords: sessionWords,
        isFlippedDefault: sl<SettingRepository>().isFlippedDefault,
      );
    });

    sl.registerFactoryParam<UserInfoBloc, UserInfoData, void>((
      userInfoData,
      _,
    ) {
      return UserInfoBloc(
        userInfoData: userInfoData,
        userRepository: sl<UserRepository>(),
      );
    });

    //đăng kí cái kiểm tra user
    sl.registerLazySingleton<UserFirestoreDatasource>(
      () => UserFirestoreDatasource(),
    );
    sl.registerLazySingleton<UserRepository>(
      () => UserRepository(
        userFirestoreDatasource: sl<UserFirestoreDatasource>(),
      ),
    );
    sl.registerLazySingleton<AuthGateCubit>(
      () => AuthGateCubit(
        firebaseAuth: FirebaseAuth.instance,
        userRepository: sl<UserRepository>(),
      ),
    );
    sl.registerFactoryParam<EditProfileBloc, UserData, void>(
      (userData, _) => EditProfileBloc(
        userData: userData,
        userRepository: sl<UserRepository>(),
      ),
    );
    sl.registerFactoryParam<LinkedAccountBloc, List<AppAuthProvider>, void>(
      (appAuthProvider, _) => LinkedAccountBloc(
        userRepository: sl<UserRepository>(),
        appAuthProvider: appAuthProvider,
      ),
    );
  }
}
