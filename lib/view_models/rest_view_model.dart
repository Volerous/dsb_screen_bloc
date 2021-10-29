import 'dart:async';

import 'package:dsb_screen/models/departure.dart';
import 'package:dsb_screen/services/rest.dart';
import 'package:dsb_screen/view_models/config_view_model.dart';
import 'package:flutter/material.dart';

class DsbApiViewModel extends ChangeNotifier {
  DsbApiViewModel({required ConfigViewModel configViewModel}) {
    _configViewModel = configViewModel;
    startStream();
    updateArgs();
  }
  final DSBRestApi _api = const DSBRestApi();
  late final ConfigViewModel _configViewModel;
  late Timer _timer;
  final StreamController<DepartureBoard> _boardStreamController =
      StreamController();
  Stream<DepartureBoard> get board => _boardStreamController.stream;
  Stream<void> departureBoard() async* {
    while (true) {
      await Future.delayed(
        const Duration(seconds: 5),
      );
      _boardStreamController
          .add(await _api.getDepartureBoard(_configViewModel.currentConfig));
    }
  }

  void startStream() {
    _timer = Timer.periodic(const Duration(seconds: 5), (t) async {
      updateArgs();
    });
  }

  Future<void> updateArgs() async {
    _boardStreamController
        .add(await _api.getDepartureBoard(_configViewModel.currentConfig));
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _boardStreamController.close();
  }
}
