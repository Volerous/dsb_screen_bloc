import 'package:dsb_screen_bloc/services/stations.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {Key? key, this.isNewStation = false, this.stationName = "New Station"})
      : super(key: key);

  final bool isNewStation;
  final String stationName;

  @override
  SettingsPageState createState() => SettingsPageState();

  static Route route(
    StationListBloc stationListCubit,
    ConfigBloc configCubit,
    bool isNewStation,
  ) {
    return MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: stationListCubit),
          BlocProvider.value(value: configCubit),
        ],
        child: SettingsPage(
          isNewStation: isNewStation,
        ),
      ),
    );
  }
}

class SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> config = {
    "useBus": 1,
    "useTog": 1,
    "useMetro": 1,
    "offsetTime": 0,
    "id": null
  };
  late String name;

  @override
  void initState() {
    super.initState();
    context.read<StationListBloc>().add(StationListLoad());
    name = widget.stationName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        if (state is ConfigSuccess) {
          print(state.currentConfig);
          if (!widget.isNewStation) config = state.currentConfig;
          return Form(
            key: _formKey,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  title: Text(state.currentStation),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<ConfigBloc>().add(UpdateStationConfig(
                            config,
                            widget.isNewStation ? name : state.currentStation));
                        Navigator.pop(context);
                        if (widget.isNewStation) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.save),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  if (widget.isNewStation)
                    BlocBuilder<StationListBloc, StationListState>(
                      bloc: StationListBloc(StationsListService()),
                      builder: (context, state) {
                        context.read<StationListBloc>().loadStation();
                        if (state is StationListSuccess) {
                          return Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }
                              final ret =
                                  state.stationNames.where((String option) {
                                return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });

                              return ret;
                            },
                            onSelected: (selectedStation) {
                              setState(() {
                                name = selectedStation;
                                config["id"] =
                                    state.stationMap[selectedStation];
                              });
                            },
                          );
                        } else {
                          return const TextField();
                        }
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else if (state is ConfigLoading || state is ConfigInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
