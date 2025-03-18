import 'package:flutter/material.dart';
import './screen/home.dart';
import './screen/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  initialRoute:'/login',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      }
      
    );
  }}
