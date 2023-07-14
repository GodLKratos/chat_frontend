import 'package:chat/models/msgModel.dart';
import 'package:chat/widgets/OtherMsg.dart';
import 'package:chat/widgets/ownMsgshow.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String name;
  final String uuid;
  const ChatPage({super.key, required this.name,required this.uuid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  TextEditingController msg = TextEditingController();
  List<Msgmodel> storemsg = [];
  @override
  void initState() {
    super.initState();
    connectfn();
  }

  connectfn() {
    socket = IO.io("http://localhost:3000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket!.connect();
    socket!.onConnect((data) {
      print('sdkjcnjdskc');
      socket!.on('sendmsgserver', (data) {
      setState(() {
        if(data["uuid"]!=widget.uuid){
          storemsg.add(Msgmodel(type: data["type"], msg: data["msg"], sender: data["sender"]));
        }
      });
      });
    });
  }

  void messagesend(String msg, String name) {
      Msgmodel newmsgobj = Msgmodel(type: "ownmsg", msg: msg, sender: name);
      setState(() {
        storemsg.add(newmsgobj);
      });
    socket!.emit("sendmsg", {
      "type":"ownmsg",
      "msg":msg,
      "sender":name,
      "uuid":widget.uuid
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chats')),
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: storemsg.length,
              itemBuilder: (BuildContext context, int index) {
                if(storemsg[index].type == "ownmsg"){
                  return OwnMsg(msg: storemsg[index].msg, sender: storemsg[index].sender);
                }
                else{
                  return OtherMsg(msg: storemsg[index].msg, sender: storemsg[index].sender);
                }
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    controller: msg,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (msg.text.isNotEmpty) {
                              messagesend(msg.text, widget.name);
                              msg.text = "";
                            }
                          },
                          icon: const Icon(Icons.send)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
              )
            ],
          )
        ]));
  }
}
