import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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
        'PLease allow notification ',
      );

      Future.delayed(Duration(seconds: 3), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }
}
