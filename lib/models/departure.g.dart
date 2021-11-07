// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departure _$DepartureFromJson(Map<String, dynamic> json) => Departure(
      journeyDetailRef: json['JourneyDetailRef'] == null
          ? null
          : JourneyDetailRef.fromJson(
              json['JourneyDetailRef'] as Map<String, dynamic>),
      type: _$enumDecodeNullable(_$DepartureTypeEnumMap, json['type']),
      id: json['id'] as String?,
      name: json['name'] as String?,
      stop: json['stop'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      direction: json['direction'] as String?,
      line: json['line'] as String?,
      track: json['track'] as String?,
      rtTrack: json['rtTrack'] as String?,
      messages: json['messages'] as String?,
      finalStop: json['finalStop'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$DepartureToJson(Departure instance) => <String, dynamic>{
      'JourneyDetailRef': instance.journeyDetailRef,
      'name': instance.name,
      'type': _$DepartureTypeEnumMap[instance.type],
      'stop': instance.stop,
      'time': instance.time,
      'date': instance.date,
      'id': instance.id,
      'line': instance.line,
      'track': instance.track,
      'rtTrack': instance.rtTrack,
      'direction': instance.direction,
      'messages': instance.messages,
      'finalStop': instance.finalStop,
      'state': instance.state,
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

const _$DepartureTypeEnumMap = {
  DepartureType.ic: 'IC',
  DepartureType.lyn: 'LYN',
  DepartureType.reg: 'REG',
  DepartureType.s: 'S',
  DepartureType.tog: 'TOG',
  DepartureType.bus: 'BUS',
  DepartureType.exb: 'EXB',
  DepartureType.nb: 'NB',
  DepartureType.tb: 'TB',
  DepartureType.f: 'F',
  DepartureType.m: 'M',
  DepartureType.let: 'LET',
};
