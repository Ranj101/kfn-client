import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Home'),
            const SizedBox(height: 50),
            const Text(
              'Local producers in your area',
              style: TextStyle(
                fontSize: kPrimaryTitleTextFontSize,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: kPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 60),
            Container(
              height: 600,
              padding: const EdgeInsets.symmetric(horizontal: 400),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(36.191113, 44.009167),
                    zoom: 8,
                    maxBounds: LatLngBounds(
                      LatLng(-90, -180),
                      LatLng(90, 180),
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80,
                          height: 80,
                          point: LatLng(36.191113, 44.009167),
                          builder: (ctx) => const Icon(
                            Icons.location_pin,
                            weight: 250,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Find local\nfood with ease.',
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          color: kPrimaryTextColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: SizedBox(
                          width: 450,
                          child: Text(
                            'The Kurdistan Food Network project was started to help local producers in the Kurdistan region of Iraq to gain more visibility and sell their goods and services to a wider audience.',
                            style: TextStyle(
                              fontSize: kPrimaryBodyTextFontSize,
                              fontWeight: FontWeight.w900,
                              height: 1.5,
                              color: kPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(RouteConstants.shop);
                        },
                        style: elevatedButtonStyle.copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(460, 60)),
                        ),
                        child: const Text(
                          'Shop now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryNavBarFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: ClipRRect(
                      child: Image(
                        image: AssetImage('assets/images/tomato_cropped.jpeg'),
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                width: 450,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'How to join our\nlocal producer\ncommunity',
                                      style: TextStyle(
                                        fontSize: kPrimaryTitleTextFontSize,
                                        fontWeight: FontWeight.w900,
                                        height: 1.2,
                                        color: kPrimaryTextColor,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: Text(
                                        'Just 3 simple steps to become a local producer.',
                                        style: TextStyle(
                                          fontSize: kPrimaryBodyTextFontSize,
                                          fontWeight: FontWeight.w900,
                                          height: 1.2,
                                          color: kPrimaryTextColor,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: elevatedButtonStyle.copyWith(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(460, 60)),
                                      ),
                                      child: const Text(
                                        'Submit producer approval request',
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
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 80),
                              child: SizedBox(
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Step 1',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: kPrimaryTitleTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      'Register using your email.',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      child: Divider(),
                                    ),
                                    Text(
                                      'Step 2',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: kPrimaryTitleTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      'Submit a producer approval request.',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      child: Divider(),
                                    ),
                                    Text(
                                      'Step 3',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: kPrimaryTitleTextFontSize,
                                      ),
                                    ),
                                    Text(
                                      'As soon as our team is done reviewing your request you will be ready to display your producets!',
                                      style: TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 400),
                    child: ClipRRect(
                      borderRadius: kPrimaryBorderRadius,
                      child: const Image(
                        image: AssetImage(
                            'assets/images/kurdish_producer_truck.jpg'),
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
