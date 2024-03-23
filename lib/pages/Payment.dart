import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/config.dart';
import 'package:mobile/services/payment_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key, required this.url});

  final String url;
  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {

  late final WebViewController controller;
@override
  void initState() {
    super.initState();
    print('initing...');
    initController();
  }

  void initController() {
    
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse(widget.url))
  ..setNavigationDelegate(NavigationDelegate(
     onPageFinished: (String url) {
        if (url.toLowerCase().contains(Config.webURL))
          {
            if (url.toLowerCase().contains('success')) print("purchased");
            if (url.toLowerCase().contains('failed')) print(" failed purchase");
          } 
      },
    )
  );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}