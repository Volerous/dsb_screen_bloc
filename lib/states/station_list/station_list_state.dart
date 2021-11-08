part of './station_list_bloc.dart';

abstract class StationListState extends Equatable {
  const StationListState();

  @override
  List<Object> get props => [];
}

class StationListInitial extends StationListState {}

class StationListLoading extends StationListState {}

class StationListSuccess extends StationListState {
  final Map<String, String> stationMap;
  const StationListSuccess(this.stationMap);
  List<String> get stationNames => stationMap.keys.toList();
  @override
  List<Object> get props => [stationMap];
}

class StationListFailed extends StationListState {}
