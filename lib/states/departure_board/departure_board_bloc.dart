import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dsb_screen_bloc/models/departure_board.dart';
import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:equatable/equatable.dart';

part 'departure_board_event.dart';
part 'departure_board_state.dart';

class DepartureBoardBloc
    extends Bloc<DepartureBoardEvent, DepartureBoardState> {
  DepartureBoardBloc(
    DSBRestApi dsbRestApi,
    ConfigBloc configBloc,
  )   : _dsbRestApi = dsbRestApi,
        _configBloc = configBloc,
        super(DepartureBoardInitial()) {
    on<DepartureBoardLoad>(_onLoad);
    _configBloc.stream.listen((state) {
      if (state is ConfigSuccess) {
        add(DepartureBoardLoad(state.currentConfig));
      }
    });
    _startStream();
  }
  final DSBRestApi _dsbRestApi;
  final ConfigBloc _configBloc;
  late Timer _timer;
  late Map<String, dynamic> _args;
  void _onLoad(
    DepartureBoardLoad event,
    Emitter<DepartureBoardState> emit,
  ) async {
    _args = event.query;
    final departureBoard = await _dsbRestApi.getDepartureBoard(event.query);
    emit(DepartureBoardSuccess(departureBoard));
  }

  void _startStream() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(DepartureBoardLoad(_args));
    });
  }

  void retry() {
    add(DepartureBoardLoad(_args));
  }
}
