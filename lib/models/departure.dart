import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
part 'departure.g.dart';

@JsonSerializable()
class DepartureBoard {
  @JsonKey(name: "Departure")
  List<Departure> departures = [];
  late String? error;

  DepartureBoard();
  factory DepartureBoard.fromJson(Map<String, dynamic> json) =>
      _$DepartureBoardFromJson(json);
  Map<String, dynamic> toJson() => _$DepartureBoardToJson(this);

  bool get isEmpty {
    return departures.isEmpty;
  }
}

@JsonSerializable()
class Departure {
  @JsonKey(name: "JourneyDetailRef")
  late JourneyDetailRef journeyDetailRef;
  late String name;
  late DepartureType type;
  late String stop;
  late String time;
  late String date;
  late String id;
  String? line;
  String? track;
  String? rtTrack;
  late String direction;
  String? messages;
  String? finalStop;
  String? state;

  Departure();
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

@JsonSerializable()
class JourneyDetailRef {
  late String ref;
  JourneyDetailRef();
  factory JourneyDetailRef.fromJson(Map<String, dynamic> json) =>
      _$JourneyDetailRefFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyDetailRefToJson(this);
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
