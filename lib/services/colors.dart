import 'package:dsb_screen_bloc/models/departure.dart';
import 'package:flutter/material.dart';

class DSBColors {
  const DSBColors();
  static const Color icRed = Color.fromARGB(255, 239, 65, 48);
  static const Color regGreen = Color.fromARGB(255, 80, 183, 72);
  static const Color aTrainBlue = Color.fromARGB(255, 0, 178, 239);
  static const Color bTrainGreen = Color.fromARGB(255, 80, 184, 72);
  static const Color cTrainOrange = Color.fromARGB(255, 245, 138, 31);
  static const Color eTrainPurple = Color.fromARGB(255, 118, 112, 178);
  static const Color fTrainYellow = Color.fromARGB(255, 255, 194, 14);
  static const Color busYellow = Color.fromARGB(255, 253, 174, 0);
  static const Color aBusRed = Color.fromARGB(255, 184, 33, 28);
  static const Color cBusBlue = Color.fromARGB(255, 0, 165, 204);
  static const Color sBusBlue = Color.fromARGB(255, 0, 101, 170);
  static const Color m3m4Red = Color.fromARGB(255, 255, 10, 10);
  static const Color m1m2Green = Color.fromARGB(255, 80, 183, 72);

  static Color getFromInfo(DepartureType type, String? line) {
    if (type == DepartureType.reg) return regGreen;
    line = line!;
    if (type == DepartureType.exb) {
      if (line.contains("S")) return sBusBlue;
    }
    if (type == DepartureType.bus) {
      if (line.contains("A")) return aBusRed;

      if (line.contains("C")) {
        return cBusBlue;
      } else {
        return busYellow;
      }
    }
    if (type == DepartureType.s) {
      switch (line) {
        case "A":
          return aTrainBlue;
        case "B":
          return bTrainGreen;
        case "C":
          return cTrainOrange;
        case "E":
          return eTrainPurple;
        case "F":
          return fTrainYellow;
      }
    }
    return icRed;
  }
}
