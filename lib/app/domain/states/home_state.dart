import 'package:vision_board/app/domain/models/vision.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';

class HomeState extends ChangeNotifier {
  final visionBox = Hive.box('vision');
  List<Vision> visionsList = [];

  HomeState() {
    init();
  }

  void getAllVisions() async {
    visionsList = Vision.getAll() ?? [];
    visionsList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    notifyListeners();
  }

  void init() {
    getAllVisions();
    visionBox.listenable().addListener(getAllVisions);
  }

  @override
  void dispose() {
    visionBox.listenable().removeListener(getAllVisions);
    super.dispose();
  }
}
