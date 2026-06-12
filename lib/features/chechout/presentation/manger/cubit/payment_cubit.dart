import 'package:checkout_payment_by_paymab/core/network/remote/dio_helper.dart';
import 'package:checkout_payment_by_paymab/core/utils/constant/api_key.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/manger/cubit/payment_state.dart';
import 'package:checkout_payment_by_paymab/features/chechout/presentation/views/widgets/PaymentWebView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<String> getAuthToken() async {
    final response = await DioHelper.postData(
      endPoint: "auth/tokens",
      data: {'api_key': paymobApiKey},
    );
    return response.data['token'];
  }

  Future<int> createOrder(String token, int amountCents) async {
    final response = await DioHelper.postData(
      endPoint: "ecommerce/orders",
      data: {
        'auth_token': token,
        'delivery_needed': false,
        'amount_cents': amountCents,
        'currency': 'EGP',
        'items': [],
      },
    );
    return response.data['id'];
  }

  Future<String> getPaymentKey(
    String token,
    int orderId,
    int amountCents,
  ) async {
    final response = await DioHelper.postData(
      endPoint: "acceptance/payment_keys",
      data: {
        'auth_token': token,
        'amount_cents': amountCents,
        'expiration': 3600,
        'order_id': orderId,
        'currency': 'EGP',
        'integration_id': integrationCardID,
        'billing_data': {
          'first_name': 'Test',
          'last_name': 'User',
          'email': 'test@test.com',
          'phone_number': '01000000000',
          'country': 'EG',
          'city': 'Cairo',
          'street': 'NA',
          'building': 'NA',
          'floor': 'NA',
          'apartment': 'NA',
        },
      },
    );

    return response.data['token'];
  }

  Future<void> startPayment(BuildContext context) async {
    try {
      emit(PaymentLoadingAuthToken());

      final authToken = await getAuthToken();
      final orderId = await createOrder(authToken, 10000);
      final paymentKey = await getPaymentKey(authToken, orderId, 10000);

      emit(PaymentSuccessAuthToken());

      // افتح الـ WebView
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentWebView(paymentKey: paymentKey),
        ),
      );

      if (result == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('✅ تم الدفع بنجاح!')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('❌ فشل الدفع')));
      }
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);

      emit(PaymentErrorAuthToken(e.response?.data.toString() ?? 'حدث خطأ'));
    }
  }
}
