// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      config: (json['config'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'config': instance.config,
    };
