import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/viewModels/learning/settings/settings_bloc.dart';
import 'package:english_mate/viewModels/learning/settings/settings_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final Map<AppThemeMode, String> _nameOfAppTheme = {
    AppThemeMode.light: 'Sáng',
    AppThemeMode.dark: 'Tối',
    AppThemeMode.pink: 'Hồng',
  };
  @override
  Widget build(BuildContext context) {
    final current = context.read<SettingsBloc>().state.appThemeMode;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Giao diện",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownMenu<AppThemeMode>(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    width: double.infinity,
                    initialSelection: current,
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onSelected: (m) {
                      if (m != null) {
                        context.read<SettingsBloc>().add(
                          ThemeChanged(appThemeMode: m),
                        );
                      }
                    },
                    dropdownMenuEntries: AppThemeMode.values.map((mode) {
                      return DropdownMenuEntry<AppThemeMode>(
                        value: mode,
                        label: _nameOfAppTheme[mode]!,
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
