import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../model.dart';

class ExpandedMessageView extends StatefulWidget {
  OutComingMessage message;
  int id;

  ExpandedMessageView(this.message, {this.id});

  @override
  State<StatefulWidget> createState() => ExpandedMessageState();
}

class ExpandedMessageState extends State<ExpandedMessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? 'Editing message' : 'Sending message'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.message.text,
                decoration: const InputDecoration(labelText: 'text'),
                onChanged: (String text) => widget.message.text = text,
              ),
              TextFormField(
                initialValue: widget.message.senderId?.toString() ?? '',
                enabled: widget.id == null,
                decoration: const InputDecoration(
                  labelText: 'sender id',
                ),
                onChanged: (String text) => widget.message.senderId = int.parse(
                  text,
                ),
              ),
              TextFormField(
                initialValue: widget.message.chatId?.toString() ?? '',
                enabled: widget.id == null,
                decoration: const InputDecoration(
                  labelText: 'chat id',
                ),
                onChanged: (String text) => widget.message.chatId = int.parse(
                  text,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendMessage(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> sendMessage(BuildContext context) async {
    if (widget.message.text != null &&
        widget.message.senderId != null &&
        widget.message.chatId != null) {
      Future<Message> message;
      if (widget.id == null) {
        message = Api.sendMessage(widget.message);
      } else {
        message = Api.updateMessage(widget.message, widget.id);
      }
      message.then((value) => Navigator.pop(context, value))
          .catchError(
            (error) => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error has occurred $error"),
              ),
            ),
          );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Message isn't complete"),
        ),
      );
    }
  }
}
