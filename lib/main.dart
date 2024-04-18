import 'package:flutter/material.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/pages/Payment.dart';
import 'package:mobile/pages/call/call_page.dart';
import 'package:mobile/pages/car/cars_listing.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news/news.dart';
import 'package:mobile/pages/permission/Employee_permission.dart';
import 'package:mobile/pages/register.dart';
import 'package:mobile/pages/main_home.dart';
import 'package:mobile/pages/salon/new_salon.dart';
import 'package:mobile/pages/salon/salon_list.dart';
import 'package:mobile/widgets/introduction_car.dart';
import 'package:mobile/pages/manage.dart';
import 'package:mobile/pages/chat/list_chat_users.dart';
import 'package:mobile/pages/notification.dart';
import 'package:mobile/pages/user_info.dart';
import 'package:mobile/pages/appointment/appointment.dart';
import 'package:mobile/pages/car/car_detail.dart';
import 'package:mobile/pages/package/buy_package.dart';
import 'package:mobile/pages/package/all_packages.dart';
import 'package:mobile/pages/link_social.dart';
import 'package:mobile/pages/setting.dart';
import 'package:mobile/pages/package/manage_package.dart';
import 'package:mobile/pages/chat/chat.dart';
import 'package:mobile/widgets/home.dart';
import 'package:mobile/widgets/webView.dart';
import 'package:mobile/pages/salon/salon_detail.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:mobile/pages/appointment/create_appointment.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

      runApp(MyApp(navigatorKey: navigatorKey));
   });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => Register(),
        '/mhome': (context) => MainHome(),
        '/news': (context) => NewsBoard(),
        '/listing/manage': (context) => CarsListing(),
        '/listing': (context) => IntroCar(),
        '/manage': (context) => Manage(),
        '/message': (context) => Message(),
        '/notification': (context) => Noti(),
        '/user_info': (context) => UserInfo(),
        '/appointment': (context) => Appointment(),
        '/car_detail': (context) => CarDetail(),
        '/buy_package': (context) => BuyPackage(),
        '/packages': (context) => AllPackages(),
        'social': (context) => Social(),
        '/setting': (context) => Setting(),
        '/package/manage': (context) => ManagePackage(),
        '/chat': (context) => ChatPage(),
        '/fblogin': (context) => WebViewContainer(),
        '/salons': (context) => SalonList(),
        '/salon_detail' : (context) => SalonDetail(),
        '/new_salon': (context) => NewSalon(),
        '/my_salon': (context) =>  MySalon(),
        '/call_page': (context) => CallPage(callID: '111'),
        '/create_appointment': (context) => CreateAppoint(),
        '/employee_management' : (context) => AdminPage()
      },
    );
  }
}






// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:convert' show json;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile/pages/login.dart';

// //import 'src/sign_in_button.dart';

// /// The scopes required by this application.
// // #docregion Initialize
// const List<String> scopes = <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly',
// ];

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: 'your-client_id.apps.googleusercontent.com',
//   scopes: scopes,
// );
// // #enddocregion Initialize

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }

// /// The SignInDemo app.
// class SignInDemo extends StatefulWidget {
//   ///
//   const SignInDemo({super.key});

//   @override
//   State createState() => _SignInDemoState();
// }

// class _SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount? _currentUser;
//   bool _isAuthorized = false; // has granted permissions?
//   String _contactText = '';

//   @override
//   void initState() {
//     super.initState();

//     _googleSignIn.onCurrentUserChanged
//         .listen((GoogleSignInAccount? account) async {
// // #docregion CanAccessScopes
//       // In mobile, being authenticated means being authorized...
//       bool isAuthorized = account != null;
//       // However, on web...
//       if (kIsWeb && account != null) {
//         isAuthorized = await _googleSignIn.canAccessScopes(scopes);
//       }
// // #enddocregion CanAccessScopes

//       setState(() {
//         _currentUser = account;
//         _isAuthorized = isAuthorized;
//       });

