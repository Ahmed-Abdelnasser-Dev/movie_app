import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Simple cubit to toggle between light and dark ThemeMode
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggle() {
    final current = state;
    if (current == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  void set(ThemeMode mode) => emit(mode);
}
