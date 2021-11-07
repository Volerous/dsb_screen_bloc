import 'package:dsb_screen_bloc/pages/settings_page.dart';
import 'package:dsb_screen_bloc/states/config/config_cubit.dart';
import 'package:dsb_screen_bloc/states/config/config_state.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class StationListDrawer extends StatefulWidget {
  const StationListDrawer({Key? key}) : super(key: key);

  @override
  _StationListDrawerState createState() => _StationListDrawerState();
}

class _StationListDrawerState extends State<StationListDrawer> {
  @override
  void initState() {
    super.initState();
  }

  void addNewStation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(
          isNewStation: true,
        ),
      ),
    );
  }

  void showDeleteDialog(
    String station,
    String newStation,
    Map<String, dynamic> newStationConfig,
  ) {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("Remove $station?"),
            content: Text("Remove $station from favorites?"),
            actions: [
              TextButton(
                child: const Text("YES"),
                onPressed: () {
                  final vm = c.read<ConfigCubit>();
                  vm.updateCurrentStation(newStation);
                  vm.deleteStation(station);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("NO"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (ctx, state) {
        final configState = state;
        final configCubit = ctx.watch<ConfigCubit>();
        return Drawer(
          child: ListView.builder(
            itemCount: configState.keys.length + 2,
            itemBuilder: (c, i) {
              if (i == configState.keys.length + 1) {
                return ListTile(
                  title: TextButton(
                    child: const Text("RESET"),
                    onPressed: configCubit.resetConfig,
                  ),
                );
              } else if (i == configState.keys.length) {
                return TextButton(
                  onPressed: addNewStation,
                  child: const Text("Add Station"),
                );
              } else {
                return ListTile(
                  title: Text(configState.keys[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDeleteDialog(
                          configState.keys[i],
                          configState.keys
                              .firstWhere((e) => e != configState.keys[i]),
                          configState.config[configState.keys
                              .firstWhere((e) => e != configState.keys[i])]);
                    },
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<DepartureBoardCubit>(context).updateArgs(
                        newConfig: configState.config[configState.keys[i]]);
                    configCubit.updateCurrentStation(configState.keys[i]);
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
