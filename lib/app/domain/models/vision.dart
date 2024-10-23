import 'dart:typed_data';

import 'package:hive/hive.dart';

class Vision {
  String id;
  Uint8List image;
  String title;
  String note;
  DateTime dateTime;
  bool isFulfilled;

  Vision({
    required this.id,
    required this.image,
    required this.title,
    required this.note,
    required this.dateTime,
    required this.isFulfilled,
  });

  Vision copyWith({
    String? id,
    Uint8List? image,
    String? title,
    String? note,
    DateTime? dateTime,
    bool? isFulfilled,
  }) {
    return Vision(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
      isFulfilled: isFulfilled ?? this.isFulfilled,
    );
  }

  static List<Vision>? getAll() {
    final visions = Hive.box('vision').values;
    return visions.map((vision) => Vision.fromJson(Map.from(vision))).toList();
  }

  Future<void> addAndUpdate() async {
    await Hive.box('vision').put(id, toJson());
  }

  static Future<void> delete(String id) async {
    await Hive.box('vision').delete(id);
  }

  void isGoalFulfilled(bool newValue) {
    copyWith(isFulfilled: newValue).addAndUpdate();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image.toList(),
      'title': title,
      'note': note,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isFulfilled': isFulfilled,
    };
  }

  factory Vision.fromJson(Map<String, dynamic> map) {
    return Vision(
      id: map['id'] as String,
      image: Uint8List.fromList(map['image']),
      title: map['title'] as String,
      note: map['note'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      isFulfilled: map['isFulfilled'] as bool,
    );
  }
}
