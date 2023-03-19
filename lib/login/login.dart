// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_new_orange/classes/splash/home/home.dart';
import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:my_new_orange/header/utils/custom/app_bar.dart';
// import 'package:my_new_orange/registration/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  FirebaseAuth firebase_auth = FirebaseAuth.instance;
  //
  var firebase_error_status = '0';
  var firebase_error_status_text = '';
  //
  var str_save_and_continue_loader = '0';
  //
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController cont_email;
  late final TextEditingController cont_password;
  //
  @override
  void initState() {
    super.initState();
    //

    cont_email = TextEditingController();
    cont_password = TextEditingController();
  }

  // @override
  // void dispose() {
  //   //

  //   cont_email.dispose();
  //   cont_password.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        /*appBar: AppBarScreen(
          str_app_bar_title: 'Login',
          str_status: '0',
        ),*/
        body: Container(
          color: app_blue_color,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 60.0),
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          24,
                        ),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      // width: 48.0,
                      // height: 48.0,
                      child: Image.asset(
                        'assets/gif/logo_3.png',
                        fit: BoxFit.fitWidth,
                      ),

                      // height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
                // const Spacer(),
                Container(
                  // height: 500 - 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    //color: Colors.blueAccent,
                    // 80 160 214
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        52,
                      ),
                      topRight: Radius.circular(
                        52,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Align(
                        // alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 14.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: font_family_name,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      //
                      Align(
                        // alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 14.0, bottom: 14),
                          child: Text(
                            'Please login to enter.',
                            style: TextStyle(
                              fontFamily: font_family_name,
                              // fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // email
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 234, 234),
                          // border: Border.all(
                          //   color: app_blue_color,
                          // ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: cont_email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Email',
                              hintText: 'please enter your email...',
                              labelStyle: TextStyle(
                                fontFamily: font_family_name,
                                fontSize: 16.0,
                                // color: Colors.red,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      // password
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 234, 234),
                          // border: Border.all(
                          //   color: app_blue_color,
                          // ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: cont_password,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Password',
                              hintText: 'password...',
                              labelStyle: TextStyle(
                                fontFamily: font_family_name,
                                fontSize: 16.0,
                                // color: Colors.red,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      // sign in
                      (str_save_and_continue_loader == '1')
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (kDebugMode) {
                                    print('value all fill now');
                                  }
                                  func_firebase_login();
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(
                                  10.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    30.0,
                                  ),
                                  color: app_blue_color,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontFamily: font_family_name,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      //

                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          // width: 48.0,
                          // height: 48.0,
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account ?",
                              style: TextStyle(
                                  fontFamily: font_family_name,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '  Sign Up',
                                  style: TextStyle(
                                    fontFamily: font_family_name,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: app_blue_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  func_firebase_login() async {
    //
    setState(() {
      firebase_error_status = '0';
      str_save_and_continue_loader = '1';
    });
    //
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: cont_email.text.toString(),
        password: cont_password.text.toString(),
      );
      if (kDebugMode) {
        print(userCredential.user);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreenScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        firebase_error_status = '1';
        str_save_and_continue_loader = '0';
        firebase_error_status_text = e.code.toString();
      });
    } catch (e) {
      print(e);
    }
  }
}
