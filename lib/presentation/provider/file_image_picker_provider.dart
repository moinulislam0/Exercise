
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

final fileImagePickerProvider =
    StateNotifierProvider<FileImagePickerNotifier, PickerState>(
  (ref) => FileImagePickerNotifier(),
);

class PickerState {
  final XFile? singleImage;
  final List<XFile> multipleImages;
  final List<PlatformFile> files;

  const PickerState({
    this.singleImage,
    this.multipleImages = const [],
    this.files = const [],
  });

  PickerState copyWith({
    XFile? singleImage,
    List<XFile>? multipleImages,
    List<PlatformFile>? files,
  }) {
    return PickerState(
      singleImage: singleImage ?? this.singleImage,
      multipleImages: multipleImages ?? this.multipleImages,
      files: files ?? this.files,
    );
  }
}

class FileImagePickerNotifier extends StateNotifier<PickerState> {
  FileImagePickerNotifier() : super(const PickerState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickSingleImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(singleImage: image);
    }
  }

  Future<void> pickMultipleImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      state = state.copyWith(multipleImages: images);
    }
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg'],
    );

    if (result != null && result.files.isNotEmpty) {
      state = state.copyWith(files: result.files);
    }
  }
  void clearAll() {
    state = const PickerState();
  }
}
