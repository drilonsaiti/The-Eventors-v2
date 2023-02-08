import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  Future<List<XFile>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQualtity = 100,
    bool multiple = true,
  }) async {
    return await _imagePicker.pickMultiImage(imageQuality: imageQualtity);
    /*final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQualtity);

    if (file != null) return [file];
    return [];*/
  }
}
