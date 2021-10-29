import 'package:dsb_screen/services/config.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen/services/typedefs.dart';

class ConfigViewModel extends ChangeNotifier {
  ConfigViewModel({required StationConfigs config}) {
    _config = config;
    _keys = _config.keys.toList();
    _keys.sort();
    _firstStation = _keys.toList().first;
    _currentStation ??= _firstStation;
  }

  final ConfigLoader _configLoader = ConfigLoader();
  StationConfigs _config = const {};
  late String _firstStation;
  String? _currentStation;
  late List<String> _keys;
  Map<String, dynamic> get config => _config;
  String get firstStation => _firstStation;
  String get currentStation => _currentStation ?? _firstStation;
  Map<String, dynamic> get currentConfig => config[currentStation];
  List<String> get keys => _keys;

  Future<StationConfigs> fetchConfig() async {
    _config = await _configLoader.getOrCreateConfig();
    _keys = _config.keys.toList();
    _keys.sort();
    _firstStation = _keys.toList().first;
    _currentStation ??= _firstStation;
    return _config;
  }

  Future<void> updateStation(
      String station, Map<String, dynamic> newConfig) async {
    await _configLoader.updateStation(station, newConfig);
    await fetchConfig();
    notifyListeners();
  }

  Future<void> deleteStation(String station) async {
    await _configLoader.removeStation(station);
    await fetchConfig();
    notifyListeners();
  }

  Future<void> resetConfig() async {
    await _configLoader.resetConfig();
    await fetchConfig();
    notifyListeners();
  }

  void changeStation(String station) {
    _currentStation = station;
    notifyListeners();
  }
}
