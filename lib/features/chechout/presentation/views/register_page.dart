import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_cubit.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_state.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = 'register';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentCubit>(
      create: (context) => PaymentCubit()..getAuthToken(),

      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentLoadingAuthToken) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('Loading...'),
                  ],
                ),
              ),
            );
          }
          if (state is PaymentSuccessAuthToken) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Auth Token Loaded Successfully')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text("Registr Page")),
            body: CustomButton(
              text: 'Complete Payment',
              onTap: () {
                PaymentCubit.get(context).startPayment(context);
              },
            ),
          );
        },
      ),
    );
  }
}
