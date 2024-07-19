import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const FlexScheme _scheme = FlexScheme.greenM3;

final ThemeData themeData = FlexThemeData.light(scheme: _scheme);

final ThemeData darkThemeData = FlexThemeData.dark(scheme: _scheme);