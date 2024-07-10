import 'package:flutter/material.dart';
import './texts.dart';
import './colors.dart';

final textTheme = MyAppTextTheme.getTextTheme();
final ThemeData lightMode = MaterialTheme(textTheme).light();
final ThemeData darkMode = MaterialTheme(textTheme).dark();
