import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeKey = 'theme_mode';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  static Future<ThemeCubit> create() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_kThemeKey) ?? false;
    final cubit = ThemeCubit();
    if (isDark) cubit.emit(ThemeMode.dark);
    return cubit;
  }

  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kThemeKey, !isDark);
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
