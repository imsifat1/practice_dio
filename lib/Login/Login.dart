import 'dart:async';
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_dio/HomePage.dart';
import 'package:practice_dio/Login/GoogleSignIn.dart';
import 'package:practice_dio/Login/LoginModel.dart';
import 'package:practice_dio/Login/LoginService.dart';
import 'package:practice_dio/Login/customTextFormField.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

var emailTextController = TextEditingController();
var passwordTextController = TextEditingController();
late Future<LoginModel> getData;
var UserData;

class _LoginState extends State<Login> {
  var textController = TextEditingController();
  String finalEmail = "";
  final _formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;
  Map _userObj = {};

  late Future<LoginModel> getData;

  SaveLoginSession() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("email", emailTextController.text);
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    textController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${textController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 200,
                width: 200,
                child: Image.asset('lib/images/logo.png'),
              ),

              //-------TextField---------

              MyTextFormField(
                HintText: "Email",
                ObscureText: false,
                icon: Icons.email,
                textController: emailTextController,
              ),
              MyTextFormField(
                HintText: "Password",
                ObscureText: true,
                icon: Icons.password,
                textController: passwordTextController,
              ),

              ///-------------------------------------
              ///        Login Button
              /// ------------------------------------
              Container(
                padding: EdgeInsets.fromLTRB(100, 20, 100, 0),
                child: MaterialButton(
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color.fromARGB(255, 179, 21, 34),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or SaveLoginSessionLoginSession the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    print('Button pressed');
                    SaveLoginSession();
                    LoginService.loginProcess();
                    // SaveLoginInfo();
                    // another();
                  },
                ),
              ),

              ///-------------------------------------
              ///        Alternative Button
              /// ------------------------------------

              MaterialButton(
                  color: Colors.amber,
                  child: Text("Alternative"),
                  onPressed: () => Get.to(HomePage())),

              ///-------------------------------------
              ///        Forget password Button
              /// ------------------------------------
              Container(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: MaterialButton(
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  elevation: 0,
                  color: Colors.transparent,
                  onPressed: () {},
                ),
              ),

              ///-------------------------------------
              ///        Facebook login Button
              /// ------------------------------------
              SizedBox(
                height: 100,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 30,
                            width: 30,
                            child: Image.asset('images/Logo/fbLogo.png'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Facebook',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xFF5173B5),
                      onPressed: () {
                        _isLoggedIn
                            ? Column(
                                children: [
                                  Image.network("src"),
                                  Text(""),
                                  TextButton(
                                      onPressed: () {}, child: Text("Logout"))
                                ],
                              )
                            : FacebookAuth.instance
                                .getUserData()
                                .then((userdData) {
                                setState(() {
                                  _isLoggedIn = true;
                                  _userObj = userdData;
                                  Get.to(() => HomePage());
                                });
                              });
                        print('Button pressed');
                      },
                    ),
                  ),
                ),

                ///-------------------------------------
                ///       Google Login Button
                /// ------------------------------------
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 25,
                            width: 25,
                            child: Image.asset('images/Logo/googleLogo.png'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Google',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xFFD2202F),
                      onPressed: () {
                        setState(() {
                          googleSignIn();
                          print('Button pressed');
                          //Get.offNamed('/');
                        });
                      },
                    ),
                  ),
                ),
              ]),

              ///-------------------------------------
              ///        SignUp Button
              /// ------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: MaterialButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                      elevation: 0,
                      color: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          Get.toNamed('/Registration');
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future googleSignIn() async {
    await GooglSignInApi.login();
  }
}
