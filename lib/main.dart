import 'package:dsb_screen/models/departure.dart';
import 'package:dsb_screen/services/config.dart';
import 'package:dsb_screen/view_models/config_view_model.dart';
import 'package:dsb_screen/view_models/rest_view_model.dart';
import 'package:dsb_screen/widgets/drawer.dart';
import 'package:dsb_screen/widgets/listview.dart';
import 'package:dsb_screen/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsb_screen/services/typedefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loader = ConfigLoader();
  final conf = await loader.getOrCreateConfig();
  runApp(MyApp(config: conf));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.config}) : super(key: key);
  final StationConfigs config;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigViewModel(config: config)),
        ChangeNotifierProvider(
          create: (context) => DsbApiViewModel(
            configViewModel:
                Provider.of<ConfigViewModel>(context, listen: false),
          ),
        ),
      ],
      builder: (c, _) => MaterialApp(
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void goToSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final configModel = Provider.of<ConfigViewModel>(context);
    final restModel = Provider.of<DsbApiViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(configModel.currentStation),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: goToSettingsPage,
          ),
        ],
      ),
      drawer: const StationListDrawer(),
      body: StreamProvider(
        updateShouldNotify: (p, n) => true,
        create: (_) => restModel.board,
        initialData: DepartureBoard(),
        builder: (c, child) {
          final board = c.watch<DepartureBoard>();
          if (!board.isEmpty) {
            return DSBScreenListView(board: board);
          }
          return child!;
        },
        child: ElevatedButton(
          child: const Center(
            child: Text("Reload"),
          ),
          onPressed: () {
            restModel.updateArgs();
          },
        ),
      ),
    );
    ;
  }
}
