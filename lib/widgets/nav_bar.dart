import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/auth_helpers.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.currentScreen});

  final String currentScreen;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (p0) => desktopNavBar(),
      mobile: (p0) => desktopNavBar(),
    );
  }

  // =========== Desktop ===========

  Widget desktopNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: isAuth()
              ? buildDesktopNavBarAuthenticated()
              : buildDesktopNavBar()),
    );
  }

  // =========== Desktop Nav builders ===========

  List<Widget> buildDesktopNavBar() {
    return [
      createLogo(context),
      Row(
        children: [
          createNavButton('Home', RouteConstants.home),
          createNavButton('Shop', RouteConstants.shop),
          createNavButton('Contact', RouteConstants.contact),
        ],
      ),
      Row(
        children: [
          createNavButton('Login', RouteConstants.login),
          createElevatedNavButton('Register', RouteConstants.register),
        ],
      )
    ];
  }

  List<Widget> buildDesktopNavBarAuthenticated() {
    return [
      createLogo(context),
      Row(
        children: [
          createNavButton('Home', RouteConstants.home),
          createNavButton('Audit', RouteConstants.audit),
          createNavButton('Shop', RouteConstants.shop),
          createNavButton('Profile', RouteConstants.profile),
          createNavButton('Producer', RouteConstants.producer),
          createNavButton('Contact', RouteConstants.contact),
        ],
      ),
      Row(
        children: [
          createShoppingBagButton(),
          const SizedBox(width: 20),
          createLogoutButton(),
        ],
      )
    ];
  }

  // =========== Components ===========

  Widget createLogo(BuildContext context) {
    return const Text(
      textAlign: TextAlign.center,
      'Kurdistan Food\nNetwork',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        height: 1.2,
        color: kPrimaryColor,
      ),
    );
  }

  Widget createNavButton(String text, String destination) {
    var textColor = kPrimaryTextColor;

    if (widget.currentScreen == text) {
      textColor = kPrimaryColor;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: () {
          context.goNamed(destination);
        },
        child: SizedBox(
          width: 100,
          height: 55,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: kPrimaryNavBarFontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createElevatedNavButton(String text, String destination) {
    var style = elevatedButtonStyle;
    var color = Colors.white;

    if (widget.currentScreen == text) {
      style = shoppingBagButtonStyle;
      color = kPrimaryColor;
    }

    return ElevatedButton(
      onPressed: () => context.goNamed(destination),
      style: style,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: kPrimaryNavBarFontSize,
        ),
      ),
    );
  }

  Widget createShoppingBagButton() {
    var textColor = kPrimaryTextColor;

    if (widget.currentScreen == 'ShoppingBag') {
      textColor = kPrimaryColor;
    }

    return ElevatedButton.icon(
      onPressed: () => context.goNamed(RouteConstants.shoppingBag),
      icon: Icon(
        size: 25,
        Icons.shopping_cart_sharp,
        color: textColor,
      ),
      style: shoppingBagButtonStyle,
      label: Text(
        'Shopping Bag',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.normal,
          fontSize: kPrimaryNavBarFontSize,
        ),
      ),
    );
  }

  Widget createLogoutButton() {
    return ElevatedButton(
      onPressed: () async {
        FirebaseAuth.instance.signOut();
        setState(() {});
        context.goNamed(RouteConstants.home);
      },
      style: elevatedButtonStyle,
      child: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: kPrimaryNavBarFontSize,
        ),
      ),
    );
  }
}
