import 'package:flutter/material.dart';

class OwnMsg extends StatelessWidget {
    final String msg;
  final String sender;
  const  OwnMsg({super.key,required this.msg,required this.sender});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: width - 100, minHeight: height * 0.07),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17))),
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(sender,style: const TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold),),
                const SizedBox(height: 6,),
                Text(msg,style: const TextStyle(fontSize: 17),),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
