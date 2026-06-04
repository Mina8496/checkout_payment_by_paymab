import 'package:checkout_payment_by_paymab/core/utils/styles.dart';
import 'package:flutter/material.dart';

class OrderInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const OrderInfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Styles.style18),
        Spacer(),
        Text(value, style: Styles.style18),
      ],
    );
  }
}
