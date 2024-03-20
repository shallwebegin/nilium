import 'package:image_picker/image_picker.dart';

class PickImage {
  final _picker = ImagePicker();
  Future<XFile?> pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }
}
