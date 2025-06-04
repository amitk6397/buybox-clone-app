import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:buybox_app/main.dart';
import 'package:buybox_app/views/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('  ------user authorized confirm ----');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print(' ======= == user provisional confirm =====');
    } else {
      Get.snackbar(
        'Notification permission denied',
        'PLease allow notification permission',
      );

      Future.delayed(Duration(seconds: 3), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  void initLocalNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitSetting = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    var iosInitSetting = const DarwinInitializationSettings();

    var initialaizationSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initialaizationSetting,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  // firebase init  //forground

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;

      if (kDebugMode) {
        print(message.notification!.title);
        print(message.notification!.body);
      }

      //ios
      if (Platform.isIOS) {
        iosForgroundMessage();
      }
      //android

      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      }
    });
  }

  // background ans terminated

  Future<void> setupInteractMessage(BuildContext context) async {
    //background

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

    //ternimated

    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        handleMessage(context, message);
      }
    });
  }

  // handler message

  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    if (message.data['screen'] == 'notification_screen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NotificationScreen()),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    }
  }

  //function to show notification

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.high,
      showBadge: true,
      playSound: true,
    );

    //android setting

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: " Channel AMit kumar ",
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: channel.sound,
        );

    // ios setting

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //ios message

  Future iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
