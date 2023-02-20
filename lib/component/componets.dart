import 'package:chat_app/models/model.dart';
import 'package:flutter/material.dart';

Widget defultTextField({
  // Function ?o
  Function(String)? onChanged,
  required String? Function(String?)? validation,
  required String? text,
  IconData? sufix,
  prifix,
  hint_Text = false,
  void Function() ?onTabSuffix
}) =>
    TextFormField(
      onChanged: onChanged,
      obscureText: hint_Text,
      validator: validation,
      keyboardType: TextInputType.emailAddress,
      decoration:
//  TextInputType.keyboardType,
          InputDecoration(

              prefixIcon: prifix,
              suffixIcon: IconButton(
                  onPressed: onTabSuffix,
                  icon:Icon(sufix)  ,
                  ),

              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              label: Text(text!)),
    );

Widget defultButton(
        {
//  required  Function  Function() onPress
        required void Function()? onPress,
        Widget? child,
        Color? color= (Colors.deepPurple),
        double? width = 90}) =>
    MaterialButton(
      color: color,
      minWidth: width,
      onPressed: onPress,
      child: child,
      textColor: Colors.white,
    );

Widget defultChatMessage(
        {
          // required Color? color,
        // required String? text,
        required Message message
       }) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          // alignment: ,
          child: Text(
            message.message,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          decoration: BoxDecoration(

              color: Colors.teal, borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20)
                ,topRight: Radius.circular(20)
                ,bottomRight: Radius.circular(20)
                  ,bottomLeft: Radius.zero

)),
          padding: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),

        ),
      ),
    );

Widget defultChatMessageforFriend(
    {
      // required Color? color,
      // required String? text,
      required Message message
    }) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          // alignment: ,
          child: Text(
            message.message,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          decoration: BoxDecoration(

              color: Colors.orange, borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20)
              ,topRight: Radius.circular(20)
              ,bottomRight: Radius.zero
              ,bottomLeft:Radius.circular(20)

          )),
          padding: EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),

        ),
      ),
    );
