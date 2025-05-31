import 'dart:io';

import 'package:buybox_app/controllers/admin_controller/dashboard_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController _controller = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.listOfUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              itemCount: _controller.userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading:
                              _controller.userList[index]['image'] != null
                                  ? Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(
                                            _controller
                                                .userList[index]['image'],
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                  : Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _controller.userList[index]['userName'] !=
                                                    null &&
                                                _controller
                                                    .userList[index]['userName']
                                                    .isNotEmpty
                                            ? _controller
                                                .userList[index]['userName'][0]
                                                .toUpperCase()
                                            : '?',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                          title: Text(
                            _controller.userList[index]['userName'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            _controller.userList[index]['email'] ?? '',
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              _controller.toggleVisibility(index);
                            },
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        Obx(
                          () =>
                              _controller.showStates[index]
                                  ? Column(
                                    children: [
                                      row(
                                        'Location',
                                        _controller
                                                .userList[index]['location'] ??
                                            'NA',
                                      ),
                                      row(
                                        'SignUp Date',
                                        _controller.userList[index]['date'] ??
                                            'NA',
                                      ),
                                      row(
                                        'SignUp Time',
                                        _controller.userList[index]['time'] ??
                                            'NA',
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textButton(
                                            () {
                                              bool isBlocked =
                                                  _controller
                                                      .userList[index]['blocked'] ??
                                                  false;
                                              _controller.blockUser(
                                                _controller
                                                    .userList[index]['uid'],
                                                !isBlocked,
                                              );
                                            },
                                            'Block',
                                            _controller.userList[index]['blocked'] ==
                                                    true
                                                ? AppColors.errorMessageColor
                                                : AppColors.successMessageColor,
                                            15,
                                          ),
                                          textButton(
                                            () {
                                              _controller.deleteUserByAdmin(
                                                _controller
                                                    .userList[index]['uid'],
                                              );
                                            },
                                            'Delete',
                                            AppColors.errorMessageColor,
                                            15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                  : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
      }),
    );
  }
}

Widget row(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(flex: 1, child: Text(label)),
      Expanded(flex: 2, child: Text(value)),
    ],
  );
}
