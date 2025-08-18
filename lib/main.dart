import 'package:english_mate/config/di.dart';
import 'package:english_mate/config/theme/app_themes.dart';
import 'package:english_mate/models/words/definition_part.dart';
import 'package:english_mate/models/words/meaning.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/navigation/app_router.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'package:english_mate/core/services/vocab_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(MeaningAdapter());
  Hive.registerAdapter(DefinitionPartAdapter());

  await Hive.openBox<Word>('wordsBox');

  await VocabLoader.loadIfNeeded(); // load bộ từ vựng duy nhất một lần
  await DI().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final gate = DI().sl<AuthGateCubit>();

    return MultiBlocProvider(
      providers: [BlocProvider.value(value: gate)],
      child: MaterialApp.router(
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.build(gate),
      ),
    );
  }
}
