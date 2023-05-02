import 'package:another/constant/color.dart';
import 'package:another/screens/home_screen.dart';
import 'package:another/screens/running/challenge_running.dart';
import 'package:another/screens/running/running.dart';
import 'package:another/screens/running/under_challenge.dart';
import 'package:another/screens/running/under_running.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
        scaffoldBackgroundColor: BACKGROUND_COLOR,
        fontFamily: 'pretendard',
        textTheme: TextTheme(
            headline1: TextStyle(
          color: MAIN_COLOR,
          fontFamily: 'Pretendard',
          fontSize: 50.0,
        ))),
    routes: {
      '/': (context) => HomeScreen(),
      '/Detail': (context) => ChallengeRunning(),
      '/UnderRunning': (context) => UnderRunning(),
      '/UnderChallenge': (context) => UnderChallenge(),
    }
  ));
}
