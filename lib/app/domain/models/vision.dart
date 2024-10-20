import 'package:json_annotation/json_annotation.dart';
import 'dart:typed_data';
part 'vision.g.dart';

@JsonSerializable()
class Vision {
  final String id;
  final Uint8List image;
  final String title;
  final String? note;
  final String date;
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
    String? date,
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

  Map<String, dynamic> toJson() => _$VisionToJson(this);

  factory Vision.fromJson(Map<String, dynamic> json) => _$VisionFromJson(json);
}
