import 'package:dsb_screen_bloc/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:dsb_screen_bloc/models/departure.dart';

class ListElement extends StatefulWidget {
  const ListElement({Key? key, required this.departure}) : super(key: key);
  final Departure departure;
  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.departure.direction!,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: SizedBox(
        width: 30.0,
        height: 24.0,
        child: DecoratedBox(
          child: Center(
            child: Text(
              widget.departure.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: DSBColors.getFromInfo(
                widget.departure.type!, widget.departure.line),
          ),
        ),
      ),
      trailing: Text(
        "${widget.departure.minutesToDeparture}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
