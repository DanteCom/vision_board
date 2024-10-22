import 'package:vision_board/app/ui/screens/crop/crop_image_screen.dart';
import 'package:vision_board/app/domain/models/vision.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

class AddState extends ChangeNotifier {
  Vision? vision;
  AddState({this.vision}) {
    if (vision != null) {
      _image = vision!.image;
      _titleController.text = vision!.title;
      _noteController.text = vision!.note ?? '';
      _dateTime = vision!.date;
    }
  }

  //Varebals

  int _currentPage = 0;
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  Uint8List? _image;
  DateTime _dateTime = DateTime.now();

  //Getters

  TextEditingController get titleController => _titleController;
  TextEditingController get noteController => _noteController;

  Uint8List? get image => _image;
  DateTime? get dateTime => _dateTime;
  int get currentPage => _currentPage;

  // Save Vission

  bool get saveActive =>
      vision!.image != _image && _image != null ||
      vision!.title != _titleController.text.trim() ||
      vision!.note != _noteController.text.trim() ||
      vision!.date != _dateTime;

  // Pages is Active

  bool get isPicturePageActive => _currentPage == 0 && _image != null;
  bool get isTitleSNotePageActive =>
      _currentPage == 1 && _titleController.text.trim().isNotEmpty;

  bool get isDatePageActive => _currentPage == 2;

  // Functions

  // On Tap Continue

  void onTapContinue(BuildContext context) {
    if (currentPage == 2) {
      addVision();
      Navigator.pop(context);
    } else {
      _currentPage++;
    }
    notifyListeners();
  }

  // Add Image

  void addImage(BuildContext context) async {
    bool permission = await Permission.photos.request().isDenied;

    if (permission) return;

    XFile? imageXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageXFile != null) {
      final imageBytes = await imageXFile.readAsBytes();

      if (context.mounted) {
        _image = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropImageScreen(image: imageBytes),
          ),
        );
      }
    }
    notifyListeners();
  }

  // Add DateTime

  void addDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  // Add Vission To Hive

  void addVision() {
    final id = const Uuid().v4();
    final newVision = Vision(
      id: id,
      image: _image!,
      title: _titleController.text.trim(),
      note: _noteController.text.trim(),
      date: _dateTime,
      isFulfilled: false,
    );
    newVision.addAndUpdate();
  }

  // Edit Vision

  void editVision(String id) {
    final newVision = Vision(
      id: id,
      image: _image!,
      title: _titleController.text.trim(),
      note: _noteController.text.trim(),
      date: _dateTime,
      isFulfilled: false,
    );
    newVision.addAndUpdate();
  }

  // Delete Vision

  void deleteVision(BuildContext context, String id) {
    Navigator.pop(context);
    Navigator.pop(context);
    Vision.delete(id);
  }

  // setState((){});

  void setState() => notifyListeners();
}