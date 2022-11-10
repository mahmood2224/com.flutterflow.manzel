import 'dart:io';

import 'dart:async';

import 'package:eraser/eraser.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';
import 'backend/push_notifications/push_notifications_util.dart';
import 'enviorment/env_variables.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import 'notification_handler/firebase_cloud_messaging.dart';

const _kTestingCrashlytics = false;

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp());
  }, (error, stackTrace) {
 //   FirebaseCrashlytics.instance.recordError(error, stackTrace,fatal: true);
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EnvVariables.instance.initialise();
  //await printBuildNumber();
  Eraser.resetBadgeCountButKeepNotificationsInCenter();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // FirebaseCloudMessaging().init();

  FFAppState(); // Initialize FFAppState
  //versionCheck();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<ManzelFirebaseUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  final update_result = [];

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  // final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);
    userStream = manzelFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    Future.delayed(
      Duration(seconds: 1),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
    // _firebaseMessaging.getToken().then((value) {
    //   print('Your FCM token:- $value');
    // });
    handleDynamicLinks();
    _initializeFlutterFire();

  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
     await FirebaseCrashlytics.instance
         .setCrashlyticsCollectionEnabled(!kDebugMode);
      // await FirebaseCrashlytics.instance
      //     .setCrashlyticsCollectionEnabled(true);
    }

    // if (_kShouldTestAsyncErrorOnInit) {
    //   await _testAsyncErrorOnInit();
    // }
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Manzel',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      themeMode: _themeMode,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  Future<void> handleDynamicLinks() async {
    PendingDynamicLinkData? _pendingLinks =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLinks(_pendingLinks);
    FirebaseDynamicLinks.instance.onLink.listen(_handleDeepLinks,
        onError: (Object error) {
      debugPrint('Error while deeplinking ###### ${error.toString()}');
    });
  }



  void _handleDeepLinks(PendingDynamicLinkData? data) {
    Uri? deeplinkUri = data?.link;
    // LoggingService().printLog(message: 'Deeplink Url - > $deeplinkUri',tag: _TAG);
    if (deeplinkUri != null) {
      Map<String, dynamic> params = deeplinkUri.queryParameters;
      if (params.isNotEmpty) {
        // if(params[AppConstants.kVideoId]!=null) {
        //   _sharedVideoAction(params[AppConstants.kVideoId]);
        // }else if(params[AppConstants.kPropertyIdParam]!=null&&params[AppConstants.kOrderId]!=null){
        //   if(GlobalVariables.isAuthenticated) {
        //     _handleMyOrderAction(params[AppConstants.kOrderIdParam],
        //         params[AppConstants.kPropertyIdParam]);
        //   }
        // } else if(params[AppConstants.kPropertyIdParam] != null || params[AppConstants.kProjectIdParam] != null){
        //   _shareProjectOrPropertyAction(params);
        // }
        // Future.delayed(Duration(seconds: 5),(){
        BuildContext? ctx = _router.routerDelegate.navigatorKey.currentContext;
        ctx?.pushNamed(
          'PropertyDetails',
          queryParams: {
            'propertyId': params['propertyId'],
            'path': '',
          },
        );

        //  });

      }
    }
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomeScreen';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await versionCheck(context);});
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }
  Future<void> showUpdateDialog(
      BuildContext context, bool isForceUpdate, String packageName) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            FFAppState().locale == 'en'
                ? "New Update Available"
                : " تحديث جديد متاح ",
            style: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'AvenirArabic',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              useGoogleFonts: false,
            ),
          ),
          content: Text(
            FFAppState().locale == 'en'
                ? 'Your version of app is out of date kindly update'
                : 'يتوفر تحديث جديد لتطبيق منزل، يرجى تحديث التطبيق الى الإصدار الأحدث',
            style: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'AvenirArabic',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              useGoogleFonts: false,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  final appPackageName = packageName;

                  if (Platform.isAndroid) {
                    launchURL(
                        "https://play.google.com/store/apps/details?id=$appPackageName");
                  } else if (Platform.isIOS) {
                    launchURL(
                        'https://apps.apple.com/sa/app/%D9%85%D9%86%D8%B2%D9%84/id1630341481');
                  }
                },
                child: Text(
                  FFAppState().locale == 'en' ? 'Update' : 'تحديث',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'AvenirArabic',
                    color: FlutterFlowTheme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    useGoogleFonts: false,
                  ),
                )),
            isForceUpdate
                ? SizedBox.shrink()
                : TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                FFAppState().locale == 'en' ? 'Later' : 'في وقت لاحق',
                style: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'AvenirArabic',
                  color: FlutterFlowTheme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  useGoogleFonts: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> versionCheck(BuildContext context) async {
    // Future.delayed(Duration(milliseconds: 100));
    PackageInfo info = await PackageInfo.fromPlatform();
    final appPackageName = info.packageName;
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetch();
    await remoteConfig.activate();
    await remoteConfig.fetchAndActivate();
    final remote_config_settings =
    await remoteConfig.getValue('application_version').asString();
    final current_remote_version_JSON =
    jsonDecode(remote_config_settings) as Map;
    FFAppState().buildNo = int.parse(info.buildNumber);
    FFAppState().buildVersion = info.version;
    bool isAndriod = Platform.isAndroid ? true : false;
    //Minimum required version
    final min_required_version = remoteConfig.getString(isAndriod
        ? 'minimum_supported_version_android'
        : 'minimum_app_supported_version_iOS');
    //android_version or iOS version inside application_version JSON
    final recent_version = current_remote_version_JSON[
    isAndriod ? 'android_version' : 'iOS_version'];
    //Build Number
    final current_remote_build = current_remote_version_JSON[
    isAndriod ? 'android_build_number' : 'i0S_build_number'];
    //Backend version
    final current_remote_backend_version =
    current_remote_version_JSON['supported_backend_version'];
    //Force Update
    final isForceUpdate = current_remote_version_JSON['is_force_update'];
    //Installed App version
    final installed_app_version = info.version;
    //Individual decimal Value of all the version
    final arr_required_version = min_required_version.split('.');
    final arr_current_version = recent_version.split('.');
    final arr_installed_version = installed_app_version.split('.');
    //for minimum required version
    if (installed_app_version == recent_version) {
      if (FFAppState().apiVersion != current_remote_backend_version) {
        FFAppState().apiVersion = current_remote_backend_version;
        return;
      }
    } else {
      if (isForceUpdate) {
        showUpdateDialog(context, true, appPackageName);
        return;
      } else if (min_required_version != installed_app_version) {
        if (int.parse(arr_required_version[0]) >
            int.parse(arr_installed_version[0])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        } else if (int.parse(arr_required_version[1]) >
            int.parse(arr_installed_version[1])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        } else if (int.parse(arr_required_version[2]) >
            int.parse(arr_installed_version[2])) {
          showUpdateDialog(context, true, appPackageName);
          return;
        }
        else if (recent_version != installed_app_version) {
          if (int.parse(arr_current_version[0]) >
              int.parse(arr_installed_version[0])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          } else if (int.parse(arr_current_version[1]) >
              int.parse(arr_installed_version[1])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          } else if (int.parse(arr_current_version[2]) >
              int.parse(arr_installed_version[2])) {
            showUpdateDialog(context, false, appPackageName);
            return;
          }
        } else if (current_remote_build != int.parse(info.buildNumber)) {
          showUpdateDialog(context, false, appPackageName);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {

     'HomeScreen': HomeScreenWidget(),
      'MyProperties': MyPropertiesWidget(),
      'Offers': OffersWidget(),
      'Profile': ProfileWidget(),
    };
    //'MapScreen' : MapScreen(),
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF3b95d6),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Manzel.explore,
              size: 20,
            ),
            label: FFLocalizations.of(context).getText(
              'd9p577jz' /* Explore */,
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Manzel.my_properties_nav_bar,
              size: 22,
            ),
            label: FFLocalizations.of(context).getText(
              'lhqoha7d' /* My Properties */,
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              Manzel.offer,
              size: 20,
            ),
            label: FFLocalizations.of(context).getText(
              'km9ey405' /* Offers */,
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              size: 24,
            ),
            label: FFLocalizations.of(context).getText(
              'umgvt8b8' /* Account */,
            ),
            tooltip: '',
          )
        ],
      ),
    );
  }
}
