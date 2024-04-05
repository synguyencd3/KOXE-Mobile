import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:mobile/model/chat_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/socket/socket_manager.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/services/salon_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  ChatUserModel? user;
  List<types.Message> _messages = [];
  late types.User _sender = types.User(id: '');
  late types.User _receiver = types.User(id: '');
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      user = ModalRoute.of(context)?.settings.arguments as ChatUserModel?;
      if (user != null) {
        _receiver = types.User(
          id: user?.id ?? '',
        );
      }
      //print(user?.isOnline);
      callAPI();
    });
    initSocket();
    _messageSubscription = SocketManager.messageStream.listen((data) {
      // Parse the message and create a types.Message object
      final messageReceive = types.TextMessage(
        author: _receiver,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: data['message'],
      );
      _addMessage(messageReceive);
    });
  }

  Future<void> initSocket() async {
    String salonId = await SalonsService.isSalon();
    await SocketManager.initSocket(_sender.id, salonId, (data) {
      print(data);
      for (var idData in data) {
        if (user?.id == idData) {
          if (mounted)
            {
              setState(() {
                user?.isOnline = true;
              });
            }

          break;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageSubscription!.cancel();
  }

  Future<void> callAPI() async {
    await getUserInfo();
    await getMessages();
  }

  Future<void> getUserInfo() async {
    final Map<String, dynamic> userProfile = await APIService.getUserProfile();
    String salonId = await SalonsService.isSalon();
    if (salonId != '') {
      _sender = types.User(
        id: salonId,
      );
    } else {
      _sender = types.User(
        id: userProfile['user_id'],
      );
    }
  }

  Future<void> getMessages() async {
    //print(user!.id);
    List<ChatModel> chatAPI = await ChatService.getChatById(user!.id);
    //print(chatAPI[0].message);
    print(_sender.id);
    for (int i = 0; i < chatAPI.length; i++) {
      print(chatAPI[i].sender);
      final createAt = DateTime.parse(chatAPI[i].createdAt ?? DateTime.now().toString());
      if (chatAPI[i].sender == _sender.id) {
        final message = types.TextMessage(
          author: _sender,
          createdAt: createAt.millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: chatAPI[i].message,
        );
        _addMessage(message);
      } else {
        final message = types.TextMessage(
          author: _receiver,
          createdAt: createAt.millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: chatAPI[i].message,
        );
        _addMessage(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
          ),
          body: Chat(
            messages: _messages,
            onAttachmentPressed: _handleAttachmentPressed,
            onSendPressed: _handleSendPressed,
            user: _sender,
          ),
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    bool success = await ChatService.sendMessage(textMessage.text, user!.id);
    if (success) {
      _addMessage(textMessage);
    }
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

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _sender,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _sender,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  Widget _appBar() {
    return FutureBuilder(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Đang hoạt động',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_messages.isNotEmpty) {
                      var textMessage = _messages[0] as types.TextMessage;
                      var messageText = textMessage.text;
                      Navigator.pop(context, messageText);
                    }
                  },
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(user?.image ??
                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user?.isOnline == true
                          ? 'Đang hoạt động'
                          : 'Không hoạt động',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.video_call_rounded,
                    size: 30,
                  ),
                ),
              ],
            );
          }
        });
  }
}
