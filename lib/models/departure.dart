import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import './journey_ref.dart';
part 'departure.g.dart';

@JsonSerializable()
class Departure extends Equatable {
  @JsonKey(name: "JourneyDetailRef")
  final JourneyDetailRef? journeyDetailRef;
  final String? name;
  final DepartureType? type;
  final String? stop;
  final String? time;
  final String? date;
  final String? id;
  final String? line;
  final String? track;
  final String? rtTrack;
  final String? direction;
  final String? messages;
  final String? finalStop;
  final String? state;

  @override
  List<Object?> get props => [name, type, time, date, id, direction];

  const Departure(
      {this.journeyDetailRef,
      this.type,
      this.id,
      this.name,
      this.stop,
      this.time,
      this.date,
      this.direction,
      this.line,
      this.track,
      this.rtTrack,
      this.messages,
      this.finalStop,
      this.state});

  factory Departure.fromJson(Map<String, dynamic> json) =>
      _$DepartureFromJson(json);

  Map<String, dynamic> toJson() => _$DepartureToJson(this);

  int get minutesToDeparture {
    var fullDt = DateFormat("dd.MM.yy H:m").parse("$date $time");
    return fullDt.difference(DateTime.now()).inMinutes;
  }

  String get displayName {
    if (type == DepartureType.reg) return "RE";
    return line ?? "";
  }

  bool get isCancelled {
    return state?.toLowerCase() == "cancellation";
  }
}

class CustomDateConverter implements JsonConverter<DateTime, String> {
  const CustomDateConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json.replaceAll(RegExp(r'.'), "-"));
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}

enum DepartureType {
  @JsonValue("IC")
  ic,
  @JsonValue("LYN")
  lyn,
  @JsonValue("REG")
  reg,
  @JsonValue("S")
  s,
  @JsonValue("TOG")
  tog,
  @JsonValue("BUS")
  bus,
  @JsonValue("EXB")
  exb,
  @JsonValue("NB")
  nb,
  @JsonValue("TB")
  tb,
  @JsonValue("F")
  f,
  @JsonValue("M")
  m,
  @JsonValue("LET")
  let,
}
