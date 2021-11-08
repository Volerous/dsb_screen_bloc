import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dsb_screen_bloc/services/config.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc(ConfigService configService)
      : _configService = configService,
        super(ConfigInitial()) {
    on<ConfigLoad>(_onLoad);
    on<ConfigUpdateConfig>();
    on<ConfigChangeCurrentStation>();
    on<ConfigDeleteStation>();
  }
  final ConfigService _configService;
  void _onLoad(ConfigLoad event, Emitter<ConfigState> emit) async {
    emit(ConfigLoading());
    final config = await _configService.getOrCreateConfig();
    emit(ConfigLoaded(config, state.currentStation));
  }
}
