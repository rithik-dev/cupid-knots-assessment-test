import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';

void showSnackBar(
  String text, {
  Duration duration = const Duration(seconds: 2),
}) {
  Globals.scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(text), duration: duration),
  );
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

String capitalizeFirst(String? text) => isNullOrBlank(text)
    ? ''
    : '${text?[0].toUpperCase()}${text?.substring(1).toLowerCase()}';

void log(
  String screenId, {
  dynamic msg,
  dynamic error,
  StackTrace? stackTrace,
}) =>
    devtools.log(
      msg.toString(),
      error: error,
      name: screenId,
      stackTrace: stackTrace,
    );

// Size getParagraphSize(
//   String? text, {
//   TextStyle? style,
// }) {
//   final textPainter = TextPainter(
//     text: TextSpan(text: text, style: style),
//     textDirection: TextDirection.ltr,
//   )..layout(minWidth: 0, maxWidth: double.infinity);
//   return textPainter.size;
// }
