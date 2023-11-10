import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMessage(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}

String getFormattedDateTime(DateTime dateTime, String format) =>
    DateFormat(format).format(dateTime);