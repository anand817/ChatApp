import 'dart:convert';
import 'package:chat_app/constants.dart';
import 'package:chat_app/viemodels/base_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

class ChatViemodel extends BaseViemodel {
  final IOWebSocketChannel _channel =
      IOWebSocketChannel.connect(Uri.parse(WEBSOCKET_URI));
  late final TextEditingController _controller;
  List<dynamic> _messageList = [];

  List<dynamic> get messageList => _messageList;

  set messageList(List<dynamic> list) {
    _messageList = list;
    notifyListeners();
  }

  IOWebSocketChannel get channel => _channel;

  TextEditingController get controller => _controller;

  set controller(textEditingController) {
    _controller = textEditingController;
    notifyListeners();
  }

  void onModelReady() {
    controller = TextEditingController();
  }

  void onModelDestroy() {
    controller.dispose();
  }

  void sendMessage(String message) {
    var map = {};
    map['message'] = message;
    channel.sink.add(json.encode(map));
  }

  Stream<dynamic> get messageStream =>
      channel.stream.map((jsonMessage) => json.decode(jsonMessage)['message']);
}
