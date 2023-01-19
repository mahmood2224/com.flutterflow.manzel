import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:manzel/auth/auth_util.dart';
import 'package:manzel/auth_flow/data/firestore/firestore_auth_Service.dart';
import 'package:manzel/backend/backend.dart';
import 'package:manzel/backend/firebase_analytics/analytics.dart';
import 'package:manzel/enviorment/env_variables.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/flutter_flow/internationalization.dart';
import 'package:manzel/main.dart';
import 'package:manzel/notification_handler/firebase_cloud_messaging.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() => _instance;
  final _firebaseAuth = auth.FirebaseAuth.instance;

  String? _token;

  auth.User? _user;

  get token => _token;

  bool isLogin = false;
  StreamSubscription<auth.User?>? _refreshTokenListener;

  init() async {
    if (_firebaseAuth.currentUser != null) {
      isLogin = true;
      _token = (await _firebaseAuth.currentUser!.getIdTokenResult(true)).token;
      _startListener();
    }
  }

  _startListener() {
    _refreshTokenListener = _firebaseAuth.idTokenChanges().listen((user) async {
      if (user != null) {
        _token = (await user.getIdTokenResult(true)).token;
      }
    });
  }

  notifySignIn({required String phoneNumber ,String? token, required Function() onSuccess}) async {
    if (token != null) {
      // _user = (await _firebaseAuth.signInWithCustomToken(token)).user;
      final authFireStore = FireStoreAuthService();
      final isFirstTime = await authFireStore.checkIsFirstTimeUser(phoneNumber);
      final user = await authFireStore.getUserData(phoneNumber);

    }

    if (_firebaseAuth.currentUser != null) {
      isLogin = true;
      _token = (await _firebaseAuth.currentUser!.getIdTokenResult(true)).token;
      _startListener();
    }
  }

}
