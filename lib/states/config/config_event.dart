part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class ConfigLoad extends ConfigEvent {}

class UpdateStationConfig extends ConfigEvent {
  final Map<String, dynamic> config;
  final String stationName;
  const UpdateStationConfig(this.config, this.stationName);
  @override
  List<Object> get props => [config, stationName];
}

class ConfigChangeCurrentStation extends ConfigEvent {
  final String stationName;

  const ConfigChangeCurrentStation(this.stationName);

  @override
  List<Object> get props => [stationName];
}

class ConfigDeleteStation extends ConfigEvent {
  final String stationName;

  const ConfigDeleteStation(this.stationName);

  @override
  List<Object> get props => [stationName];
}

class ConfigReset extends ConfigEvent {}
