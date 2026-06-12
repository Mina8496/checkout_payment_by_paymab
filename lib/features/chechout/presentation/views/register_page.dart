import 'package:checkout_payment_by_paymab/features/chechout/model/data/billing_data_model.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_cubit.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_state.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = 'register';
  RegisterPage({super.key});

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();

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
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: "First Name"),
                  ),

                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: "Last Name"),
                  ),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),

                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: "Phone"),
                  ),

                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: "City"),
                  ),

                  TextFormField(
                    controller: streetController,
                    decoration: const InputDecoration(labelText: "Street"),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Complete Payment",
                    onTap: () {
                      final billing = BillingDataModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        city: cityController.text,
                        street: streetController.text,
                      );

                      PaymentCubit.get(context).startPayment(context, billing);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
