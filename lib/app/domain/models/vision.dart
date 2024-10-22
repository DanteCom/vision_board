import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:typed_data';
part 'vision.g.dart';

@JsonSerializable()
class Vision {
  final String id;
  final Uint8List image;
  final String title;
  final String? note;
  final DateTime date;
  final bool isFulfilled;

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
    return visions.map((vision) => Vision.fromJson(Map.from(vision))).toList();
  }

  Future<void> addAndUpdate() async {
    final box = Hive.box('vision');
    await box.put(id, toJson());
  }

  static Future<void> delete(String id) async {
    final box = Hive.box('vision');
    await box.delete(id);
  }

  Future<void> isGoalFulfilled() async {
    copyWith(isFulfilled: !isFulfilled).addAndUpdate();
  }

  Map<String, dynamic> toJson() => _$VisionToJson(this);

  factory Vision.fromJson(Map<String, dynamic> json) => _$VisionFromJson(json);
}
