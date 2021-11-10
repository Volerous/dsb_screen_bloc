import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dsb_screen_bloc/services/config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc(ConfigService configService)
      : _configService = configService,
        super(ConfigInitial()) {
    on<ConfigLoad>(_onLoad);
    on<UpdateStationConfig>(_onUpdateConfig);
    on<ConfigChangeCurrentStation>(_onUpdateCurrentStation);
    on<ConfigDeleteStation>(_onDeleteStation);
    on<ConfigReset>(_onConfigReset);
  }

  final ConfigService _configService;

  void _onLoad(ConfigLoad event, Emitter<ConfigState> emit) async {
    var currentStation = "";
    if (state is ConfigSuccess) {
      currentStation = (state as ConfigSuccess).currentStation;
    }
    emit(ConfigLoading());
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
