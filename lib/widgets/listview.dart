import 'package:dsb_screen/models/departure.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen/widgets/listtiles.dart';

class DSBScreenListView extends StatelessWidget {
  const DSBScreenListView({Key? key, required this.board}) : super(key: key);
  final DepartureBoard board;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (c, i) => const Divider(
        thickness: 2.0,
      ),
      itemCount: (board.departures.length) + 1,
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
        return ListElement(departure: board.departures[i - 1]);
      },
    );
  }
}