//       // Now that we know that the user can access the required scopes, the app
//       // can call the REST API.
//       if (isAuthorized) {
//         unawaited(_handleGetContact(account!));
//       }
//     });

//     // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
//     //
//     // It is recommended by Google Identity Services to render both the One Tap UX
//     // and the Google Sign In button together to "reduce friction and improve
//     // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
//     _googleSignIn.signInSilently();
//   }

//   // Calls the People API REST endpoint for the signed-in user to retrieve information.
//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       _contactText = 'Loading contact info...';
//     });
//     final http.Response response = await http.get(
//       Uri.parse('https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names'),
//       headers: await user.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = 'People API gave a ${response.statusCode} '
//             'response. Check logs for details.';
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data =
//         json.decode(response.body) as Map<String, dynamic>;
//     final String? namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = 'I see you know $namedContact!';
//       } else {
//         _contactText = 'No contacts to display.';
//       }
//     });
//   }

//   String? _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic>? connections = data['connections'] as List<dynamic>?;
//     final Map<String, dynamic>? contact = connections?.firstWhere(
//       (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
//       orElse: () => null,
//     ) as Map<String, dynamic>?;
//     if (contact != null) {
//       final List<dynamic> names = contact['names'] as List<dynamic>;
//       final Map<String, dynamic>? name = names.firstWhere(
//         (dynamic name) =>
//             (name as Map<Object?, dynamic>)['displayName'] != null,
//         orElse: () => null,
//       ) as Map<String, dynamic>?;
//       if (name != null) {
//         return name['displayName'] as String?;
//       }
//     }
//     return null;
//   }

//   // This is the on-click handler for the Sign In button that is rendered by Flutter.
//   //
//   // On the web, the on-click handler of the Sign In button is owned by the JS
//   // SDK, so this method can be considered mobile only.
//   // #docregion SignIn
//   Future<void> _handleSignIn() async {
//     try {
//       final result = await _googleSignIn.signIn();
//       final ggAuth = await result!.authentication;
//       print(ggAuth.idToken);
//       print(ggAuth.accessToken);
//     } catch (error) {
//       print(error);
//     }
//   }
//   // #enddocregion SignIn

//   // Prompts the user to authorize `scopes`.
//   //
//   // This action is **required** in platforms that don't perform Authentication
//   // and Authorization at the same time (like the web).
//   //
//   // On the web, this must be called from an user interaction (button click).
//   // #docregion RequestScopes
//   Future<void> _handleAuthorizeScopes() async {
//     final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
//     // #enddocregion RequestScopes
//     setState(() {
//       _isAuthorized = isAuthorized;
//     });
//     // #docregion RequestScopes
//     if (isAuthorized) {
//       unawaited(_handleGetContact(_currentUser!));
//     }
//     // #enddocregion RequestScopes
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     final GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       // The user is Authenticated
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text('Signed in successfully.'),
//           if (_isAuthorized) ...<Widget>[
//             // The user has Authorized all required scopes
//             Text(_contactText),
//             ElevatedButton(
//               child: const Text('REFRESH'),
//               onPressed: () => _handleGetContact(user),
//             ),
//           ],
//           if (!_isAuthorized) ...<Widget>[
//             // The user has NOT Authorized all required scopes.
//             // (Mobile users may never see this button!)
//             const Text('Additional permissions needed to read your contacts.'),
//             ElevatedButton(
//               onPressed: _handleAuthorizeScopes,
//               child: const Text('REQUEST PERMISSIONS'),
//             ),
//           ],
//           ElevatedButton(
//             onPressed: _handleSignOut,
//             child: const Text('SIGN OUT'),
//           ),
//         ],
//       );
//     } else {
//       // The user is NOT Authenticated
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text('You are not currently signed in.'),
//           // This method is used to separate mobile from web code with conditional exports.
//           // See: src/sign_in_button.dart
//           TextButton(
//             child: Text("Sign in"),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }
