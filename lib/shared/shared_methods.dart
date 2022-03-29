part of 'shared.dart';

final ImagePicker _picker = ImagePicker();
Future<XFile?> getImage() async {
  var image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}
