import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class ProducerCard extends StatelessWidget {
  const ProducerCard({
    super.key,
    required this.name,
    required this.locations,
    required this.openingTime,
    required this.closingTime,
  });

  final String name;
  final List<String> locations;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: kPrimaryBodyTextFontSize,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Locations',
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: kPrimarySmallBodyText,
                              ),
                            ),
                            Text(
                              locations[0],
                              style: const TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: kPrimarySmallBodyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Opening Time: ${openingTime.format(context)}'),
                          Text('Closing Time: ${closingTime.format(context)}'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
