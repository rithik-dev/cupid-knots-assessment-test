import 'dart:async';
import 'dart:io' show SocketException;

import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

const _id = 'ErrorHandler';

FutureOr<T?> handleError<T>(
  FutureOr Function() fn, {
  FutureOr Function()? onSuccess,
  FutureOr Function()? onError,
  bool showError = true,
  bool popOnSuccess = false,
  String? errorMessage,
}) async {
  onSuccess ??= () => stopLoading(Globals.context);
  onError ??= () => stopLoading(Globals.context);

  try {
    final res = await fn();
    try {
      await onSuccess();
    } catch (_) {}
    if (popOnSuccess) Navigator.pop(Globals.context);
    return res;
  } catch (e, stackTrace) {
    log(_id, error: e, stackTrace: stackTrace);

    if (showError) _showErrorMessage(e, errorMessage);

    try {
      final err = await onError();
      return err;
    } catch (_) {}
  }
  return null;
}

void _showErrorMessage(
  dynamic e, [
  String? errorMessage,
]) {
  void _show(String msg) {
    try {
      showSnackBar(msg);
    } catch (_) {}
  }

  if (errorMessage != null) return _show(errorMessage);

  if (e is DioError && e.response!.statusCode! >= 500) return;

  String? msg;
  if (e is DioError || e is SocketException) {
    if ((e is DioError && e.type == DioErrorType.other) ||
        e is SocketException) {
      msg = 'Please check your network connection!';
    } else if (e is DioError &&
        (e.type == DioErrorType.sendTimeout ||
            e.type == DioErrorType.connectTimeout)) {
      msg = 'Error in connecting to the server!';
    } else {
      msg = (e is DioError && e.response?.data is Map)
          ? (e.response?.data?['message'])
          : null;
    }
  }
  msg ??= 'Something went wrong!';
  _show(msg);
}
