import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dsb_screen_bloc/services/typedefs.dart';
part 'config.g.dart';

@JsonSerializable()
class Config extends Equatable {
  Config({StationConfigs? config, String? currentStation}) {
    config = config;
  }
  late final StationConfigs? config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  factory Config.empty() => Config();
  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  @override
  List<Object?> get props => [config];

  List<String> get keys {
    final keys = config?.keys.toList() ?? [];
    keys.sort();
    return keys;
  }

  Config copyWith({StationConfigs? config, String? newStation}) {
    return Config(config: config ?? this.config);
  }
}
