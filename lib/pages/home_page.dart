import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_bloc.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_bloc.dart';
import 'package:dsb_screen_bloc/widgets/drawer.dart';
import 'package:dsb_screen_bloc/widgets/listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ConfigBloc>().add(ConfigLoad());
  }

  final DSBRestApi _restApi = const DSBRestApi();
  void goToSettingsPage(DepartureBoardBloc departureBoardBloc) {
    Navigator.of(context).push<void>(
      SettingsPage.route(
        context.read<StationListBloc>(),
        context.read<ConfigBloc>(),
        false,
      ),
    );
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
      if (state is ConfigSuccess) {
        return BlocProvider<DepartureBoardBloc>(
          create: (_) =>
              DepartureBoardBloc(_restApi, context.watch<ConfigBloc>()),
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.currentStation),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    goToSettingsPage(context.read<DepartureBoardBloc>());
                  },
                ),
              ],
            ),
            drawer: const StationListDrawer(),
            body: DSBScreenListView(initConfig: state.currentConfig),
          ),
        );
      } else if (state is ConfigLoading || state is ConfigInitial) {
        return const CircularProgressIndicator();
      } else {
        return const Text("Error");
      }
    });
  }
}
