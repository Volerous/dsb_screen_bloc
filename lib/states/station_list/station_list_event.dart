part of './station_list_bloc.dart';

abstract class StationListEvent extends Equatable {
  const StationListEvent();

  @override
  List<Object> get props => [];
}

class StationListLoad extends StationListEvent {}
