import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/config.dart';
import 'package:mobile/services/api_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

String userID = Random().nextInt(10000).toString(); //prototyping, 

class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Config.zegoAppID, 
      appSign: Config.zegoAppSign, 
      callID: callID, 
      userID: userID, 
      userName: 'user_$userID', 
       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}