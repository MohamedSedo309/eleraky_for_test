import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/progressHUD.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage.dart';

class Login_Screen extends StatefulWidget {
  static String screenID = 'LoginScreen';

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final form_key = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  bool keep_me_loggedin = false;

  var username = '';

  var password = '';

  var mUsername = 'admin';
  var mPassword = 'admin1234';

  submit(BuildContext ctx) {
    var hud = Provider.of<ProgressHUDprovider>(ctx, listen: false);
    final progress = ProgressHUD.of(ctx);

    bool isValid = form_key.currentState!.validate();

    if (isValid) {
      form_key.currentState!.save();

      if (username == mUsername && password == mPassword) {
        hud.isLoading = true;
        progress?.showWithText('جاري التحميل');

        auth.signInWithEmailAndPassword(
            email: 'admin2@mail.com', password: 'admin1234');
        auth.authStateChanges().listen((User? user) {
          if (user?.uid == '7mSQPH6URmcMRPqhWFLsA9YpU5P2') {
            hud.isLoading = false;
            form_key.currentState!.reset();
            Navigator.of(context).pushReplacementNamed(HomePage.screenID);
          }
          if (user == null) {
            hud.isLoading = false;
          }
        });
        hud.isLoading = false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تأكد من اسم المستخدم وكلمة السر'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen_hieght = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<ProgressHUDprovider>(
      create: (context) => ProgressHUDprovider(),
      child: Form(
        key: form_key,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mainColor,
          body: ProgressHUD(
            indicatorColor: secoundryColor,
            indicatorWidget: CircularProgressIndicator(
              color: mainColor,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: screen_hieght * 0.3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 75,
                          height: 200,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'أولاد العراقي',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل إسم المستخدم';
                      }
                    },
                    onSaved: (val) {
                      username = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "إسم المستخدم",
                      prefixIcon: Icon(
                        Icons.person,
                        color: mainColor,
                      ),
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل كلمة السر';
                      }
                    },
                    onSaved: (val) {
                      password = val!;
                    },
                    cursorColor: mainColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "كلمة السر",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: mainColor,
                      ),
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        if (keep_me_loggedin) {
                          keepUser_loggedin();
                        }
                        submit(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: Text(
                          "تسجيل الدخول",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: screen_hieght * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: keep_me_loggedin,
                          onChanged: (val) {
                            setState(() {
                              keep_me_loggedin = val!;
                            });
                          }),
                      Text(
                        'تذكرني',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  keepUser_loggedin() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(remember_User, keep_me_loggedin);
  }
}
