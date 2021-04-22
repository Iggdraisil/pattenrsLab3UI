import 'package:flutter/material.dart';
import 'package:patternslab3/api.dart';
import 'package:patternslab3/widgets/expanded_message_view.dart';

import '../model.dart';

class MessageView extends StatefulWidget {
  Message message;
  Function deleteMessage;
  MessageView(this.message, this.deleteMessage, {Key key}) : super(key: key);

  State<StatefulWidget> createState() => MessageViewState();
}

class MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Row(
          children: [
            Text('id:${widget.message.id}'),
            Expanded(
              child: Container(
                child: Text(widget.message.text),
                alignment: Alignment.center,
              ),
            ),
            Text('time:${widget.message.time}'),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpandedMessageView(
                    OutComingMessage(
                      text: widget.message.text,
                      senderId: widget.message.sender.id,
                      chatId: widget.message.chat.id,
                    ),
                    id: widget.message.id,
                  ),
                ),
              ).then(
                (value) => setState(
                  () {
                    if (value != null) {
                      widget.message = value;
                    }
                  },
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => Api.deleteMessage(widget.message.id)
                  .then((value) => this.widget.deleteMessage())
                  .catchError(
                    (error) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error has occurred $error"),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
    );
  }
}
