import 'dart:convert';

import 'package:dsb_screen_bloc/models/models.dart';
import 'package:dsb_screen_bloc/models/departure_board.dart';
import 'package:http/http.dart' as http;

class DSBRestApi {
  final String baseUrl = "xmlopen.rejseplanen.dk";
  Future<DepartureBoard> getDepartureBoard(Map<String, dynamic> config) async {
    var params = {"format": "json", ...config};
    params = params.map((key, value) => MapEntry(key, value.toString()));
    final res = await http
        .get(Uri.http(baseUrl, "/bin/rest.exe/departureBoard", params));
    // print(Uri.http(baseUrl, "/bin/rest.exe/departureBoard", params).toString());
    if (res.statusCode != 200) {
      throw Exception(res.body);
    }
    var ret = DepartureBoard.fromJson(jsonDecode(res.body)["DepartureBoard"]);
    return ret.copyWith(
        ret.departures!.where((i) => i.minutesToDeparture > 0).toList(), "");
  }

  const DSBRestApi();
}
