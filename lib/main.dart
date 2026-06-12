import 'package:checkout_payment_by_paymab/MyBlocObserver.dart';
import 'package:checkout_payment_by_paymab/core/network/remote/dio_helper.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RegisterPage.routeName,

      routes: {RegisterPage.routeName: (context) => const RegisterPage()},
    );
  }
}
