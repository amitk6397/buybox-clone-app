import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePickerController extends GetxController {
  var imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedImage();
  }

  Future<void> loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('imagePathSave') ?? '';
    imagePath.value = savedPath;
    print('Loaded saved image path: $savedPath');
  }

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      print('Image not picked');
    } else {
      imagePath.value = image.path;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePathSave', image.path);
      print('Saved image path: ${imagePath.value}');
    }
  }
}
