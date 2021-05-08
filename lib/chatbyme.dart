import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:namesclash/inputbox.dart';
import 'package:namesclash/main.dart';
import 'package:namesclash/receivedmsg.dart';
import 'package:namesclash/sentMsg.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:convert';
import 'package:flutter_socket_io/flutter_socket_io.dart' as IO;
import 'package:flutter_socket_io/socket_io_manager.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  SocketIO socketIO;
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<String> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IO.SocketIO socket;
  @override
  void initState() {
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
    // textController = TextEditingController();
    // scrollController = ScrollController();
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      '<http://namesclash.herokuapp.com>',
      '/',
    );
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      this.setState(() => messages.add(data['message']));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
    //super.initState();
    //connect();
    focusNode.addListener(() {
      setState(() {
        show = false;
      });
    });
  }

  /*void connect() {
    socket = IO.io("http://192.168.1.107:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("conne", "Subham");
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  void sendMessage(String message, String name, String target) {
    socket.emit(
        "message", {"message": message, "sourceId": name, "targetId": target});
  }*/

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            title: Text('Chat'),
            backgroundColor: bg2,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return SentMsg(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReceivedMsg(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    /*onChanged: (value) {
                                if (value.length > 0) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = true;
                                  });
                                }
                              },*/
                                    decoration: InputDecoration(
                                      fillColor: bg2,
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle: TextStyle(color: bg),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: pc,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (_controller.text.isNotEmpty) {
                                        //Send the message as JSON data to send_message event
                                        socketIO.sendMessage(
                                            'send_message',
                                            json.encode(
                                                {'message': _controller.text}));
                                        //Add the message to the list
                                        this.setState(() =>
                                            messages.add(_controller.text));
                                        _controller.text = '';
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        // sendMessage(
                                        //     _controller.text, "Subham", "Subham");
                                        _controller.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        print(emoji);
        setState(
          () {
            _controller.text = _controller.text + emoji.emoji;
          },
        );
      },
    );
  }
}
