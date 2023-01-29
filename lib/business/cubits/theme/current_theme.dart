import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'themes.dart';

///[CurrentThemeBloc] helps in maintaining dynamic theme switching between light and dark themes
class CurrentThemeBloc extends Cubit<ThemeStyle> {
  static final ThemeStyle _lightTheme = ThemeStyle(isLight: true);
  static final ThemeStyle _darkTheme = ThemeStyle(isLight: false);

  CurrentThemeBloc() : super(_darkTheme);

  ///Switch between light and dark [ThemeStyle]
  void switchTheme() {
    emit(state == _lightTheme ? _darkTheme : _lightTheme);
  }
}
