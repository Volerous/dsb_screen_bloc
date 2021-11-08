part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class ConfigLoad extends ConfigEvent {}

class ConfigUpdateConfig extends ConfigEvent {
  final Map<String, dynamic> config;
  const ConfigUpdateConfig(this.config);
  @override
  List<Object> get props => [config];
}

class ConfigChangeCurrentStation extends ConfigEvent {
  final String station;

  const ConfigChangeCurrentStation({required this.station});

  @override
  List<Object> get props => [station];
}

class ConfigDeleteStation extends ConfigEvent {
  final String station;

  const ConfigDeleteStation({required this.station});

  @override
  List<Object> get props => [station];
}
