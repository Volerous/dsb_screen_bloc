import 'package:dsb_screen_bloc/states/departure_board/departure_board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen_bloc/widgets/listtiles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dsb_screen_bloc/states/departure_board/departure_board_state.dart';

class DSBScreenListView extends StatelessWidget {
  const DSBScreenListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardBloc = context.read<DepartureBoardCubit>();
    boardBloc.startStream();
    return BlocBuilder<DepartureBoardCubit, DepartureBoardState>(
      builder: (c, state) {
        if (state.status.isSuccess) {
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
        }
        return ElevatedButton(
          child: const Center(
            child: Text("Reload"),
          ),
          onPressed: () {
            boardBloc.updateArgs();
          },
        );
      },
    );
  }
}
