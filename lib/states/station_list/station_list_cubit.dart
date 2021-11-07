import 'dart:async';

import 'package:dsb_screen_bloc/services/stations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'station_list_state.dart';

class StationListCubit extends HydratedCubit<StationListState> {
  StationListCubit(
    this._stationsListService,
  ) : super(const StationListState());
  final StationsListService _stationsListService;

  Future<void> fetchConfig() async {
    final stationMap = await _stationsListService.getStationsMap();
    emit(state.copyWith(
        status: StationListStatus.success, stationMap: stationMap));
  }

  @override
  StationListState fromJson(Map<String, dynamic> json) =>
      StationListState.fromJson(json);

  @override
  Map<String, dynamic> toJson(StationListState state) => state.toJson();
}
