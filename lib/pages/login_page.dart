import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/componets.dart';
import 'chat_page.dart';

class Login extends StatefulWidget {
   Login({Key? key}) : super(key: key);
   static String id="login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;

  String? password;

  bool hint=false;


  @override
  void initState() {
    hint=true;
  }

  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    return  Scaffold(
      // backgroundColor: (Colors.green),
        body:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/undraw_Login_re_4vu2.png',height: 300,)

              ,Container(
                padding:EdgeInsets.all(10) ,
                // height: double.infinity,
                child: Form(
                  key: formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Row(children: const [
                        Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.deepPurple),)
                      ],)
                      ,const SizedBox(height: 15,)
                      ,defultTextField(
                          onChanged: (data){
                            email=data;
                          },
                          validation: (value){
                        if (value==null||value.isEmpty) {
                          return" please Enter Email";
                        }
                        return null;
                      }, text: 'Email',prifix: Icon(Icons.email_outlined))
                      ,SizedBox(height: 15,)
                      ,defultTextField(
                          hint_Text: hint,
                         sufix: Icons.remove_red_eye,
                          onTabSuffix: (){
                          setState(() {
                            hint=!hint;
                          });
                          },
                          onChanged: (data){
                            password=data;
                          },
                          validation: (value){
                        if (value==null||value.isEmpty) {
                          return" please Enter Password";
                        }
                        return null;
                      }, text: 'Password',

                          prifix: Icon(Icons.lock_clock_outlined)),

                      Row(children:  [
                        Text("If You Dont have Account! ",style: TextStyle(fontFamily: 'myfonts'),)
                        ,TextButton(onPressed: (){
                          Navigator.pushNamed(context, Register.id);
                        }, child: Text('Register'))
                      ],


                      )
                      ,defultButton(onPress:() async {if (formkey.currentState!.validate()) {
                        try {
                           UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email!,
                              password: password!
                          );
                           Navigator.pushNamed(context, Chat.id,arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content:
                                Text(' User not Found')));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content:
                                Text(' Wrong password')));
                          }

                        }

                      }

                      },child: Text('Login') )
                    ],
                  ),
                ),
              )

            ],),
        )
    );
  }
}
