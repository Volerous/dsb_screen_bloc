import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'station_list_state.g.dart';

enum StationListStatus { initial, loading, success, failure }

extension ConfigStatusX on StationListStatus {
  bool get isInital => this == StationListStatus.initial;
  bool get isLoading => this == StationListStatus.loading;
  bool get isSuccess => this == StationListStatus.success;
  bool get isFailure => this == StationListStatus.failure;
}

@JsonSerializable()
class StationListState extends Equatable {
  const StationListState({
    this.status = StationListStatus.initial,
    Map<String, dynamic>? stationMap,
  }) : stationMap = stationMap ?? const {};

  factory StationListState.fromJson(Map<String, dynamic> json) =>
      _$StationListStateFromJson(json);

  Map<String, dynamic> toJson() => _$StationListStateToJson(this);

  final StationListStatus status;
  final Map<String, dynamic> stationMap;

  List<String> get stationNames => stationMap.keys.toList();

  @override
  List<Object> get props => [status, stationMap];

  StationListState copyWith({
    StationListStatus? status,
    Map<String, dynamic>? stationMap,
  }) {
    return StationListState(
      status: status ?? this.status,
      stationMap: stationMap ?? this.stationMap,
    );
  }
}
