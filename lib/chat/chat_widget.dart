import 'dart:io';

import 'package:manzel/auth/auth_util.dart';

import '../common_widgets/overlay.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sendbird;
import 'package:uuid/uuid.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    Key? key,
    this.bankJson,
  }) : super(key: key);

  final dynamic bankJson;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget>
    with sendbird.ChannelEventHandler {
  bool isLoading = true;
  List<sendbird.BaseMessage> _SendBirdMessages = [];
  GroupChannel? _channel;
  List<types.Message> _messages = [];
  types.User _user = types.User(id: "rhytham", firstName: "");

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    fetchUser();
    sendbird.SendbirdSdk().addChannelEventHandler("chat", this);
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Chat'});
  }

  @override
  void dispose() {
    sendbird.SendbirdSdk().removeChannelEventHandler("chat");
    sendbird.SendbirdSdk().disconnect();
    super.dispose();
  }

  @override
  onMessageReceived(channel, message) {
    setState(() {
      // _SendBirdMessages.add(message);
      getNewMsg(message);
    });
    super.onMessageReceived(channel, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'CHAT_PAGE_Icon_mqw5te5l_ON_TAP');
                              logFirebaseEvent(
                                  'Icon_Close-Dialog,-Drawer,-Etc');
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(33),
                              child: Image.network(
                                getJsonField(
                                  widget.bankJson,
                                  r'''$.bank_logo'''??"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAI8AAACECAMAAACeeohiAAAAYFBMVEX///8AAAC5ublKSko6OjpmZmb4+PjX19fe3t6urq4nJyd3d3eTk5OIiIjAwMBvb2/l5eXu7u6cnJynp6fPz8/JyckQEBBBQUGCgoIvLy9SUlJeXl40NDQICAgcHBwiIiKGRo/tAAAEnklEQVR4nO2ai3aiOhRAT6LkIQHzIIKg9v//cvJSae/t1LEEO2uyl8uAsuru4eQkBAAKhUKhUCgUCoVCoVAoFF4CaV9t8A46ooq9WuKOOSCEjvzVGgkXHLS3E/oZISIcoYMLDdGuxa+2AVkhNDLoJgq0R6hWL7UhBqEzB1K7/GkAXIjQK0MkXdKMFDoXGBTDtHGp9LIQ8QtCGqBBVzQQgdDuNbXIZ850C07EB8v1tlqur4N3CAkC+ozOM6GDC9GA0MmubKOqEAxfemZ4sxSymqypw0/oIFzJOaD/cjBAXEr163U0373dGWHT/9h4Kgnt0RWAlUKEL6HYmE9sPAbAZdHbGh1N+eB0wKrf6IShzB7ROX+I8AmhgQD/rY3HVe29y6LMIZKDEB1A24ivaJxJK8SQsRQRpUggNV+QjnZNJh973j3DOVdx/Gk+hD3HqqX6tSgZSClK4p4kaTM2Ku6kJm9w6lRdxjA6sbRHXV3yI5cMRbsKO6gO00XUZfW5z73ckABd2m6jj2t9ndxD63cG8CX8nFVn5nNy09L27hZ8mvc+p7CT32d7SEG5DqlN8tnMfRrp3zPPOoJPa+MABSL51MkHkXl8/EfHzJeI0Ue6GYefyfvsvrhJ4XT1aefx8bZj5ouN4IPlm3sXEBJ2dG47knwaPPMZ40H5fVp2cVNlNy3d+NOy8+cp+Uyz+FSHmGT5fTiP+ax8BzL+TSWft+Hu8xYSag2faw7HDuSvv2zyOZ/uPiFGmXWuPuewcODL88GOoQDhm+jcp1nDJ17/TSqU57dwlSE+8dmucr7qMJcXofid/Pzenbwwfh0++qDcawupf/kfnkI57MNHU1A4beY+u5Bdq/iE+tPD3jtgH6yeeIWxnvtU5xUSaOazhfsl2EkFHz73GXy0xswJ9C4+98WEiww+dO7T+Fq04vjVq9nKj/UKG3KZ++gVEij4mDDP2EifsZd9SGIefGCa+9gVKlDwSQUo9LIxVh4TffjcJ5Tv4wo+ERH+/wrsLRibOIG9zQ+P+SvQ3efCUjBCElcxPmo79wlnL+8Ir/uNZ5wGCsZt9wLk1n1QWbezJzD0m74Buw3f+IN7k9Xntlhw204tzLc/NP8K0vBnMLmWgO7D9p+RK6Xpvn6GPc0h89CS2Ocs7sNjT3+Ofvl7mfrJ5InoxX0U/Q7LjhqK4wVYzsl+61xdWa6b0alagBfcpFsDfdwuxXGJbia+zoyHWWL5hS3RtxI/4YGKQqFQKBQKhUKhUCgUCoXMZFk8/wa5n9D5U5Zfqf4eD/rIdF5vNyLShiXw4d4EUemlSHy5TXfMo4/5PuRDWMel+8OYm5Yw8E9fis5tKKaV+zWqFCNMxQdVuTBaYK1bobE2WFMjWlKxBi/owzkVxlDNsWlFg5tWSN1pzEUnhARrrDbaNLwFLIE4B6y5MbxxTlx3YDG3rOEL+kiNLdadwF1LB8sMsdwwLWsDolFgaMftQDk1IAl0Ssia0Aa4+9YSKRhnoragH+vJD/lQQxllhjPDMDXMEt51uDMKY8ssVZq2nMpOhmdVrZaUQUsAE4Khc96mA6bMg09O/KX9ay1+ATftTlEKfsdNAAAAAElFTkSuQmCC",
                                ),
                              width: 33,
                              height: 33,
                              ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                          child: Text(
                            valueOrDefault<String>(
                              getJsonField(
                                widget.bankJson,
                                r'''$.bank_name''',
                              ).toString(),
                              'null',
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'AvenirArabic',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: false,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [],
          elevation: 2,
        ),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        child: Center(
          child: Center(
            child: Visibility(
              visible: isLoading,
              replacement: Chat(
                messages: _messages,
                onAttachmentPressed: _handleAttachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
              ),
              child: SpinKitRipple(
                color: Color(0xFF2971FB),
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);

      //_SendBirdMessages.add(sendBirdMessage);
      // super.onMessageReceived(channel, sendBirdMessage);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //User Mapping
  types.User asChatUiUser(sendbird.User user) {
    if (user == null) {
      return types.User(id: "", firstName: "");
    } else {
      return types.User(
          id: user.userId, firstName: user.nickname, lastSeen: user.lastSeenAt);
    }
  }

  //Map message
  void asChatUIMessage(List<sendbird.BaseMessage> messages) {
    //List<types.Message> result = [];

    try {
      if (messages != null) {
        messages.forEach((message) {
          sendbird.User user = message.sender!;
          if (user == null) {
            return;
          }
          Map<String, dynamic> jsonData = {
            "type":
                message.runtimeType == sendbird.UserMessage ? 'text' : 'image',
            "author": {
              'firstName': message.sender?.nickname ?? '',
              'id': message.sender?.userId,
              'lastName': ''
            },
            "id": message.messageId.toString(),
            "text": message.message,
            "createdAt": message.createdAt,
          };
          if (message.runtimeType == sendbird.FileMessage) {
            sendbird.FileMessage msg = message as sendbird.FileMessage;
            types.PartialImage imageData = types.PartialImage(
                name: msg.name ?? '', size: msg.size ?? 0, uri: msg.secureUrl ?? '');
            jsonData['partialImage'] = imageData;
            jsonData['uri'] = msg.secureUrl;
            jsonData['type'] = msg.type!.contains('image') ? 'image' : 'file';
            jsonData['name'] = msg.name;
            jsonData['size'] = msg.size;
          }
          types.Message chatMessage =
              types.Message.fromJson(jsonData as Map<String, dynamic>);
          setState(() {
            _messages.insert(0, chatMessage);
          });
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void getNewMsg(sendbird.BaseMessage msg) {
    Map<String, dynamic> jsonData = {
      "type": msg.runtimeType == sendbird.UserMessage ? 'text' : 'image',
      "author": {
        'firstName': msg.sender?.nickname ?? '',
        'id': msg.sender?.userId,
        'lastName': ''
      },
      "id": msg.messageId.toString(),
      "text": msg.message,
      "createdAt": msg.createdAt,
    };
    if (msg.runtimeType == sendbird.FileMessage) {
      sendbird.FileMessage mssg = msg as sendbird.FileMessage;
      types.PartialImage imageData = types.PartialImage(
          name: mssg.name ?? '', size: mssg.size ?? 0, uri: mssg.secureUrl ?? '');
      jsonData['partialImage'] = imageData;
      jsonData['uri'] = mssg.secureUrl;
      jsonData['type'] = mssg.type!.contains('image') ? 'image' : 'file';
      jsonData['name'] = mssg.name;
      jsonData['size'] = mssg.size;
    }
    types.Message chatMessage =
        types.Message.fromJson(jsonData as Map<String, dynamic>);
    setState(() {
      _messages.insert(0, chatMessage);
      //_messages.add(chatMessage);
    });
  }

  void _handleFileSelection() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );
      final fileMessage = sendbird.FileMessageParams.withFile(
        file,
        name: result.files.single.name,
      );
      var sentFileMessage =
      _channel?.sendFileMessage(fileMessage,onCompleted:(message,error){
        print(message);
        print("error------------->${error}");
      });
      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 10,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      File file = File(result.path);
      var sentFileMessage =
          _channel?.sendFileMessage(sendbird.FileMessageParams.withFile(file));
      print(sentFileMessage);
      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _channel?.sendUserMessageWithText(message.text);
    _addMessage(textMessage);
  }

  Future<void> fetchUser() async {
    await load();
  }

  Future<void> load() async {
    try {
      String channel_url = valueOrDefault<String>(
        getJsonField(
          widget.bankJson,
          r'''$.channel_detail.channel_url''',
        ).toString(),
        'null',
      );
      final _sendbird = await sendbird.SendbirdSdk(
          appId: "0F58DDB9-5DB1-4FC5-A84D-6DD8BBC314FC");
      final _ = await _sendbird.connect(currentUserUid);
      // Future.delayed(Duration(seconds: 5));
      _user = asChatUiUser(sendbird.SendbirdSdk().currentUser!);
      // final query = sendbird.GroupChannelListQuery()
      //   ..limit = 1
      //   ..channelUrls = [channel_url];
      //..userIdsExactlyIn = ["abhishek Sevarik","412216","admin","abhishek Visht","rhytham"];
      // List<GroupChannel> channels = await query.loadNext();
      // GroupChannel aChannel;
      // if (channels.length == 0) {
      //   aChannel = await GroupChannel.createChannel(sendbird.GroupChannelParams()
      //     ..isPublic = true
      //     ..userIds = ['']);
      // } else {
      final aChannel = await GroupChannel.getChannel(channel_url);
     // aChannel = channels[0];
      //}
      List<sendbird.BaseMessage> messages =
          await aChannel.getMessagesByTimestamp(
              DateTime.now().millisecondsSinceEpoch * 1000,
              sendbird.MessageListParams());
      _SendBirdMessages = messages;
      _channel = aChannel;
      _channel?.markAsRead();
      asChatUIMessage(messages);
      isLoading = false;
      if(messages.isEmpty){
        setState(() {
        });
      }
    } catch (error) {
      print(error);
    }
  }
}
