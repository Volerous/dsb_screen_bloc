import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_cubit.dart';
import 'package:dsb_screen_bloc/states/config/config_state.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_cubit.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_cubit.dart';
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
    context.read<ConfigCubit>().fetchConfig();
  }

  final DSBRestApi _restApi = const DSBRestApi();
  void goToSettingsPage() {
    Navigator.of(context).push<void>(
      SettingsPage.route(
        context.read<StationListCubit>(),
        context.read<ConfigCubit>(),
        false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(builder: (context, state) {
      if (state.status.isSuccess) {
        final currentStation = state.currentStation;
        final currentConfig = state.currentConfig;
        return BlocProvider<DepartureBoardCubit>(
          create: (_) => DepartureBoardCubit(
            _restApi,
            currentConfig,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(currentStation),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: goToSettingsPage,
                ),
              ],
            ),
            drawer: const StationListDrawer(),
            body: const DSBScreenListView(),
          ),
        );
      } else if (state.status.isLoading || state.status.isInital) {
        return const CircularProgressIndicator();
      } else {
        return const Text("Error");
      }
    });
  }
}
