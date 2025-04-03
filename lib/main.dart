import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app_tarefas/src/screens/forgot.dart';
import 'package:app_tarefas/src/screens/home.dart';
import 'package:app_tarefas/src/screens/login.dart';
import 'package:app_tarefas/src/screens/register.dart';
import 'package:app_tarefas/src/screens/welcome.dart';
import 'package:app_tarefas/src/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        // add provider depois
        '/':
            (context) =>
                WelcomeScreen(alternarTema: _alternarTema, darkMode: _darkMode),
        '/login':
            (context) =>
                LoginScreen(alternarTema: _alternarTema, darkMode: _darkMode),
        '/home':
            (context) =>
                HomeScreen(alternarTema: _alternarTema, darkMode: _darkMode),
        '/register':
            (context) => RegisterScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode,
            ),
        '/forgot':
            (context) => ForgotPasswordScreen(
              alternarTema: _alternarTema,
              darkMode: _darkMode,
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
