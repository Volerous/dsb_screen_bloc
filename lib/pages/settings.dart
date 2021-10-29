import 'package:dsb_screen/view_models/config_view_model.dart';
import 'package:dsb_screen/view_models/rest_view_model.dart';
import 'package:dsb_screen/view_models/station_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, this.isNewStation = false}) : super(key: key);

  final bool isNewStation;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> config;
  late String name;

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<ConfigViewModel>(context, listen: false);
    config = vm.currentConfig;
    name = widget.isNewStation ? "New Station" : vm.currentStation;
  }

  @override
  Widget build(BuildContext context) {
    final configModel = Provider.of<ConfigViewModel>(context);
    return ChangeNotifierProvider(
      create: (_) => StationListViewModel(),
      builder: (context, child) {
        final stationModel = Provider.of<StationListViewModel>(context);
        stationModel.fetchStations();
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(name),
              actions: [
                IconButton(
                  onPressed: () {
                    configModel.updateStation(name, config);
                    Provider.of<DsbApiViewModel>(context, listen: false)
                        .updateArgs();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                )
              ],
            ),
            body: FutureProvider(
              create: (_) => stationModel.fetchStations(),
              initialData: null,
              builder: (context, child) {
                return Column(
                  children: [
                    if (widget.isNewStation)
                      Autocomplete<String>(
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          final ret =
                              stationModel.stationNames.where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                          return ret;
                        },
                        onSelected: (selectedStation) {
                          setState(() {
                            name = selectedStation;
                            config["id"] =
                                stationModel.stationMap[selectedStation];
                          });
                        },
                      ),
                    ListTile(
                      title: const Text("Show Buses"),
                      trailing: Checkbox(
                        value: config["useBus"] == 1,
                        onChanged: (c) {},
                      ),
                      onTap: () {
                        setState(() {
                          config["useBus"] = (config["useBus"] - 1).abs();
                        });
                      },
                    ),
                    ListTile(
                      title: const Text("Show Trains"),
                      trailing: Checkbox(
                        value: config["useTog"] == 1,
                        onChanged: (c) {},
                      ),
                      onTap: () {
                        setState(() {
                          config["useTog"] = (config["useTog"] - 1).abs();
                        });
                      },
                    ),
                    ListTile(
                      title: const Text("Show Metro"),
                      trailing: Checkbox(
                        value: config["useMetro"] == 1,
                        onChanged: (c) {},
                      ),
                      onTap: () {
                        setState(() {
                          config["useMetro"] = (config["useMetro"] - 1).abs();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(child: Text("Offset Minutes")),
                        Flexible(
                          child: TextFormField(
                            onSaved: (value) {
                              config["offsetTime"] = value;
                            },
                            keyboardType: TextInputType.number,
                            initialValue: config["offsetTime"].toString(),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
