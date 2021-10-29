import 'package:dsb_screen/pages/settings.dart';
import 'package:dsb_screen/view_models/config_view_model.dart';
import 'package:dsb_screen/view_models/rest_view_model.dart';
import 'package:flutter/material.dart';
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
    // Provider.of<ConfigViewModel>(context).fetchConfig();
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
                  final vm =
                      Provider.of<ConfigViewModel>(context, listen: false);
                  vm.changeStation(newStation);
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
    final viewModel = Provider.of<ConfigViewModel>(context);
    return Drawer(
      child: ListView.builder(
        itemCount: viewModel.config.keys.length + 2,
        itemBuilder: (c, i) {
          if (i == viewModel.config.length + 1) {
            return ListTile(
              title: TextButton(
                child: const Text("RESET"),
                onPressed: viewModel.resetConfig,
              ),
            );
          } else if (i == viewModel.config.length) {
            return TextButton(
              onPressed: addNewStation,
              child: const Text("Add Station"),
            );
          } else {
            return ListTile(
              title: Text(viewModel.keys[i]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDeleteDialog(
                      viewModel.keys[i],
                      viewModel.keys.firstWhere((e) => e != viewModel.keys[i]),
                      viewModel.config[viewModel.keys
                          .firstWhere((e) => e != viewModel.keys[i])]);
                },
              ),
              onTap: () {
                Navigator.pop(context);
                viewModel.changeStation(viewModel.keys[i]);
                Provider.of<DsbApiViewModel>(context, listen: false)
                    .updateArgs();
              },
            );
          }
        },
      ),
    );
  }
}
