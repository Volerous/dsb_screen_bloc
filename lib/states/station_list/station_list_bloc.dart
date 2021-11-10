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
  StationListState? fromJson(Map<String, dynamic> json) =>
      StationListSuccess(json["value"] as Map<String, String>);

  @override
  Map<String, dynamic> toJson(StationListState state) => {"value": state};

  void _onLoad(StationListLoad event, Emitter<StationListState> emit) async {
    final stations = await _stationsListService.getStationsMap();
    emit(StationListSuccess(stations));
  }

  void loadStation() {
    add(StationListLoad());
  }
}
