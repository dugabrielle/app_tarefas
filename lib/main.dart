import 'package:app_tarefas/src/screens/forgot.dart';
import 'package:app_tarefas/src/screens/home.dart';
import 'package:app_tarefas/src/screens/login.dart';
import 'package:app_tarefas/src/screens/register.dart';
import 'package:app_tarefas/src/screens/welcome.dart';
import 'package:app_tarefas/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _darkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/':
            (context) => WelcomeScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode, // adicionar dps o provider
            ),
        '/login':
            (context) => LoginScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode, // adicionar dps o provider
            ),
        '/home':
            (context) => HomeScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode, // adicionar dps o provider
            ),
        '/register':
            (context) => RegisterScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode, // adicionar dps o provider
            ),
        '/forgot':
            (context) => ForgotPasswordScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode, // adicionar dps o provider
            ),
      },
    );
  }

  void _alternarTema() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }
}
