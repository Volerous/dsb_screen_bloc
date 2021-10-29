import 'package:flutter/services.dart' show rootBundle;
import 'typedefs.dart';

class StationsListService {
  StationsListService();
  Future<Map<StationName, StationId>> getStationsMap() async {
    final rawData =
        await rootBundle.loadString("assets/RejseplanenStoppesteder.csv");
    final ret = rawData.split("\n");
    ret.removeAt(0);
    ret.removeLast();
    final r = <String, String>{
      for (List<String> e in ret.map<List<String>>((s) => s.split(";")))
        e[1].replaceAll("\"", ""): e[0]
    };
    return r;
  }
}
