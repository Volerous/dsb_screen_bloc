// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartureBoard _$DepartureBoardFromJson(Map<String, dynamic> json) =>
    DepartureBoard(
      departures: (json['Departure'] as List<dynamic>?)
          ?.map((e) => Departure.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$DepartureBoardToJson(DepartureBoard instance) =>
    <String, dynamic>{
      'Departure': instance.departures,
      'error': instance.error,
    };
