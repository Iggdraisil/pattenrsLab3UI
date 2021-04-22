import 'package:flutter/material.dart';
import 'package:patternslab3/model.dart';
import 'package:patternslab3/widgets/expanded_message_view.dart';
import 'package:patternslab3/widgets/message_view.dart';

import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discord admin panel',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Microsoft proprietary Discord admin panel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Message> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Message>>(
          initialData: [],
          future: Api.fetchAllMessages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => MessageView(
                  data[index],
                  () => setState(() => data.removeAt(index)),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error has occurred ${snapshot.error.toString()}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpandedMessageView(OutComingMessage()),
          ),
        ).then((value) => setState(() => data.add(value))),
        child: const Icon(Icons.message),
      ),
    );
  }
}
