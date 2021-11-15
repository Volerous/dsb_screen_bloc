import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dsb_screen_bloc/models/departure_board.dart';
import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'departure_board_event.dart';
part 'departure_board_state.dart';

class DepartureBoardBloc
    extends HydratedBloc<DepartureBoardEvent, DepartureBoardState> {
  DepartureBoardBloc(
    DSBRestApi dsbRestApi,
    ConfigBloc configBloc,
  )   : _dsbRestApi = dsbRestApi,
        _configBloc = configBloc,
        super(DepartureBoardInitial()) {
    on<DepartureBoardLoad>(_onLoad);
    _configStreamSubscription = _configBloc.stream.listen((configState) {
      print("db: $configState");
      if (configState is ConfigSuccess) {
        add(DepartureBoardLoad(configState.currentConfig));
      }
    });
    _startStream();
  }
  @override
  DepartureBoardState? fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case "DepartureBoardInitial":
        return DepartureBoardInitial();
      case "DepartureBoardFailed":
        return DepartureBoardFailed();
      case "DepartureBoardLoading":
        return DepartureBoardLoading();
      case "DepartureBoardSuccess":
        return DepartureBoardSuccess(DepartureBoard.fromJson(json['board']));
      default:
        throw Exception("Cannot find value.");
    }
  }

  @override
  Map<String, dynamic>? toJson(DepartureBoardState state) {
    var base = {'type': state.runtimeType.toString()};
    if (state is DepartureBoardSuccess) {
      return {'board': state.board.toJson(), ...base};
    }
    return base;
  }

  final DSBRestApi _dsbRestApi;
  final ConfigBloc _configBloc;
  late StreamSubscription _configStreamSubscription;
  late Timer _timer;
  Map<String, dynamic>? _args;
  void _onLoad(
    DepartureBoardLoad event,
    Emitter<DepartureBoardState> emit,
  ) async {
    try {
      final departureBoard = await _dsbRestApi.getDepartureBoard(event.query);
      _args = event.query;
      emit(DepartureBoardSuccess(departureBoard));
    } catch (e) {
      print(e);
      emit(DepartureBoardFailed());
    }
  }

  void _startStream() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_args != null) add(DepartureBoardLoad(_args!));
    });
  }

  void retry() {
    add(DepartureBoardLoad(_args ?? {}));
  }
}
