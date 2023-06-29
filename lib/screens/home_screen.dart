import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Home'),
            Container(
              color: Color.fromARGB(120, 7, 143, 255),
              height: 600,
              width: double.infinity,
              padding: EdgeInsets.only(top: kCurrentHeight! / 5),
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Home Screen',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                      color: kPrimaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      final response = await HttpClient.get('/v1/self');
                      print(response.body);
                    },
                    style: elevatedButtonStyle,
                    child: const Text(
                      'get self',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: kPrimaryNavBarFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
