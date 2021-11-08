import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dsb_screen_bloc/models/departure_board.dart';
import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:equatable/equatable.dart';

part 'departure_board_event.dart';
part 'departure_board_state.dart';

class DepartureBoardBloc
    extends Bloc<DepartureBoardEvent, DepartureBoardState> {
  DepartureBoardBloc(
    DSBRestApi dsbRestApi,
  )   : _dsbRestApi = dsbRestApi,
        super(DepartureBoardInitial()) {
    on<DepartureBoardLoad>(_onLoad);
  }
  final DSBRestApi _dsbRestApi;
  Timer _timer;
  void _onLoad(
    DepartureBoardLoad event,
    Emitter<DepartureBoardState> emit,
  ) async {
    final departureBoard = await _dsbRestApi.getDepartureBoard(event.query);
    emit(DepartureBoardSuccess(departureBoard));
  }

  void _startStream() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(DepartureBoardLoad());
    });
  }
}
