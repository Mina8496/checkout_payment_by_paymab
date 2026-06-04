import 'package:checkout_payment_by_paymab/features/chechout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_cubit.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  Scaffold(body: Center(child: Text('Payment Success'))),
            ),
          );
        }
        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          isLoading: state is PaymentLoading ? true : false,
          text: 'Continue',
          onTap: () {
            print('Before Cubit');

            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(amount: "100", currency: 'USD');

            BlocProvider.of<PaymentCubit>(
              context,
            ).makePayment(paymentIntentInputModel: paymentIntentInputModel);

            print('After Cubit');
          },
        );
      },
    );
  }
}
