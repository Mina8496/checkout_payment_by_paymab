import 'package:checkout_payment_by_paymab/core/utils/styles.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/my_cart_view_body.dart';
import 'package:flutter/material.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_outlined),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('My card', style: Styles.style25),
      ),
      body: MyCartViewBody(),
    );
  }
}
