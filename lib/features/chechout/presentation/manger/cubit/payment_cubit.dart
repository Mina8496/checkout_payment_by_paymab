import 'dart:developer';
import 'package:checkout_payment_by_paymab/features/chechout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_by_paymab/features/chechout/data/repos/checkout_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());

    print("Payment Started");

    var data = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );

    print("Payment Response Received");

    data.fold(
      (l) {
        print("Payment Error: ${l.errMessage}");
        emit(PaymentFailure(l.errMessage));
      },
      (r) {
        print("Payment Success");
        emit(PaymentSuccess());
      },
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
