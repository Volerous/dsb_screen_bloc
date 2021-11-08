import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'typedefs.dart';

class ConfigService {
  ConfigService();

  Future<StationConfigs> getOrCreateConfig() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("config")) {
      var baseConfig = {
        "Hellerup St.": {
          "useBus": 1,
          "useTog": 1,
          "useMetro": 1,
          "offsetTime": 0,
          "id": "8600655"
        },
        "Ålholm St.": {
          "useBus": 1,
          "useTog": 1,
          "useMetro": 1,
          "offsetTime": 0,
          "id": "8600741"
        },
      };
      prefs.setString("config", jsonEncode(baseConfig));
    }
    final ret = jsonDecode(prefs.getString("config")!);
    return StationConfigs.from(ret);
  }

  Future<void> resetConfig() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("config");
  }

  Future<void> updateStation(
      String station, Map<String, dynamic> newConfig) async {
    final prefs = await SharedPreferences.getInstance();
    final config = await getOrCreateConfig();
    config[station] = newConfig;
    prefs.setString("config", jsonEncode(config));
  }

  Future<void> deleteStation(String station) async {
    final prefs = await SharedPreferences.getInstance();
    final config = await getOrCreateConfig();
    config.remove(station);
    await prefs.setString("config", jsonEncode(config));
  }
}
