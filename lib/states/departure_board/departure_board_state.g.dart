// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure_board_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartureBoardState _$DepartureBoardStateFromJson(Map<String, dynamic> json) =>
    DepartureBoardState(
      status:
          _$enumDecodeNullable(_$DepartureBoardStatusEnumMap, json['status']) ??
              DepartureBoardStatus.initial,
      board: json['board'] == null
          ? null
          : DepartureBoard.fromJson(json['board'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DepartureBoardStateToJson(
        DepartureBoardState instance) =>
    <String, dynamic>{
      'status': _$DepartureBoardStatusEnumMap[instance.status],
      'board': instance.board,
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

const _$DepartureBoardStatusEnumMap = {
  DepartureBoardStatus.initial: 'initial',
  DepartureBoardStatus.loading: 'loading',
  DepartureBoardStatus.success: 'success',
  DepartureBoardStatus.failure: 'failure',
};
