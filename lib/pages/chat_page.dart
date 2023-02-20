import 'package:chat_app/models/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../component/componets.dart';
import '../constant/constants.dart';

class Chat extends StatefulWidget {
  // const SignIn({super.key});
static String id="chat_page";


  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String ?messageBody;
  // final Stream<QuerySnapshot> messages = FirebaseFirestore.instance.collection(kMessageCollectoin).snapshots();
TextEditingController controller=TextEditingController();
FirebaseFirestore firestore = FirebaseFirestore.instance;
final ScrollController _controller = ScrollController();
// DateTime dateTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var emailId=ModalRoute.of(context)!.settings.arguments;

    CollectionReference messages = FirebaseFirestore.instance.collection(
        kMessageCollectoin);
    return  StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('date',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

        if(snapshot.hasData){
          List<Message>messagesList=[];
          for(int i=0;i<snapshot.data!.docs.length;i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
            return
              SafeArea(
                  child: Scaffold(

                      appBar: AppBar(
                          backgroundColor: Colors.teal,
                          centerTitle: true,
                          title: Text('Chat')
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              controller: _controller,
                              itemCount: messagesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return messagesList[index].id==emailId ? defultChatMessage(
                                    message: messagesList[index]):defultChatMessageforFriend(message: messagesList[index] ) ;
                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controller,
                              onChanged: (data) {
                                messageBody=data;

                              },
                              decoration: InputDecoration(
                                  hintText: "Send Message",
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if( messageBody?.trim() !=''&&messageBody?.trim()!=null){
                                          messages.add({
                                            "message": messageBody
                                            ,'date': DateTime.now().toIso8601String().toString(),
                                            "id":emailId

                                          }

                                          ).then((value){
                                            controller.clear();
                                            _controller.jumpTo(
                                            0
                                            );
                                          });

                                        }


                                      }, icon: Icon(
                                Icons.send_rounded, color: Colors.teal,),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                          )
                        ],
                      )


                  )
              );
          }else return Center(child: (CircularProgressIndicator()));
        }


    );

  }
}
