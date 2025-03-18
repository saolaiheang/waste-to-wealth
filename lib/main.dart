import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screen/home.dart';
import './screen/login.dart';
import 'package:waste_to_wealth/bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<UserBloc>(create: (context) => UserBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
