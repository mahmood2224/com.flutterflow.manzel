import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:manzel/auth/auth_util.dart';
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

  notifySignIn({String? token, required Function() onSuccess}) async {
    if (token != null) {
      _user = (await _firebaseAuth.signInWithCustomToken(token)).user;
      if (_user != null) {
        maybeCreateUser(_user!);
        _handleAuth(onSuccess);
      }
    }

    if (_firebaseAuth.currentUser != null) {
      isLogin = true;
      _token = (await _firebaseAuth.currentUser!.getIdTokenResult(true)).token;
      _startListener();
    }
  }

  _handleAuth(Function() onSuccess) {
    BuildContext context = router!.navigator!.context;
    final loginDate = DateTime.now();
    Future.delayed(const Duration(milliseconds: 200), () async {
      if (currentUserDocument!.status!.isEmpty ||
          currentUserDocument!.status!.toLowerCase() == 'active') {
        logFirebaseEvent('login');
        final userUpdateData = await createUserRecordData(
            status: 'Active',
            language: FFLocalizations.of(context).languageCode,
            lastLogin: loginDate,
            deviceToken:
                await FirebaseMessagingUtils.getPushNotificationToken(),
            isDeleted: 0);
        if (currentUserDocument!.status!.isEmpty) {
          logFirebaseEvent('sign_up');
          userUpdateData.addAll({'created_time': loginDate});
          userUpdateData.addAll({'last_login': loginDate});
        }

        await currentUserReference?.update(userUpdateData);

        if (currentUserDisplayName.isEmpty &&
            currentUserDocument!.name!.isEmpty) {
          final _sendbird = await SendbirdSdk(
              appId: "${EnvVariables.instance.sendbirdAppId}");
          final _ = await _sendbird.connect(currentUserUid);

          onSuccess();
        }
      } else {
        //TODO handle this case too
      }
    });
  }
}
