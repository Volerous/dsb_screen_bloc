import 'dart:async';

import 'package:dsb_screen_bloc/services/config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './config_state.dart';

class ConfigCubit extends HydratedCubit<ConfigState> {
  ConfigCubit(
    this._configLoader,
  ) : super(const ConfigState());
  final ConfigLoader _configLoader;

  Future<void> fetchConfig() async {
    emit(state.copyWith(status: ConfigStatus.loading));
    final config = await _configLoader.getOrCreateConfig();
    emit(state.copyWith(config: config, status: ConfigStatus.success));
  }

  @override
  ConfigState fromJson(Map<String, dynamic> json) => ConfigState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ConfigState state) => state.toJson();

  Future<void> updateStationConfig(
      String station, Map<String, dynamic> newConfig) async {
    await _configLoader.updateStation(station, newConfig);
    await fetchConfig();
  }

  Future<void> deleteStation(String station) async {
    await _configLoader.deleteStation(station);
    await fetchConfig();
  }

  Future<void> resetConfig() async {
    await _configLoader.resetConfig();
    await fetchConfig();
  }

  void updateCurrentStation(String station) {
    emit(state.copyWith(status: ConfigStatus.success, currentStation: station));
  }
}
