import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/componets.dart';
import 'chat_page.dart';

class Register extends StatelessWidget {
  // const Register({Key? key}) : super(key: key);
  static String id = 'register';

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return (
      Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/undraw_welcome_cats_thqn.png',
              height: 300,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              // height: double.infinity,
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.deepPurple),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defultTextField(
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return " please Enter Email";
                          }
                          return null;
                        },
                        text: 'Email',
                        prifix: const Icon(Icons.email_outlined),
                        onChanged: (data) {
                          email = data;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    defultTextField(
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return " please Enter Password";
                          }
                          return null;
                        },
                        text: 'Password',
                        hint_Text: true,
                        prifix: const Icon(Icons.lock_clock_outlined),
                        onChanged: (data) {
                          password = data;
                        }),
                    Row(
                      children: [
                        const Text(
                          "If You Dont have Account! ",
                          style: TextStyle(fontFamily: 'myfonts'),
                        ),
                        TextButton(
                            onPressed: () {
                              //   if (formkey.currentState!.validate())
                              Navigator.pop(context);
                            },
                            child: const Text('Login'))
                      ],
                    ),
                    defultButton(
                      child: const Text('Register'),
                      onPress: () async {

                        if (formkey.currentState!.validate()) {

                          try {
                            UserCredential credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email!, password: password!);
                            // showDialog(
                            //      context: context
                            //     ,builder: (context){
                            //        return Center(child: CircularProgressIndicator());
                            // }
                            //
                            // );
                          Navigator.pushNamed(context, Chat.id,arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      ' The account already exists for that email')));
                            } else if (ex.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content:
                                      Text(' The password provided is too weak')));
                            }

                          }

                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                              content: Text(' Please enter Email or Password')));
                        }

                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ))
    );
  }
}
