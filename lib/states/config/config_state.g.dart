// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigState _$ConfigStateFromJson(Map<String, dynamic> json) => ConfigState(
      status: _$enumDecodeNullable(_$ConfigStatusEnumMap, json['status']) ??
          ConfigStatus.initial,
    );

Map<String, dynamic> _$ConfigStateToJson(ConfigState instance) =>
    <String, dynamic>{
      'status': _$ConfigStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ConfigStatusEnumMap = {
  ConfigStatus.initial: 'initial',
  ConfigStatus.loading: 'loading',
  ConfigStatus.success: 'success',
  ConfigStatus.failure: 'failure',
};
