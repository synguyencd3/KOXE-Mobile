import 'package:flutter/material.dart';
import 'package:mobile/model/salon_model.dart';
import 'package:mobile/pages/Car%20Invoice/car_invoice.dart';
import 'package:mobile/pages/Car%20Invoice/newCar_invoice.dart';
import 'package:mobile/pages/Car%20Invoice/user_car_invoice.dart';
import 'package:mobile/pages/Payment.dart';
import 'package:mobile/pages/call/call_page.dart';
import 'package:mobile/pages/car/cars_listing.dart';
import 'package:mobile/pages/car/edit_car.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/news/news.dart';
import 'package:mobile/pages/permission/Employee_permission.dart';
import 'package:mobile/pages/process/create_process.dart';
import 'package:mobile/pages/process/process_list.dart';
import 'package:mobile/pages/register.dart';
import 'package:mobile/pages/main_home.dart';
import 'package:mobile/pages/salon/new_salon.dart';
import 'package:mobile/pages/salon/salon_list.dart';
import 'package:mobile/pages/statistic/statistic_page.dart';
import 'package:mobile/pages/warranty/Warranty_form.dart';
import 'package:mobile/pages/warranty/warranty_list.dart';
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
import 'package:mobile/pages/warranty/warranty_manage.dart';
import 'package:mobile/pages/maintaince/maintaince_manage.dart';
import 'package:mobile/pages/accessory_manage.dart';
import 'package:mobile/pages/user_manage.dart';
import 'package:mobile/pages/post/post_detail.dart';
import 'package:mobile/pages/post/create_post.dart';
import 'package:mobile/pages/connection/connection.dart';
import 'package:mobile/pages/transaction/transaction.dart';
import 'package:mobile/pages/transaction/transaction_detail.dart';
import 'package:mobile/pages/blocked_user.dart';
import 'package:mobile/pages/password/change_password.dart';
import 'package:mobile/pages/password/verify_password.dart';
import 'package:mobile/pages/password/new_password.dart';
import 'package:mobile/pages/appointment/create_appointment_process.dart';
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
        '/social': (context) => Social(),
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
        '/employee_management' : (context) => AdminPage(),
        '/warranty_manage' : (context) => WarrantyManage(),
        '/warranty_list' : (context) => WarrantyList(),
        '/warranty_form' : (context) => WarrantyForm(),
        '/statistic' : (context) => Statistic(),
        '/maintaince_manage' : (context) => MaintainceManage(),
        '/accessory_manage' : (context) => AccessoriesManage(),
        '/user_manage' : (context) => UserManage(),
        '/post_detail' : (context) => PostDetail(),
        '/create_post' : (context) => CreatePost(),
        '/connection' : (context) => Connection(),
        '/new_car' : (context) => EditCar(),
        '/new_process' : (context) => NewProcess(),
        '/process_list' : (context) => Processes(),
        '/car_voice' : (context) => CarInvoiceList(),
        '/car_invoice/new': (context) => CarInvoiceForm(),
        '/transaction': (context) => Transaction(),
        '/transaction_detail': (context) => TransactionDetail(),
        '/customer/car_voice' : (context) => UserCarInvoiceList(),
        '/blocked_user' : (context) => BlockedUser(),
        '/change_password' : (context) => ChangePassword(),
        '/verify_password' : (context) => VerifyPassword(),
        '/new_password' : (context) => NewPassword(),
        '/create_appointment_process' : (context) => CreateAppointProcess(),
      },
    );
  }
}






