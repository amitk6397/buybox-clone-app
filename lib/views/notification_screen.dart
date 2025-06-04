import 'package:buybox_app/controllers/notification_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _controller = Get.put(NotificationController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification')),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('notifications')
                .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${snapshot.data!.docs[index]['image'].toString()}',
                      ),
                    ),
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                    subtitle: Text(
                      snapshot.data!.docs[index]['body'].toString(),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _controller.deletedById(snapshot.data!.docs[index].id);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .collection('notifications')
                            .get();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
