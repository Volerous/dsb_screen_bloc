import 'package:dsb_screen/services/stations.dart';
import 'package:flutter/cupertino.dart';
import 'package:dsb_screen/services/typedefs.dart';

class StationListViewModel extends ChangeNotifier {
  StationListViewModel();
  late Map<String, String> _stationMap;
  late List<StationName> _stationNames;
  final StationsListService _stationsListService = StationsListService();
  Map<String, String> get stationMap => _stationMap;
  List<String> get stationNames => _stationNames;
  Future<void> fetchStations() async {
    _stationMap = await _stationsListService.getStationsMap();
    _stationNames = _stationMap.keys.toList();
    _stationNames.sort();
    notifyListeners();
  }
}
