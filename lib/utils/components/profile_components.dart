import 'package:buybox_app/controllers/profile_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// PersonalInfo Screen

final ProfileController _controller = Get.put(ProfileController());

Widget editUser(String title, String name, VoidCallback onTap) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Expanded(child: Text(name)),
          Expanded(child: IconButton(onPressed: onTap, icon: Icon(Icons.edit))),
        ],
      ),
    ),
  );
}

Widget alertContainer(
  TextEditingController genderController,
  TextEditingController dobController,
  BuildContext context,
) {
  return SizedBox(
    height: 180,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Please enter your details', style: TextStyle(fontSize: 18)),
        SizedBox(height: 12),
        textfield(
          'DD/MM/YY',
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              print('Date Picker opened');
              DateTime? datePicker = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),

                lastDate: DateTime(2026),
              );
              if (datePicker != null) {
                String formatedDate =
                    "${datePicker.day}/${datePicker.month}/${datePicker.year}";
                dobController.text = formatedDate.toString();
                _controller.setDate(formatedDate);
                prefs.setString('date', formatedDate);
              }
            },
            icon: Icon(Icons.calendar_month),
          ),
          dobController,
        ),

        SizedBox(height: 8),
        textfield(
          'Male/Female',
          PopupMenuButton(
            position: PopupMenuPosition.under,
            icon: Icon(Icons.arrow_drop_down),
            onSelected: (String value) async {
              final prefs = await SharedPreferences.getInstance();

              if (value == 'male') {
                genderController.text = 'Male';
                _controller.setGender('Male');
                prefs.setString('gender', 'Male');
              } else if (value == 'female') {
                genderController.text = 'Female';
                _controller.setGender('Female');
                prefs.setString('gender', 'Female');
              } else {
                genderController.text = 'Other';
                _controller.setGender('Other');
                prefs.setString('gender', 'Other');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Male'), value: 'male'),
                PopupMenuItem(child: Text('Female'), value: 'female'),
                PopupMenuItem(child: Text('Other'), value: 'other'),
              ];
            },
          ),
          genderController,
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

Widget textfield(
  String hinttext,
  Widget button,
  TextEditingController _controller,
) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      hintText: hinttext,
      suffixIcon: button,
      border: OutlineInputBorder(),
    ),
  );
}

// Logout

class ListtileWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  ListtileWidget({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: color),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16,

            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}
