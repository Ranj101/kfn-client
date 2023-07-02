import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kurdistan_food_network/models/price_by_weight_response.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/auth_helpers.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.state,
    required this.name,
    required this.id,
    required this.picture,
    required this.producerName,
    required this.pricesByWeight,
  });

  final String id;
  final String name;
  final String state;
  final String picture;
  final String producerName;
  final List<PriceByWeightResponse> pricesByWeight;

  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    if (isAuth()) {
      return InkWell(
        onTap: () {
          context.goNamed(
            RouteConstants.product,
            pathParameters: {'id': id},
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 130,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var priceByWeight = pricesByWeight[index];

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${numberFormat.format(priceByWeight.value)}  dinar',
                                      style: const TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: kPrimarySmallBodyTextFontSize,
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    Text(
                                      '${numberFormat.format(priceByWeight.weight)}  kg',
                                      style: const TextStyle(
                                        color: kPrimaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: kPrimarySmallBodyTextFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                                if (pricesByWeight.length >= 4 && index < 3)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SizedBox(
                                      width: 230,
                                      child: Divider(
                                        height: 1,
                                        color:
                                            kPrimaryTextColor.withOpacity(0.1),
                                      ),
                                    ),
                                  )
                                else if (pricesByWeight.length < 4 &&
                                    index < (pricesByWeight.length - 1))
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SizedBox(
                                      width: 230,
                                      child: Divider(
                                        height: 2,
                                        color:
                                            kPrimaryTextColor.withOpacity(0.1),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                          itemCount: pricesByWeight.length >= 4
                              ? 4
                              : pricesByWeight.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var priceByWeight = pricesByWeight[index];

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${numberFormat.format(priceByWeight.value)}  dinar',
                                  style: const TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: kPrimarySmallBodyTextFontSize,
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Text(
                                  '${numberFormat.format(priceByWeight.weight)}  kg',
                                  style: const TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: kPrimarySmallBodyTextFontSize,
                                  ),
                                ),
                              ],
                            ),
                            if (pricesByWeight.length >= 4 && index < 3)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: SizedBox(
                                  width: 230,
                                  child: Divider(
                                    height: 1,
                                    color: kPrimaryTextColor.withOpacity(0.1),
                                  ),
                                ),
                              )
                            else if (pricesByWeight.length < 4 &&
                                index < (pricesByWeight.length - 1))
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: SizedBox(
                                  width: 230,
                                  child: Divider(
                                    height: 2,
                                    color: kPrimaryTextColor.withOpacity(0.1),
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                      itemCount: pricesByWeight.length >= 4
                          ? 4
                          : pricesByWeight.length,
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
