import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: must_be_immutable
class CompletedOrderPage extends StatefulWidget{
  WebSocketChannel channel;

  @override
  State<StatefulWidget> createState() {
    channel = IOWebSocketChannel.connect('wss://zelodostavka.me/ws/');

    return new CompletedOrderPageState();
  }
}

class CompletedOrderPageState extends State<CompletedOrderPage>  {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : 'Text'),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      Map<String, String> json = {'message': _controller.text};
      String jsonString = jsonEncode(json);
      print(jsonString);
      widget.channel.sink.add(jsonString);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold (
//        appBar: AppBar(
//          title: Text(
//            'Статус заказа',
//            style: GoogleFonts.openSans(
//
//            ),
//          ),
//        ),
//        body: Container(
//          alignment: Alignment.center,
//          child: Text(
//            'Ваш заказ принят и уже готовиться'
//          ),
//        )
//    );
//  }

}
