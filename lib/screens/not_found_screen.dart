import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'NotFound'),
            Container(
              height: 600,
              width: double.infinity,
              padding: EdgeInsets.only(top: kCurrentHeight! / 5),
              child: const Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Page Not Found',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                      color: kPrimaryTextColor,
                    ),
                  ),
                  Icon(Icons.search_off, size: 200)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
