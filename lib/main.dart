import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screen/home.dart';
import './screen/login.dart';
import 'package:waste_to_wealth/bloc/user_bloc.dart';
import 'package:waste_to_wealth/screen/pickup.dart';

import 'package:waste_to_wealth/screen/history.dart';

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
        initialRoute: '/history',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/pickup': (context) => SchedulePickupScreen(),
          '/history': (context) =>  PickupScheduleHistory(),
        },
      ),
    );
  }
}
