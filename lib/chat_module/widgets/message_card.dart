import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';

import '../../main.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../helper/my_date_util.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == widget.message.fromId;
    return InkWell(
      onLongPress: () {
        _showBottomSheet(isMe);
      },
      child: isMe ? _greenMessage() : _blueMessage(),
    );
  }

  Widget _blueMessage() {
    // Update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image ? 10 : 10),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: widget.message.type == Type.text
                ? Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: widget.message.msg,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.image, size: 70),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Text(
            MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),
            const SizedBox(width: 2),
            Text(
              MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image ? 10 : 10),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xffebf6d6),
              border: Border.all(color: Colors.green),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: widget.message.type == Type.text
                ? Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: widget.message.msg,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.image, size: 70),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xffE4E7E7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              widget.message.type == Type.text
                  ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _OptionItem(
                  icon: const Icon(Icons.copy_all_rounded, color: Colors.blue, size: 26),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: widget.message.msg)).then((value) {
                      Navigator.pop(context);
                      Dialogs.showSnackbar(context, 'Text Copied!');
                    });
                  },
                ),
              )
                  : _OptionItem(
                icon: const Icon(Icons.download_rounded, color: Colors.blue, size: 26),
                name: 'Save Image',
                onTap: () async {
                  try {
                    log('Image Url: ${widget.message.msg}');
                    await GallerySaver.saveImage(
                      widget.message.msg,
                      albumName: 'We Chat',
                    ).then((success) {
                      Navigator.pop(context);
                      if (success != null && success) {
                        Dialogs.showSnackbar(context, 'Image Successfully Saved!');
                      }
                    });
                  } catch (e) {
                    log('ErrorWhileSavingImg: $e');
                  }
                },
              ),
              if (isMe)
                const Divider(
                  color: Colors.black54,
                  endIndent: 20,
                  indent: 20,
                ),
              if (widget.message.type == Type.text && isMe)
                _OptionItem(
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                  name: 'Edit Message',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessageUpdateDialog();
                  },
                ),
              if (isMe)
                _OptionItem(
                  icon: const Icon(Icons.delete_forever, color: Colors.red, size: 26),
                  name: 'Delete Message',
                  onTap: () async {
                    await APIs.deleteMessage(widget.message).then((value) {
                      Navigator.pop(context);
                    });
                  },
                ),
              const Divider(
                color: Colors.black54,
                endIndent: 20,
                indent: 20,
              ),
              _OptionItem(
                icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                name: 'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent)}',
                onTap: () {},
              ),
              _OptionItem(
                icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                name: widget.message.read.isEmpty
                    ? 'Read At: Not seen yet'
                    : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.read)}',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.message, color: Colors.blue, size: 28),
            Text(' Update Message'),
          ],
        ),
        content: TextFormField(
          initialValue: updatedMsg,
          maxLines: null,
          onChanged: (value) => updatedMsg = value,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              APIs.updateMessage(widget.message, updatedMsg);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem({
    required this.icon,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return InkWell(
        onTap: onTap,
        child: Padding(
        padding: EdgeInsets.only(left: mq.size.width * 0.05, top: mq.size.height * 0.015, bottom: mq
            .size.height * 0.015),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 15, color: Colors.black54, letterSpacing: 0.5),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
