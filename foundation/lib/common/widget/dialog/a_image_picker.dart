import 'package:image_picker/image_picker.dart';

class AImagePicker {
  static final AImagePicker _instance = AImagePicker._init();

  factory AImagePicker.instance() => _instance;

  AImagePicker._init() {
    _picker = ImagePicker();
  }

  /// 三方库代理对象
  late ImagePicker _picker;

  /// 从相册选择
  Future<String?> pickGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  }

  /// 从相机选择
  Future<String?> pickCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image?.path;
  }
}
