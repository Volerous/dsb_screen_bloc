// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartureBoard _$DepartureBoardFromJson(Map<String, dynamic> json) =>
    DepartureBoard()
      ..departures = (json['Departure'] as List<dynamic>)
          .map((e) => Departure.fromJson(e as Map<String, dynamic>))
          .toList()
      ..error = json['error'] as String?;

Map<String, dynamic> _$DepartureBoardToJson(DepartureBoard instance) =>
    <String, dynamic>{
      'Departure': instance.departures,
      'error': instance.error,
    };

Departure _$DepartureFromJson(Map<String, dynamic> json) => Departure()
  ..journeyDetailRef = JourneyDetailRef.fromJson(
      json['JourneyDetailRef'] as Map<String, dynamic>)
  ..name = json['name'] as String
  ..type = _$enumDecode(_$DepartureTypeEnumMap, json['type'])
  ..stop = json['stop'] as String
  ..time = json['time'] as String
  ..date = json['date'] as String
  ..id = json['id'] as String
  ..line = json['line'] as String?
  ..track = json['track'] as String?
  ..rtTrack = json['rtTrack'] as String?
  ..direction = json['direction'] as String
  ..messages = json['messages'] as String?
  ..finalStop = json['finalStop'] as String?
  ..state = json['state'] as String?;

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

JourneyDetailRef _$JourneyDetailRefFromJson(Map<String, dynamic> json) =>
    JourneyDetailRef()..ref = json['ref'] as String;

Map<String, dynamic> _$JourneyDetailRefToJson(JourneyDetailRef instance) =>
    <String, dynamic>{
      'ref': instance.ref,
    };
