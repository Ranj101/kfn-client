import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'ShoppingBag'),
            Container(
              color: const Color.fromARGB(120, 255, 193, 7),
              height: 600,
              child: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Shopping Bag Screen',
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
