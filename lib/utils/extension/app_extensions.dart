import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension ParseToStringDate on int {
  String getParsedDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat.yMMMMEEEEd().format(dateTime);
  }

  String getParsedDateDay() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat.E().format(dateTime);
  }

  String getParsedDay() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat("d MMM").format(dateTime);
  }

  String getParsedHour() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat("hh:mm a").format(dateTime);
  }
}

extension ParseImageURL on String {
  String getWeatherIconUrl() {
    return "https://openweathermap.org/img/wn/$this@2x.png";
  }
}

extension FormattedDateTime on DateTime {
  String toFormattedString() {
    var formatter = DateFormat('EEEE, MMMM dd, yyyy');
    return formatter.format(this);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z]{3,}@([a-zA-Z]+\.)+(com|ru)$');
    return emailRegex.hasMatch(this);
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
