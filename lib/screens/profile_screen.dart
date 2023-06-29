import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Profile'),
            Container(
              color: const Color.fromARGB(120, 255, 193, 7),
              height: 600,
              child: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Profile Screen',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                    color: kPrimaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
