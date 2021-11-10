import 'package:dsb_screen_bloc/states/config/config_bloc.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen_bloc/widgets/listtiles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DSBScreenListView extends StatefulWidget {
  const DSBScreenListView({Key? key, required this.initConfig})
      : super(key: key);

  final Map<String, dynamic> initConfig;
  @override
  _DSBScreenListViewState createState() => _DSBScreenListViewState();
}

class _DSBScreenListViewState extends State<DSBScreenListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DepartureBoardBloc>(context)
        .add(DepartureBoardLoad(widget.initConfig));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartureBoardBloc, DepartureBoardState>(
      builder: (c, state) {
        if (state is DepartureBoardSuccess) {
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (c, i) => const Divider(
              thickness: 2.0,
            ),
            itemCount: (state.board.departures?.length ?? 0) + 1,
            itemBuilder: (c, i) {
              if (i == 0) {
                return const ListTile(
                  leading: Text(
                    "Line",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  title: Text(
                    "Direction",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    "Min",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                );
              }
              return ListElement(departure: state.board.departures![i - 1]);
            },
          );
        } else if (state is DepartureBoardLoading ||
            state is DepartureBoardInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ElevatedButton(
            child: const Center(
              child: Text("Reload"),
            ),
            onPressed: () {
              context.read<DepartureBoardBloc>().retry();
            },
          );
        }
      },
    );
  }
}
