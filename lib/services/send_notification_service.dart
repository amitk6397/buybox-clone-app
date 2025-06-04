import 'dart:convert';

import 'package:buybox_app/services/get_service_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotificationMessage({
    //  required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await GetServerKey().getServerKeyToken();

    String url =
        'https://fcm.googleapis.com/v1/projects/buybox-app/messages:send';

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    Map<String, dynamic> message = {
      "message": {
        "token":
            "dPfPLLQHQyqvrvJiJ_ZO-d:APA91bHYz4cgtVs8YrJtrAfy9pfvXMkpex73Cl3aSpkRZrRt_bJHpoywWmn825nt0_HJEN5TlHzwrWArECoQvs9tTXa0mAtDYmjVsZ0IBlS_pPTpTbnFpe8",
        "notification": {"body": body, "title": title},
        'data': data,
      },
    };

    // Api hit

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Notification successfuly = == ====');
    } else {
      print('Notification failed ==================================f=f-f');
    }
  }
}
