import 'dart:typed_data';

import 'package:hive/hive.dart';

class Vision {
  String id;
  Uint8List image;
  String title;
  String note;
  DateTime date;
  bool isFulfilled;

  Vision({
    required this.id,
    required this.image,
    required this.title,
    required this.note,
    required this.date,
    required this.isFulfilled,
  });

  Vision copyWith({
    String? id,
    Uint8List? image,
    String? title,
    String? note,
    DateTime? date,
    bool? isFulfilled,
  }) {
    return Vision(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      isFulfilled: isFulfilled ?? this.isFulfilled,
    );
  }

  static List<Vision>? getAll() {
    final visions = Hive.box('vision').values;
    return visions.map((vision) => Vision.fromJson(vision)).toList();
  }

  Future<void> addAndUpdate() async {
    final box = Hive.box('vision');
    await box.put(id, toJson());
  }

  static Future<void> delete(String id) async {
    final box = Hive.box('vision');
    await box.delete(id);
  }

  Future<void> isGoalFulfilled(bool newValue) async {
    copyWith(isFulfilled: newValue).addAndUpdate();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image.toList(),
      'title': title,
      'note': note,
      'date': date.millisecondsSinceEpoch,
      'isFulfilled': isFulfilled,
    };
  }

  factory Vision.fromJson(Map<String, dynamic> map) {
    return Vision(
      id: map['id'] as String,
      image: Uint8List.fromList(map['image']),
      title: map['title'] as String,
      note: map['note'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isFulfilled: map['isFulfilled'] as bool,
    );
  }
}
