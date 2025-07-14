import 'package:flutter/material.dart';
import 'package:game_tracker/models/game_provider.dart';
import 'package:game_tracker/models/theme_provider.dart';
import 'package:game_tracker/screens/initial_screen.dart';
import 'package:game_tracker/themes/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()..loadGames()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Game_Tracker',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: InitialScreen(),
        );
      },
    );
  }
}
