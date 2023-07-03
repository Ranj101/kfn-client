import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class OrderInfoProductCard extends StatelessWidget {
  OrderInfoProductCard(
      {super.key,
      required this.state,
      required this.name,
      required this.id,
      required this.picture,
      required this.producerName});

  final String id;
  final String name;
  final String state;
  final String picture;
  final String producerName;

  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: ClipRRect(
                    borderRadius: kPrimaryBorderRadius,
                    child: Image.network(
                      picture,
                      alignment: FractionalOffset.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: kPrimaryBodyTextFontSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    producerName,
                    style: const TextStyle(
                      color: kPrimaryTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: kPrimarySmallBodyTextFontSize,
                    ),
                  ),
                ),
                if (state == 'Available')
                  Chip(
                    visualDensity:
                        const VisualDensity(horizontal: 0.0, vertical: -4),
                    avatar: const Icon(
                      Icons.lock_open,
                      color: kPrimaryColor,
                      size: 15,
                    ),
                    label: Text(
                      state,
                      style: const TextStyle(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  )
                else
                  Chip(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    avatar: const Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                      size: 14,
                    ),
                    label: Text(
                      state,
                      style: const TextStyle(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
