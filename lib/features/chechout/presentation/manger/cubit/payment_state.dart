abstract class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoadingAuthToken extends PaymentState {}

final class PaymentSuccessAuthToken extends PaymentState {}

final class PaymentErrorAuthToken extends PaymentState {
  final String errMessage;

  PaymentErrorAuthToken(this.errMessage);
}


