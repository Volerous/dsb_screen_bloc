import 'dart:async';

import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './departure_board_state.dart';

class DepartureBoardCubit extends HydratedCubit<DepartureBoardState> {
  DepartureBoardCubit(this._restApi, Map<String, dynamic> args)
      : _args = args,
        // _configCubit = configCubit,
        super(DepartureBoardState());
  final DSBRestApi _restApi;
  // final ConfigCubit _configCubit;
  Map<String, dynamic> _args;
  late Timer _timer;
  Future<void> fetchDepartureBoard() async {
    if (!state.status.isSuccess) {
      emit(state.copyWith(status: DepartureBoardStatus.loading));
    }
    final board = await _restApi.getDepartureBoard(_args);
    emit(state.copyWith(status: DepartureBoardStatus.success, board: board));
  }

  void startStream() {
    _timer = Timer.periodic(const Duration(seconds: 5), (t) async {
      await fetchDepartureBoard();
    });
  }

  Future<void> updateArgs({Map<String, dynamic>? newConfig}) async {
    if (newConfig != null) _args = newConfig;
    await fetchDepartureBoard();
  }

  @override
  DepartureBoardState fromJson(Map<String, dynamic> json) =>
      DepartureBoardState.fromJson(json);

  @override
  Map<String, dynamic> toJson(DepartureBoardState state) => state.toJson();
}
