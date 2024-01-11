// import 'dart:convert';
// import 'dart:io';
//
// import 'package:brandmanager/utils/global_key.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//   void init() {
//     if (Platform.isIOS) {
//       // request permissions if we're on android
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     } else {
//       _fcm.requestNotificationPermissions(const IosNotificationSettings(
//           sound: true, badge: true, alert: true, provisional: true));
//     }
//
//     _fcm.configure(
//       // Called when the app is in the foreground and we receive a push notification
//       onMessage: (Map<String, dynamic> message) async {
//         //debugPrint('onMessage: $message');
//       },
//       // Called when the app has been closed comlpetely and it's opened
//       // from the push notification.
//       onLaunch: (Map<String, dynamic> message) async {
//         //debugPrint('onLaunch: $message');
//         _serialiseAndNavigate(
//             message, myGlobals.dashboardScaffoldKey.currentContext);
//       },
//       // Called when the app is in the background and it's opened
//       // from the push notification.
//       onResume: (Map<String, dynamic> message) async {
//         //debugPrint('onResume: $message');
//         _serialiseAndNavigate(
//             message, myGlobals.dashboardScaffoldKey.currentContext);
//       },
//     );
//     _fcm.getToken().then((String token) async {
//       //debugPrint("fcm Token:- $token");
//     });
//   }
//
//   void _serialiseAndNavigate(
//       Map<String, dynamic> message, BuildContext context) {
//     var payload = jsonDecode(message['data']['payload']);
//     var screen = payload['route'];
//     if (screen != '') {
//       // Navigate to the create post view
//       if (screen == 'create_image') {
//         var categoryId = payload["category_id"];
//         var imageId = payload["image_id"];
//         var isFestival = payload["is_festival"];
//         Navigator.of(context).pushNamed('/$screen', arguments: {
//           "category_id": categoryId,
//           "image_id": imageId,
//           "is_festival": isFestival,
//         });
//       }
//     }
//   }
// }
