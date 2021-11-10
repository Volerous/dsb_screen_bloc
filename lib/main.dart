import 'package:dsb_screen_bloc/services/config.dart';
import 'package:dsb_screen_bloc/services/stations.dart';
import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:dsb_screen_bloc/states/station_list/station_list_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen_bloc/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ConfigService _configService = ConfigService();
  final StationsListService _stationsListService = StationsListService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConfigBloc(_configService),
        ),
        BlocProvider(create: (_) => StationListBloc(_stationsListService))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Tex",
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
