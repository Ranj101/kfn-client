import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class ProducerCard extends StatelessWidget {
  const ProducerCard({
    super.key,
    required this.id,
    required this.name,
    required this.locations,
    required this.openingTime,
    required this.closingTime,
  });

  final String id;
  final String name;
  final List<String> locations;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(
          RouteConstants.producerPublic,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 36, top: 10, bottom: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: kPrimaryBodyTextFontSize,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Locations',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: kPrimarySmallBodyTextFontSize,
                        ),
                      ),
                      Text(
                        locations[0],
                        style: const TextStyle(
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: kPrimarySmallBodyTextFontSize,
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
                          Text('Opening Time - ${openingTime.format(context)}'),
                          Text('Closing Time - ${closingTime.format(context)}'),
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
