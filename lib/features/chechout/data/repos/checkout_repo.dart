import 'package:checkout_payment_by_paymab/core/errors/failures.dart';
import 'package:checkout_payment_by_paymab/features/chechout/data/models/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
