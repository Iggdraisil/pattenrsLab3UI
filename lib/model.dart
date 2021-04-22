import 'dart:convert';

class User {
  int id;
  String nickname;
  String imageUrl;

  User({this.id, this.nickname, this.imageUrl});

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        nickname: map['nickname'],
        imageUrl: map['image_url'],
      );
}

class Server {
  int id;
  String name;
  String imageUrl;

  Server({this.id, this.name, this.imageUrl});

  factory Server.fromMap(Map<String, dynamic> map) => Server(
        id: map['id'],
        name: map['name'],
        imageUrl: map['imageUrl'],
      );
}

class Chat {
  final int id;
  final String name;
  final Server server;

  const Chat({this.id, this.name, this.server});

  factory Chat.fromMap(Map<String, dynamic> map) => Chat(
        id: map['id'],
        name: map['name'],
        server: Server.fromMap(map['server']),
      );
}

class OutComingMessage {
  String text;
  int senderId;
  int chatId;

  OutComingMessage({this.text, this.chatId, this.senderId});

  factory OutComingMessage.fromMap(Map<String, dynamic> map) =>
      OutComingMessage(
        text: map['text'],
        chatId: map['chat_id'],
        senderId: map['sender_id'],
      );

  String json() => JsonEncoder().convert({
        'text': text,
        'sender_id': senderId.toString(),
        'chat_id': chatId.toString(),
      });
}

class Message {
  int id;
  String text;
  String time;
  User sender;
  Chat chat;

  Message({this.chat, this.sender, this.text, this.id, this.time});

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        chat: Chat.fromMap(map['chat']),
        sender: User.fromMap(map['sender']),
        text: map['text'],
        id: map['id'],
        time: map['time'],
      );
}
