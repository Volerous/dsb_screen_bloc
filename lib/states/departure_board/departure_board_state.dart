import 'package:equatable/equatable.dart';
import 'package:dsb_screen_bloc/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'departure_board_state.g.dart';

enum DepartureBoardStatus { initial, loading, success, failure }

extension DepartureBoardStatusX on DepartureBoardStatus {
  bool get isInital => this == DepartureBoardStatus.initial;
  bool get isLoading => this == DepartureBoardStatus.loading;
  bool get isSuccess => this == DepartureBoardStatus.success;
  bool get isFailure => this == DepartureBoardStatus.failure;
}

@JsonSerializable()
class DepartureBoardState extends Equatable {
  DepartureBoardState({
    this.status = DepartureBoardStatus.initial,
    DepartureBoard? board,
  }) : board = board ?? DepartureBoard.empty();

  factory DepartureBoardState.fromJson(Map<String, dynamic> json) =>
      _$DepartureBoardStateFromJson(json);

  Map<String, dynamic> toJson() => _$DepartureBoardStateToJson(this);

  final DepartureBoardStatus status;
  final DepartureBoard board;

  @override
  List<Object> get props => [status, board];

  DepartureBoardState copyWith(
      {DepartureBoardStatus? status,
      DepartureBoard? board,
      Map<String, dynamic>? config}) {
    return DepartureBoardState(
      board: board ?? this.board,
      status: status ?? this.status,
    );
  }
}
