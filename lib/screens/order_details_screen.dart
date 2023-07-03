import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/models/order_response.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';
import 'package:kurdistan_food_network/widgets/order_info_product.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {super.key, required this.orderId, required this.producerId});

  final String orderId;
  final String producerId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool loading = true;
  OrderResponse? order;

  Future<bool> getOrderById() async {
    final response = await HttpClient.get('/v1/orders/${widget.orderId}');

    if (response.isSuccessful) {
      order = OrderResponse.fromJson(response.body);

      loading = false;
      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  Future<bool> ApproveOrder() async {
    final response = await HttpClient.patch('/v1/orders/${widget.orderId}',
        body: jsonEncode({"trigger": "Approve"}));

    if (response.isSuccessful) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: 300,
          backgroundColor: kPrimaryTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          content: const Center(child: Text("Order approved successfully")),
        ),
      );

      setState(() {});

      context.goNamed(RouteConstants.manageOrders,
          pathParameters: {'id': widget.producerId});

      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeclineOrder() async {
    final response = await HttpClient.patch('/v1/orders/${widget.orderId}',
        body: jsonEncode({"trigger": "Decline"}));

    if (response.isSuccessful) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: 300,
          backgroundColor: kPrimaryTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          content: const Center(child: Text("Order declined successfully")),
        ),
      );

      setState(() {});

      context.goNamed(RouteConstants.manageOrders,
          pathParameters: {'id': widget.producerId});

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getOrderById();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(currentScreen: 'order-detail'),
              LoadIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'order-detail'),
            const SizedBox(height: 50),
            const Text(
              'Order Information',
              style: TextStyle(
                fontSize: kPrimaryTitleTextFontSize,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: kPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 80, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Identifier:',
                            style: TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryBodyTextFontSize,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Location:',
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: kPrimaryBodyTextFontSize,
                              ),
                            ),
                          ),
                          Text(
                            'Pickup time:',
                            style: TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryBodyTextFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order!.id,
                          style: const TextStyle(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryBodyTextFontSize,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            order!.location,
                            style: const TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryBodyTextFontSize,
                            ),
                          ),
                        ),
                        Text(
                          order!.pickupTime,
                          style: const TextStyle(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryBodyTextFontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 80, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price:',
                            style: TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryBodyTextFontSize,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Status:',
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: kPrimaryBodyTextFontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${order!.totalPrice} dinar',
                          style: const TextStyle(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryBodyTextFontSize,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            order!.state,
                            style: const TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryBodyTextFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ApproveOrder();
                      },
                      style: elevatedButtonStyle.copyWith(
                        minimumSize:
                            MaterialStateProperty.all(const Size(260, 60)),
                      ),
                      child: const Text(
                        'Approve Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: kPrimaryNavBarFontSize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          DeclineOrder();
                        },
                        style: elevatedButtonStyle.copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(260, 60)),
                        ),
                        child: const Text(
                          'Decline Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryNavBarFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = order!.products[index];

                return OrderInfoProductCard(
                  id: product.id,
                  name: product.name,
                  state: product.state,
                  picture: product.picture,
                  producerName: product.producerName,
                );
              },
              itemCount: order!.products.length,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
