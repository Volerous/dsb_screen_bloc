import 'package:dsb_screen_bloc/models/departure.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'departure_board.g.dart';

@JsonSerializable()
class DepartureBoard extends Equatable {
  @JsonKey(name: "Departure")
  final List<Departure>? departures;
  final String? error;

  @override
  List<Object> get props => [departures ?? []];

  const DepartureBoard({this.departures, this.error});

  factory DepartureBoard.fromJson(Map<String, dynamic> json) =>
      _$DepartureBoardFromJson(json);

  factory DepartureBoard.empty() =>
      const DepartureBoard(departures: [], error: "");

  DepartureBoard copyWith(List<Departure> departures, String? error) {
    return DepartureBoard(departures: departures, error: error);
  }

  Map<String, dynamic> toJson() => _$DepartureBoardToJson(this);

  bool get isEmpty {
    return departures?.isEmpty ?? true;
  }
}
