import 'package:dsb_screen_bloc/services/rest.dart';
import 'package:dsb_screen_bloc/states/config/config_cubit.dart';
import 'package:dsb_screen_bloc/states/config/config_state.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_cubit.dart';
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
    context.read<ConfigCubit>().fetchConfig();
  }

  final DSBRestApi _restApi = const DSBRestApi();
  void goToSettingsPage(DepartureBoardCubit departureBoardCubit) {
    Navigator.of(context).push<void>(
      SettingsPage.route(
        context.read<StationListBloc>(),
        context.read<ConfigCubit>(),
        departureBoardCubit,
        false,
      ),
    );
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<ConfigCubit, ConfigState>(builder: (context, state) {
      if (state.status.isSuccess) {
        return BlocProvider<DepartureBoardCubit>(
          create: (_) => DepartureBoardCubit(
            _restApi,
            state.currentConfig,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.currentStation),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    goToSettingsPage(context.read<DepartureBoardCubit>());
                  },
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
