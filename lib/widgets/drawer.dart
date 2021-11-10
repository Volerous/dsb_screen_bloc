import 'package:dsb_screen_bloc/pages/settings_page.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
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
    context.read<ConfigBloc>().add(ConfigLoad());
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
                  final vm = c.read<ConfigBloc>();
                  vm.add(ConfigChangeCurrentStation(newStation));
                  vm.add(ConfigDeleteStation(station));
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
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (ctx, state) {
        if (state is ConfigSuccess) {
          final configBloc = ctx.watch<ConfigBloc>();
          return Drawer(
            child: ListView.builder(
              itemCount: state.keys.length + 2,
              itemBuilder: (c, i) {
                if (i == state.keys.length + 1) {
                  return ListTile(
                    title: TextButton(
                      child: const Text("RESET"),
                      onPressed: () {
                        configBloc.add(ConfigReset());
                      },
                    ),
                  );
                } else if (i == state.keys.length) {
                  return TextButton(
                    onPressed: addNewStation,
                    child: const Text("Add Station"),
                  );
                } else {
                  return ListTile(
                    title: Text(state.keys[i]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDeleteDialog(
                            state.keys[i],
                            state.keys.firstWhere((e) => e != state.keys[i]),
                            state.config[state.keys
                                .firstWhere((e) => e != state.keys[i])]);
                      },
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      configBloc.add(ConfigChangeCurrentStation(state.keys[i]));
                    },
                  );
                }
              },
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
