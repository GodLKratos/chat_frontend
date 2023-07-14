import 'package:flutter/material.dart';

class OtherMsg extends StatelessWidget {
  final String msg;
  final String sender;
  const OtherMsg({super.key,required this.msg,required this.sender});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: width - 100, minHeight: height * 0.07),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17))),
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(sender,style: const TextStyle(color: Colors.lightBlue,fontSize: 15,fontWeight: FontWeight.bold),),
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
