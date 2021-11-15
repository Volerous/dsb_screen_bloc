import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dsb_screen_bloc/services/stations.dart';

part './station_list_event.dart';
part './station_list_state.dart';

class StationListBloc extends HydratedBloc<StationListEvent, StationListState> {
  StationListBloc(StationsListService stationsListService)
      : _stationsListService = stationsListService,
        super(StationListInitial()) {
    on<StationListLoad>(_onLoad);
  }
  final StationsListService _stationsListService;

  @override
  StationListState? fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case "StationListSuccess":
        return StationListSuccess(
          json['value'] as Map<String, dynamic>,
        );
      case "StationListFailed":
        return StationListFailed();
      case "StationListLoading":
        return StationListLoading();
      case "StationListInitial":
        return StationListInitial();
      default:
        throw Exception("the state is not found: ${json['type']}");
    }
  }

  @override
  Map<String, dynamic> toJson(StationListState state) {
    var base = {"type": state.runtimeType.toString()};
    if (state is StationListSuccess) {
      return {"value": state.stationMap, ...base};
    }
    return base;
  }

  void _onLoad(StationListLoad event, Emitter<StationListState> emit) async {
    final stations = await _stationsListService.getStationsMap();
    emit(StationListSuccess(stations));
  }

  void loadStation() {
    add(StationListLoad());
  }
}
