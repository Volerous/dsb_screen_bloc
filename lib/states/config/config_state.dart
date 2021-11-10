part of 'config_bloc.dart';

abstract class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

class ConfigInitial extends ConfigState {}

class ConfigLoading extends ConfigState {}

class ConfigFailed extends ConfigState {}

class ConfigSuccess extends ConfigState {
  final Map<String, dynamic> config;
  final String _currentStation;

  const ConfigSuccess(this.config, String currentStation)
      : _currentStation = currentStation;

  String get currentStation {
    if (_currentStation == "") {
      return stationNames.first;
    }
    return _currentStation;
  }

  Map<String, dynamic> get currentConfig {
    return config[currentStation];
  }

  List<String> get keys {
    final keys = config.keys.toList();
    keys.sort();
    return keys;
  }

  List<String> get stationNames {
    final stationNames = config.keys.toList();
    stationNames.sort();
    return stationNames;
  }

  @override
  List<Object> get props => [config, currentStation];
}
