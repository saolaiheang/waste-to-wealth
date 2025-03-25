import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_to_wealth/bloc/user_bloc.dart';
import 'package:waste_to_wealth/screen/history.dart';
import 'package:waste_to_wealth/screen/homescreen.dart';
import 'package:waste_to_wealth/screen/login.dart';
import 'package:waste_to_wealth/screen/pickup.dart';
import 'package:waste_to_wealth/screen/social.dart';

import 'package:waste_to_wealth/screen/splashscreen.dart'; // Ensure this file exists

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MultiBlocProvider(
      providers: [BlocProvider<UserBloc>(create: (context) => UserBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash', 

        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/pickup': (context) => SchedulePickupScreen(),
          '/istory': (context) => PickupScheduleHistory(),
          '/social': (context) => SocialPage(),
        },
      ),
    );
  }
}
