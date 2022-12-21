import 'dart:async';

import 'package:manzel/enviorment/env_variables.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryAnalytics {
  static final SentryAnalytics _singleton = SentryAnalytics._internal();
  static final bool _trackApiMisuse = true;
  bool _logOnServer = false;

  factory SentryAnalytics() {
    return _singleton;
  }

  SentryAnalytics._internal();

  Future<void> init({bool logOnServer = false}) async {
    try {
      _logOnServer = logOnServer;
      if (_logOnServer) {
        await SentryFlutter.init((options) {
          options.dsn = EnvVariables.instance.sentryDsn;
          options.tracesSampleRate = 1.0;
          options.environment = EnvVariables.instance.sentryEnvironment;
          options.enableAutoSessionTracking = true;
          options.tracesSampler = (samplingContext) {
            // return a number between 0 and 1 or null (to fallback to configured value)
          };
        });
      } else {
        print('Not initialising Sentry in debug mode');
        //LoggingService().printLog(message: 'Not initialising Sentry in debug mode');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void captureException(error, stackTrace) {
    if (_logOnServer) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    } else {
      print(error.toString());
     // LoggingService().printLog(message: error.toString());
    }
  }

  // Future<void> setUserScope(String userId, String email) async {
  //   var model = SystemInfoHelpers.getInstance.deviceInfoModel;
  //   if (_logOnServer) {
  //     Sentry.configureScope(
  //           (scope) => scope.user =
  //           SentryUser(id: userId, email: email, extras: model.toJsonMap()),
  //     );
  //   } else {
  //     LoggingService().printLog(message: model.toJsonMap().toString());
  //   }
  // }

  void apiTracking(Map<String, dynamic>? map) {
    if (map != null && map.isNotEmpty && _trackApiMisuse && _logOnServer) {
      var message = map.toString();
      Sentry.captureMessage(message,
          level: SentryLevel.debug,
          template: 'ApiMismatchCheck',
          hint: 'Debugging if api\'s are being misused or not');
    }
  }

}