import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'config_state.g.dart';

enum ConfigStatus { initial, loading, success, failure }

extension ConfigStatusX on ConfigStatus {
  bool get isInital => this == ConfigStatus.initial;
  bool get isLoading => this == ConfigStatus.loading;
  bool get isSuccess => this == ConfigStatus.success;
  bool get isFailure => this == ConfigStatus.failure;
}

@JsonSerializable()
class ConfigState extends Equatable {
  const ConfigState({
    this.status = ConfigStatus.initial,
    Map<String, dynamic>? conf,
    String currStation = "",
  })  : config = conf ?? const {"": ""},
        _currentStation = currStation;

  factory ConfigState.fromJson(Map<String, dynamic> json) =>
      _$ConfigStateFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigStateToJson(this);

  final ConfigStatus status;
  final Map<String, dynamic> config;
  final String _currentStation;

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
  List<Object?> get props => [status, config, currentStation];

  ConfigState copyWith(
      {ConfigStatus? status,
      Map<String, dynamic>? config,
      String? currentStation}) {
    return ConfigState(
      conf: config ?? this.config,
      status: status ?? this.status,
      currStation: currentStation ?? this.currentStation,
    );
  }
}
