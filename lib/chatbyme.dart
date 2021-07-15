import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController;
  IO.Socket socket;

  @override
  void initState() {
    //Initializing the message list
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    socket = IO.io("https://nameclash.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    //https://nameclash.herokuapp.com
    //Call init before doing anything with socket
    //Subscribe to an event to listen to
    socket.onConnect((data) {
      print("connected");
      socket.on('receive_message', (jsonData) {
        //Convert the JSON data received into a Map
        Map<String, dynamic> data = json.decode(jsonData);
        print(data);
        this.setState(() => messages.add(data['message']));
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
        );
      });
    });
    //Connect to the socket

    super.initState();
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          //Send the message as JSON data to send_message event
          socket.emit(
              'send_message', json.encode({'message': textController.text}));
          //Add the message to the list
          this.setState(() => messages.add(textController.text));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: bg,
//           appBar: AppBar(
//             title: Text('Chat'),
//             backgroundColor: bg2,
//           ),
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: WillPopScope(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisSize: MainAxisSize.max,
//                 // mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       controller: scrollController,
//                       itemCount: messages.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index == messages.length) {
//                           return Container(
//                             height: 70,
//                           );
//                         }
//                         // if (messages[index].type == "source") {
//                         //   return SentMsg(
//                         //     message: messages[index].message,
//                         //     time: messages[index].time,
//                         //   );
//                         // } else {
//                         //   return ReceivedMsg(
//                         //     message: messages[index].message,
//                         //     time: messages[index].time,
//                         //   );
//                         // }
//                       },
//                     ),
//                   ),
//                   Spacer(),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: 70,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
                              //   width: MediaQuery.of(context).size.width - 60,
                              //   child: Card(
                              //     margin: EdgeInsets.only(
                              //         left: 2, right: 2, bottom: 8),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(25),
                              //     ),
                              //     child: TextFormField(
                              //       controller: textController,
                              //       focusNode: focusNode,
                              //       textAlignVertical: TextAlignVertical.center,
                              //       keyboardType: TextInputType.multiline,
                              //       maxLines: 5,
                              //       minLines: 1,
                              //       /*onChanged: (value) {
                              //   if (value.length > 0) {
                              //     setState(() {
                              //       sendButton = true;
                              //     });
                              //   } else {
                              //     setState(() {
                              //       sendButton = true;
                              //     });
                              //   }
                              // },*/
                              //       decoration: InputDecoration(
                              //         fillColor: bg2,
                              //         border: InputBorder.none,
                              //         hintText: "Type a message",
                              //         hintStyle: TextStyle(color: bg),
                              //         prefixIcon: IconButton(
                              //           icon: Icon(
                              //             show
                              //                 ? Icons.keyboard
                              //                 : Icons.emoji_emotions_outlined,
                              //           ),
                              //           onPressed: () {
                              //             if (!show) {
                              //               focusNode.unfocus();
                              //               focusNode.canRequestFocus = false;
                              //             }
                              //             setState(() {
                              //               show = !show;
                              //             });
                              //           },
                              //         ),
                              //         contentPadding: EdgeInsets.all(5),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     bottom: 8,
                              //     right: 2,
                              //     left: 2,
                              //   ),
//                                 child: CircleAvatar(
//                                   radius: 25,
//                                   backgroundColor: pc,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.send,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       if (textController.text.isNotEmpty) {
//                                         //Send the message as JSON data to send_message event
//                                         socket.emit(
//                                             'send_message',
//                                             json.encode({
//                                               'message': textController.text
//                                             }));
//                                         //Add the message to the list
//                                         this.setState(() =>
//                                             messages.add(textController.text));
//                                         textController.text = '';
//                                         scrollController.animateTo(
//                                             scrollController
//                                                 .position.maxScrollExtent,
//                                             duration:
//                                                 Duration(milliseconds: 300),
//                                             curve: Curves.easeOut);
//                                         // sendMessage(
//                                         //     _controller.text, "Subham", "Subham");
//                                         textController.clear();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           //show ? emojiSelect() : Container(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget emojiSelect() {
//     return EmojiPicker(
//       rows: 4,
//       columns: 7,
//       onEmojiSelected: (emoji, category) {
//         print(emoji);
//         setState(
//           () {
//             textController.text = textController.text + emoji.emoji;
//           },
//         );
//       },
//     );
//   }
// }
