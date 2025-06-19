import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/counter_page.dart';
// import 'pages/todo_page.dart';
// import 'pages/shopping_cart_page.dart';
import 'pages/user_profile_page.dart';
import 'pages/theme_settings_page.dart';
import 'pages/form_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/counter': (context) => const CounterPage(),
        // '/todo': (context) => const TodoPage(),
        // '/cart': (context) => const ShoppingCartPage(),
        '/profile': (context) => const UserProfilePage(),
        '/settings': (context) => const ThemeSettingsPage(),
        '/form': (context) => const FormPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}