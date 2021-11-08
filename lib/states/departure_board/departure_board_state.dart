part of 'departure_board_bloc.dart';

abstract class DepartureBoardState extends Equatable {
  const DepartureBoardState();

  @override
  List<Object> get props => [];
}

class DepartureBoardInitial extends DepartureBoardState {}

class DepartureBoardLoading extends DepartureBoardState {}

class DepartureBoardFailed extends DepartureBoardState {}

class DepartureBoardSuccess extends DepartureBoardState {
  final DepartureBoard board;
  const DepartureBoardSuccess(this.board);

  @override
  List<Object> get props => [board];
}
