import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.id,
      required this.totalPrice,
      required this.location,
      required this.state,
      required this.producerId});

  final String id;
  final double totalPrice;
  final String location;
  final String state;
  final String producerId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(
          RouteConstants.orderInfo,
          pathParameters: {'orderId': id, 'producerId': producerId},
        );
      },
      splashColor: kPrimaryColor.withOpacity(0.4),
      borderRadius: kPrimaryBorderRadius,
      hoverColor: kPrimaryTextColor.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kPrimaryTextColor.withOpacity(0.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: kPrimaryBorderRadius,
            side: BorderSide(
              color: kPrimaryTextColor.withOpacity(0.2),
            ),
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                id,
                style: const TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kPrimarySmallBodyTextFontSize,
                ),
              ),
              Text(
                totalPrice.toString(),
                style: const TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kPrimarySmallBodyTextFontSize,
                ),
              ),
              Text(
                location,
                style: const TextStyle(
                  color: kPrimaryTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: kPrimarySmallBodyTextFontSize,
                ),
              ),
              Text(state),
            ],
          ),
        ),
      ),
    );
  }
}
