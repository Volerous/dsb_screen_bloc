import 'package:dsb_screen_bloc/services/stations.dart';
import 'package:dsb_screen_bloc/states/config/config_cubit.dart';
import 'package:dsb_screen_bloc/states/config/config_state.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_cubit.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, this.isNewStation = false}) : super(key: key);

  final bool isNewStation;

  @override
  SettingsPageState createState() => SettingsPageState();

  static Route route(StationListCubit stationListCubit, ConfigCubit configCubit,
      bool isNewStation) {
    return MaterialPageRoute<void>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: stationListCubit),
          BlocProvider.value(value: configCubit),
        ],
        child: SettingsPage(isNewStation: isNewStation),
      ),
    );
  }
}

class SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> config;
  late String name;

  @override
  void initState() {
    super.initState();
    final vm = context.read<ConfigCubit>();
    context.read<StationListCubit>().fetchConfig();
    // config = vm.currentConfig;
    // name = widget.isNewStation ? "New Station" : vm.currentStation;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          actions: [
            BlocBuilder(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context
                        .read<ConfigCubit>()
                        .updateStationConfig(name, config);
                    context.read<DepartureBoardCubit>().updateArgs();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
            if (widget.isNewStation)
              BlocBuilder<StationListCubit, StationListState>(
                bloc: StationListCubit(StationsListService()),
                builder: (context, state) {
                  context.read<StationListCubit>().fetchConfig();
                  if (state.status.isSuccess) {
                    return Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        final ret = state.stationNames.where((String option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });

                        return ret;
                      },
                      onSelected: (selectedStation) {
                        setState(() {
                          name = selectedStation;
                          config["id"] = state.stationMap[selectedStation];
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
  }
}
