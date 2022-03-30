import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Globals {
  const Globals._();

  static String? accessToken;

  // static String? fcmToken;
  // static String? deviceId;

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static final firestore = FirebaseFirestore.instance;

  static BuildContext get context => navigatorKey.currentContext!;
}
