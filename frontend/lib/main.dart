import 'package:flutter/material.dart';
import 'package:login_app/login_page.dart';
import 'package:login_app/signup_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes: {
        '/' : (context) => const LoginPage(),
        '/register' : (context) => const SignupPage(),
      },
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }


