import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kCurrentHeight! / 4),
      child: const SizedBox(
        width: 150,
        child: LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          colors: [kPrimaryColor],
          strokeWidth: 6,
        ),
      ),
    );
  }
}
