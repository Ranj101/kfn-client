import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Shop'),
            Container(
              color: const Color.fromARGB(120, 255, 193, 7),
              height: 600,
              child: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Shop Screen',
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
