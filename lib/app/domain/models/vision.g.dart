// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vision _$VisionFromJson(Map<String, dynamic> json) => Vision(
      id: json['id'] as String,
      image: Uint8List.fromList((json['image']) as List<int>),
      title: json['title'] as String,
      note: json['note'] as String?,
      date: json['date'] as String,
      isFulfilled: json['isFulfilled'] as bool,
    );

Map<String, dynamic> _$VisionToJson(Vision instance) => <String, dynamic>{
      'id': instance.id,
      'image': Uint8List.fromList((instance.image)),
      'title': instance.title,
      'note': instance.note,
      'date': instance.date,
      'isFulfilled': instance.isFulfilled,
    };
