
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:manzel/common_widgets/manzel_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_pdf_viewer.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DepositeReciptWidget extends StatefulWidget {
   const DepositeReciptWidget({
    Key? key,
    this.depositeRecpit,
     this.propertyName,
  }) : super(key: key);

  final String? depositeRecpit;
  final String? propertyName;

  @override
  _DepositeReciptWidgetState createState() => _DepositeReciptWidgetState();
}

class _DepositeReciptWidgetState extends State<DepositeReciptWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> isDowloading = ValueNotifier<bool>(false);
  final ValueNotifier<num> downloadProgress = ValueNotifier<num>(0);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'depositeRecipt'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: RotatedBox(
          quarterTurns: FFAppState().locale=='en'?0:2,
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Manzel.back_icon,
              color: Colors.black,
              size: 15,
            ),
            onPressed: () async {
              logFirebaseEvent('DEPOSITE_RECIPT_arrow_back_rounded_ICN_O');
              logFirebaseEvent('IconButton_Close-Dialog,-Drawer,-Etc');
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'b8jn4qd2' /* Deposit Receipt */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'AvenirArabic',
                color: Colors.black,
                fontSize: 22,
                useGoogleFonts: false,
              ),
        ),
        actions: [
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
            child: ValueListenableBuilder(
                valueListenable: isDowloading,
                builder: (context,bool isDownloading,_) {
                  if(isDownloading){
                    return ValueListenableBuilder(
                        valueListenable: downloadProgress,
                        builder: (context,num value,_) {
                          print(value);
                          return Center(child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(value: value.toDouble(),backgroundColor: Colors.white,)));
                        }
                    );
                  }
                  return InkWell(onTap:(){
                    download(context);
                  },child: Icon(Icons.download,color: Colors.black,));
                }
            ),
            ),

        ],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FlutterFlowPdfViewer(
                  networkPath: valueOrDefault<String>(
                    widget.depositeRecpit,
                    'http://www.pdf995.com/samples/pdf.pdf',
                  ),
                  height: 300,
                  horizontalScroll: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future download(BuildContext context) async {
    PermissionManager.instance().ask(Permission.storage, granted: ()async{
      try {
        isDowloading.value=true;
        Response response = await Dio().get(
          widget.depositeRecpit??'http://www.pdf995.com/samples/pdf.pdf',
          onReceiveProgress: updateProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) { return status! < 500; }
          ),
        );
        Directory? _path;
        String _localPath='';
        if(Platform.isAndroid){
          _path = Directory('/storage/emulated/0/Download');
          if (!await _path.exists()) _path = await getExternalStorageDirectory();
          _localPath = '${_path?.path??''}';
        }else{
          _path = await getApplicationDocumentsDirectory();
          _localPath = '${_path.path}${Platform.pathSeparator}Download';
        }
        final savedDir = Directory(_localPath);
        bool hasExisted = await savedDir.exists();
        if (!hasExisted) {
          savedDir.create();
        }
        String fileName = '${widget.propertyName} Transaction Receipt${DateTime.now().microsecondsSinceEpoch}.pdf';
        var file =  File('$_localPath/$fileName');
        await file.writeAsBytes((response.data as Uint8List).toList());
        print("Download completed");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              FFLocalizations.of(context).getText(
                'downloadSucessfulMessage' /* Account */,
              ),
              style:
              FlutterFlowTheme.of(context).subtitle1,
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Colors.black,
          ),
        );
      } catch (e) {
        print("Error downloading ${e}");
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              FFLocalizations.of(context).getText(
                'errorDownloading' /* Account */,
              ),
              style:
              FlutterFlowTheme.of(context).subtitle1,
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: Colors.black,
          ),
        );
      }finally{
        isDowloading.value=false;
      }
    }, decline: (){});
  }

  void updateProgress(int received,int total){
    downloadProgress.value = received/total;
  }



}
class PermissionManager{
  PermissionManager._();
  static final PermissionManager _instance = PermissionManager._();
  factory PermissionManager.instance()=>_instance;

  void ask(Permission permission,{required VoidCallback granted,required VoidCallback decline,bool navigateToSettingsIfDeclined=false})async{
    final permissionRequestStatus = await permission.request();
    if(permissionRequestStatus.isGranted){
      granted();
    }else if(permissionRequestStatus.isDenied){
      decline();
    }else if(permissionRequestStatus.isPermanentlyDenied && navigateToSettingsIfDeclined){
      await openAppSettings();
    }
  }
  // Future _showNotificationWithoutSound() async {
  //   var android = new AndroidNotificationDetails(
  //       'your channel id', 'your channel name', 'your channel description',
  //       playSound: false, importance: Importance.max, priority: Priority.high);
  //   var ios =
  //   new IOSNotificationDetails(presentSound: false);
  //   var platformChannelSpecifics = new NotificationDetails(
  //        iOS: ios ,android: android);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'New Post',
  //     'How to Show Notification in Flutter',
  //     platformChannelSpecifics,
  //     payload: 'No_Sound',
  //   );
  // }


}



