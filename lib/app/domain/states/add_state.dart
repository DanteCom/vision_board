import 'package:vision_board/app/ui/widgets/app_cupertino_alert_dialog.dart';
import 'package:vision_board/app/ui/screens/crop/crop_image_screen.dart';
import 'package:vision_board/app/domain/models/vision.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

class AddState extends ChangeNotifier {
  Vision? vision;
  AddState({this.vision}) {
    if (vision != null) {
      _image = vision!.image;
      _titleController.text = vision!.title;
      _noteController.text = vision!.note;
      _dateTime = vision!.dateTime;
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
  final fromatter = DateFormat('dd MMM yyyy');

  bool get testImage => _image != null && vision!.image != _image;
  bool get testTitle =>
      _titleController.text.trim().isNotEmpty &&
      vision!.title != _titleController.text.trim();
  bool get testNote => vision!.note != _noteController.text;
  bool get testDate =>
      fromatter.format(vision!.dateTime) != fromatter.format(dateTime!);

  bool get saveActive => testImage || testTitle || testNote || testDate;

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

    if (permission) {
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => AppCupertinoAlertDioalg(
            title: 'No Access to Your Photos',
            content:
                'Allow access to your photos so you\ncould visualize your dreams',
            firstButtonText: 'Cancel',
            secondButtonText: 'Settings',
            onPressed: () => openAppSettings(),
          ),
        );
      }
      return;
    }

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
      dateTime: _dateTime,
      isFulfilled: false,
    );
    newVision.addAndUpdate();
  }

  // Edit Vision

  void editVision(BuildContext context, String id) {
    final newVision = vision!.copyWith(
      image: _image,
      title: _titleController.text.trim(),
      note: _noteController.text.trim(),
      dateTime: _dateTime,
    );
    newVision.addAndUpdate();
    Navigator.pop(context);
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
