// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

//   double _progress =0;
//   late InAppWebViewController inAppWebViewController;
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           InAppWebView(
//             initialUrlRequest: URLRequest(
//               url: WebUri("http://localhost:5000/auth/facebook/")
//             ),
//             onWebViewCreated: (InAppWebViewController controller) {
//               inAppWebViewController = controller;
//             },
//             onProgressChanged: (InAppWebViewController controller, int progress) {
//                 setState(() {
//                   _progress = progress / 100;
//                 });
//             },
//           )
//         ],
//       )
//     );
//   }
// }
  