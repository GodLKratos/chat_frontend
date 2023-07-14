import 'package:chat/Screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Group Chat")),
      ),
      body: Center(
          child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Form(
                            key: _formkey,
                            child: TextFormField(
                              validator: ((value) {
                                if(value == null || value.isEmpty){
                                  return "Plese Enter Name";
                                }
                                return null;
                              }
                              ),
                              controller: name,
                              decoration: const InputDecoration(
                                labelText: "Enter a name",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.greenAccent),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  validatecheck();
                                },
                                child: const Text("Chat")),
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Cancel")),
                          ],
                        ));
              },
              child: const Text("Click To Go on Chat Page"))),
    );
  }
  
  validatecheck() {
    if(_formkey.currentState!.validate()){
      Get.off( ChatPage(name: name.text,uuid: uuid.v1(),));
    }
  }
}
