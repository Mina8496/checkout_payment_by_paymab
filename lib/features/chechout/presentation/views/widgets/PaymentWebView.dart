import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentKey;
  const PaymentWebView({super.key, required this.paymentKey});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Started: $url");
          },
          onPageFinished: (url) {
            debugPrint("Finished: $url");
          },
          onNavigationRequest: (request) {
            debugPrint("Navigate: ${request.url}");
            if (request.url.contains("success")) {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/1047988?payment_token=${widget.paymentKey}',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدفع')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
