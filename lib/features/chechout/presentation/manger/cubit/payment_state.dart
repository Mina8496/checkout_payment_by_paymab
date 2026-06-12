abstract class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoadingAuthToken extends PaymentState {}

final class PaymentSuccessAuthToken extends PaymentState {}

final class PaymentErrorAuthToken extends PaymentState {
  final String errMessage;

  PaymentErrorAuthToken(this.errMessage);
}

final class LoadingOrderID extends PaymentState {}

final class SuccessOrderID extends PaymentState {}

final class ErrorOrderID extends PaymentState {
  final String errMessage;

  ErrorOrderID(this.errMessage);
}

final class LoadingRquestTokenPaymentState extends PaymentState {}

final class SuccessRquestTokenPaymentState extends PaymentState {}

final class ErrorRquestTokenPaymentState extends PaymentState {
  final String errMessage;

  ErrorRquestTokenPaymentState(this.errMessage);
}


