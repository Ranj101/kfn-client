import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/options/firebase_options.dart';
import 'package:kurdistan_food_network/routes/route_configs.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: kApplicationTheme,
      title: 'Kurdistan Food Network',
      debugShowCheckedModeBanner: false,
      routerConfig: RouteConfigs().router,
    );
  }
}
