import 'package:checkout_payment_by_paymab/core/utils/styles.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final String title, value;
  const TotalPrice({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, textAlign: TextAlign.center, style: Styles.style24),
        Spacer(),
        Text(value, textAlign: TextAlign.center, style: Styles.style24),
      ],
    );
  }
}
