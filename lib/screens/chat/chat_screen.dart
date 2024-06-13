import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    _saveMessageToFirestore(message);
  }

  Future<void> _saveMessageToFirestore(types.Message message) async {
    final messageData = message.toJson();
    await FirebaseFirestore.instance
        .collection('chat_messages')
        .add(messageData);
  }

  Future<void> _loadMessages() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = true; // Set isLoading to true when loading messages
    });
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chat_messages')
        .orderBy('createdAt', descending: true)
        .get();
    final messages = querySnapshot.docs.map((doc) {
      return types.Message.fromJson(doc.data());
    }).toList();
    setState(() {
      _messages = messages;
      _isLoading = false; // Set isLoading to false after loading messages
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => Container(
        color: Color(0xffebf6d6),
        child: SafeArea(
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
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Photo',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('File',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Cancel',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
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
        author: _user,
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
            isLoading: false, // Set isLoading to false after loading
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
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

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Community Chat",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    ),
    body: Stack(
      children: [
        Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: const DefaultChatTheme(
            inputBackgroundColor: Color(0xffE4E7E7),
            inputTextColor: Colors.black,
            inputBorderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15)),
            messageBorderRadius: 12,
            primaryColor: Color(0xffebf6d6),
            secondaryColor: Colors.greenAccent,
            userAvatarNameColors: [Colors.red, Colors.orange],
            userAvatarTextStyle: TextStyle(
              color: Colors.white,
            ),
            inputTextStyle: TextStyle(
              color: Colors.black,
            ),
            inputPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            messageInsetsVertical: 10,
            messageInsetsHorizontal: 16,
            sentMessageBodyTextStyle: TextStyle(
              color: Colors.black,
            ),
            receivedMessageBodyTextStyle: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.greenAccent,
            ),
          ),
        ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    ),
  );
}
