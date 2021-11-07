// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_list_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationListState _$StationListStateFromJson(Map<String, dynamic> json) =>
    StationListState(
      status:
          _$enumDecodeNullable(_$StationListStatusEnumMap, json['status']) ??
              StationListStatus.initial,
      stationMap: json['stationMap'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StationListStateToJson(StationListState instance) =>
    <String, dynamic>{
      'status': _$StationListStatusEnumMap[instance.status],
      'stationMap': instance.stationMap,
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

const _$StationListStatusEnumMap = {
  StationListStatus.initial: 'initial',
  StationListStatus.loading: 'loading',
  StationListStatus.success: 'success',
  StationListStatus.failure: 'failure',
};
