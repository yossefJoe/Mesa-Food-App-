import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mesa/compnents/CustomButton.dart';
import 'package:mesa/compnents/Customtextfield.dart';
import 'package:mesa/compnents/loadingalert.dart';
import 'package:mesa/pages/FoodHome.dart';

class FoodSignin extends StatefulWidget {
  const FoodSignin({Key? key}) : super(key: key);

  @override
  State<FoodSignin> createState() => _FoodSigninState();
}

class _FoodSigninState extends State<FoodSignin> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String mypassword = "";

  String myemail = "";
  Future<void> signInWithEmailAndPassword() async {
    try {
      showloading(context);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: myemail,
        password: mypassword,
      );
      // Signed in
      User? user = userCredential.user;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return FoodHome();
      })));
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password or email is incorrect"),
              title: Text("Try Again"),
              actions: [CloseButton()],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                        child: Column(
                      children: [
                        FoodTextfield(
                          onchange: (value) => myemail = value.trim(),
                          validator: (value) {
                            if (value!.length < 7) {
                              return "Email can't be less than seven chars";
                            }
                          },
                          hint: "E-mail",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FoodTextfield(
                          onchange: (value) => mypassword = value.trim(),
                          validator: (value) {
                            if (value!.length < 7) {
                              return "Password can't be less than seven chars";
                            }
                          },
                          hint: "Password",
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    MyButton(
                      myf: signInWithEmailAndPassword,
                      bborder: BorderSide(color: Colors.transparent),
                      bcolor: Colors.green,
                      btext: "Log in",
                      tcolor: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyButton(
                      myf: signInWithGoogle,
                      bborder: BorderSide(color: Colors.transparent),
                      bcolor: Colors.amber,
                      btext: "Google Login",
                      tcolor: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
