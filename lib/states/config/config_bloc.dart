import 'package:equatable/equatable.dart';
import 'package:dsb_screen_bloc/services/config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  ConfigBloc(ConfigService configService)
      : _configService = configService,
        super(ConfigInitial()) {
    on<ConfigLoad>(_onLoad);
    on<UpdateStationConfig>(_onUpdateConfig);
    on<ConfigChangeCurrentStation>(_onUpdateCurrentStation);
    on<ConfigDeleteStation>(_onDeleteStation);
    on<ConfigReset>(_onConfigReset);
    add(ConfigLoad());
  }
  @override
  ConfigState? fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case "ConfigInitial":
        return ConfigInitial();
      case "ConfigFailed":
        return ConfigFailed();
      case "ConfigLoading":
        return ConfigLoading();
      case "ConfigSuccess":
        return ConfigSuccess(json["config"], json["currentStation"]);
      default:
        throw Exception("Cannot find value");
    }
  }

  @override
  Map<String, dynamic> toJson(ConfigState state) {
    var base = {'type': state.runtimeType.toString()};
    if (state is ConfigSuccess) {
      return {
        "config": state.config,
        "currentStation": state.currentStation,
        ...base
      };
    }
    return base;
  }

  final ConfigService _configService;

  void _onLoad(ConfigLoad event, Emitter<ConfigState> emit) async {
    var currentStation = "";
    if (state is ConfigSuccess) {
      currentStation = (state as ConfigSuccess).currentStation;
    }
    final config = await _configService.getOrCreateConfig();
    emit(ConfigSuccess(config, currentStation));
  }

  void _onUpdateConfig(
      UpdateStationConfig event, Emitter<ConfigState> emit) async {
    var config = (state as ConfigSuccess).config;
    config[event.stationName] = event.config;
    await _configService.updateStation(event.stationName, event.config);
    emit(ConfigSuccess(config, (state as ConfigSuccess).currentStation));
  }

  void _onUpdateCurrentStation(
      ConfigChangeCurrentStation event, Emitter<ConfigState> emit) async {
    emit(ConfigSuccess((state as ConfigSuccess).config, event.stationName));
  }

  void _onDeleteStation(
      ConfigDeleteStation event, Emitter<ConfigState> emit) async {
    var config = (state as ConfigSuccess).config;
    config.remove(event.stationName);
    await _configService.deleteStation(event.stationName);
    emit(ConfigSuccess(config, (state as ConfigSuccess).currentStation));
  }

  void _onConfigReset(ConfigReset event, Emitter<ConfigState> emit) async {
    await _configService.resetConfig();
    var config = await _configService.getOrCreateConfig();
    emit(ConfigSuccess(config, (state as ConfigSuccess).currentStation));
  }
}
