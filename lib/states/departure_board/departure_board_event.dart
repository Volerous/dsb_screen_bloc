part of 'departure_board_bloc.dart';

abstract class DepartureBoardEvent extends Equatable {
  const DepartureBoardEvent();

  @override
  List<Object> get props => [];
}

class DepartureBoardLoad extends DepartureBoardEvent {
  final Map<String, dynamic> query;
  const DepartureBoardLoad(this.query);

  @override
  List<Object> get props => [query];
}
