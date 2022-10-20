import 'dart:async';
//  StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {

import 'package:assignment_app/google_sigin.dart';
import 'package:assignment_app/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {"homepage": (context) => Home()},
        home: login(),
      ),
    );
  }
}

var loginpressed = false;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  //Field values
  var Email;
  var password;

  var _error;
  late Timer _timer;

  bool? _erroris = false;

  bool? termsagree = false;

  CountryCode? code;
  var newEmail;
  var contact;
  var newpassword;

  var newName;

  //Every each second the interface will refresh with this function.
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  //Error validation
  bool validator() {
    if (formkey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  var auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  var page = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Row(
            children: [
              Text(
                'Social',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                'X',
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 35),
              )
            ],
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  width: MediaQuery.of(context).size.width,
                  child: page == 1
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: MaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {},
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1.5),
                                      ),
                                    ),
                                  )),
                            ),
                            Container(
                                width: 190,
                                height: 50,
                                child: MaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {
                                      page = 2;
                                      setState(() {});
                                    },
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          letterSpacing: 1.5),
                                    )))
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 190,
                                height: 50,
                                child: MaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {
                                      page = 1;
                                      setState(() {});
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          letterSpacing: 1.5),
                                    ))),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: MaterialButton(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {},
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.5),
                                    ),
                                  ),
                                )),
                          ],
                        )),
              Container(
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Title

                        //error display (if any)

                        //title icon
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width,
                            height: page == 1 ? 580 : null,
                            child: Column(
                              children: [
                                showAlert(),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: page == 1
                                      ? Column(children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  'SignIn into your Account',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),

                                          //Widget to - Type/Fill Email
                                          Row(children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  // enableSuggestions: true,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Email can't be empty";
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 20, left: 10),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    suffixIcon: Icon(
                                                      Icons.mail,
                                                      color: Colors.red,
                                                    ),
                                                    hintText:
                                                        "johndoe@gmail.com",
                                                    labelStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255,
                                                            111,
                                                            111,
                                                            111)),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {});
                                                    Email = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30),

                                          //Widget to - Type/Fill Password
                                          Row(children: [
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextFormField(
                                              obscureText: true,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter a valid password";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                suffixIcon: Icon(
                                                  Icons.lock_outlined,
                                                  color: Colors.red,
                                                ),
                                                contentPadding: EdgeInsets.only(
                                                    top: 20, left: 10),
                                                hintText: "Password",
                                                labelStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 111, 111, 111)),
                                              ),
                                              onChanged: (value) {
                                                password = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Forget Password ?',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ]),

                                          SizedBox(height: 15),
                                          Text('Login with'),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  final provider = Provider.of<
                                                          GoogleSignInProvider>(
                                                      context,
                                                      listen: false);
                                                  await provider.googleLogin();
                                                  Navigator.of(context)
                                                      .pushNamed('homepage');
                                                },
                                                child: Image(
                                                  height: 30,
                                                  image: AssetImage(
                                                      "assets/image/google.png"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: Image(
                                                  height: 30,
                                                  image: AssetImage(
                                                      "assets/image/fb.png"),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //Widget to - Navigate/Goto Signup page
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Don't have an Account?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(),
                                              TextButton(
                                                onPressed: () {
                                                  page = 2;
                                                  setState(() {});
                                                },
                                                child: Text("Register Now",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ])
                                      : Column(children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  'Create an Account',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Row(children: [
                                              Text(
                                                'Name',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ]),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  // enableSuggestions: true,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter your name";
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 20, left: 10),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    suffixIcon: Icon(
                                                      Icons.person,
                                                      color: Colors.red,
                                                    ),
                                                    hintText: "John doe",
                                                    labelStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255,
                                                            111,
                                                            111,
                                                            111)),
                                                  ),
                                                  onChanged: (name) {
                                                    newName = name;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),

                                          //Widget to - Fill name
                                          SizedBox(height: 30),

                                          //Widget to - Type/Fill Email
                                          Row(children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  enableSuggestions: true,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Email can't be empty";
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 20, left: 10),
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    suffixIcon: Icon(
                                                      Icons.mail,
                                                      color: Colors.red,
                                                    ),
                                                    hintText:
                                                        "johndoe@gmail.com",
                                                    labelStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255,
                                                            111,
                                                            111,
                                                            111)),
                                                  ),
                                                  onChanged: (value) {
                                                    newEmail = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30),

                                          Row(children: [
                                            Text(
                                              'Contact no',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                // TextButton(onPressed: (){}, child: ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    code = await countryPicker
                                                        .showPicker(
                                                            context: context);
                                                    if (code != null)
                                                      print(code);
                                                  },
                                                  child: code == null
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: SizedBox(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7.0),
                                                            child: Text(
                                                              'Select Country',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                        )
                                                      : Row(
                                                          children: [
                                                            code!.flagImage,
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                '${code!.dialCode}'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(Icons
                                                                .arrow_drop_down)
                                                          ],
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    enableSuggestions: true,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter your contact";
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 20,
                                                              left: 10),
                                                      filled: true,
                                                      fillColor:
                                                          Colors.transparent,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      suffixIcon: Icon(
                                                        Icons.mail,
                                                        color: Colors.red,
                                                      ),
                                                      hintText: "9876543210",
                                                      labelStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255,
                                                              111,
                                                              111,
                                                              111)),
                                                    ),
                                                    onChanged: (value) {
                                                      contact = value;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),

                                          //Widget to - Type/Fill Password
                                          Row(children: [
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextFormField(
                                              obscureText: true,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter a valid password";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                suffixIcon: Icon(
                                                  Icons.lock_outlined,
                                                  color: Colors.red,
                                                ),
                                                contentPadding: EdgeInsets.only(
                                                    top: 20, left: 10),
                                                hintText: "Password",
                                                labelStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 111, 111, 111)),
                                              ),
                                              onChanged: (value) {
                                                newpassword = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 25),

                                          Row(
                                            children: [
                                              Checkbox(
                                                value: termsagree,
                                                onChanged: (value) {
                                                  setState(() {
                                                    termsagree = value;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('I agree with'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "term & condition",
                                                    style: TextStyle(
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.red,
                                                            offset:
                                                                Offset(0, -3))
                                                      ],
                                                      color: Colors.transparent,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Colors.red,
                                                      decorationThickness: 2,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                          //Widget to - Navigate/Goto Signup page
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Already have an Account?",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(),
                                              TextButton(
                                                onPressed: () {
                                                  page = 1;
                                                  setState(() {});
                                                },
                                                child: Text("Sign In!",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: //Widget to - Pass the credentials

            BottomSheet(
          backgroundColor: Colors.grey,
          builder: (context) => Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.red,
              ),
              child: Center(
                  child: page == 1
                      ? TextButton(
                          onPressed: () async {
                            setState(() {});
                            if (validator()) {
                              try {
                                final user = FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: Email, password: password)
                                    .catchError((e) {
                                  setState(() {
                                    _error = e.message;
                                    _erroris = true;
                                  });
                                }).then((value) {
                                  loginpressed = true;

                                  Navigator.pushReplacementNamed(
                                      context, "homepage");
                                });
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _error = e.message;
                                  _erroris = true;
                                });
                                print(e);
                              }
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5),
                          ))
                      : TextButton(
                          onPressed: () async {
                            setState(() {});

                            if (validator()) {
                              try {
                                final user = await auth
                                    .createUserWithEmailAndPassword(
                                        email: newEmail, password: newpassword)
                                    .then((value) =>
                                        Navigator.pushReplacementNamed(
                                            context, "homepage"));
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _error = e.message;
                                });
                                print(e);
                              }
                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5),
                          )))),
          onClosing: () {},
        ),
      ),
    );
  }

  //Error Showing Widget
  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline_outlined),
            ),
            Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text("$_error")),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
