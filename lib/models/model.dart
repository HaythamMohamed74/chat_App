import 'package:chat_app/constant/constants.dart';

class Message{
  late  String message;
  final   id;
  Message(this.message,this.id);
  factory Message.fromJson(jsonData){
    return Message(
        jsonData[kMessage],
        jsonData['id']
    );
  }
}