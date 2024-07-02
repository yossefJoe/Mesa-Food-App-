import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mesa/compnents/CustomButton.dart';
import 'package:mesa/compnents/Customtextfield.dart';
import 'package:mesa/compnents/loadingalert.dart';
import 'package:mesa/pages/FoodHome.dart';

class FoodSignup extends StatefulWidget {
  const FoodSignup({Key? key}) : super(key: key);

  @override
  State<FoodSignup> createState() => _FoodSignupState();
}

class _FoodSignupState extends State<FoodSignup> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var fullname, mypassword, myemail, phonenumber;

  signup() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showloading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Password is too weak"),
                  title: Text("Try Again"),
                  actions: [CloseButton()],
                );
              });
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("email-already-in-use"),
                  title: Text("Try Again"),
                  actions: [CloseButton()],
                );
              });
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Not vaild");
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
                      "Create New Account",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                        key: formState,
                        child: Column(
                          children: [
                            FoodTextfield(
                              onchange: (newValue) {
                                fullname = newValue;
                              },
                              validator: (value) {
                                if (value!.length < 2) {
                                  return "Full Name can't be less than two chars";
                                }
                                return null;
                              },
                              hint: "Full Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FoodTextfield(
                              onchange: (newValue) {
                                phonenumber = newValue;
                              },
                              validator: (value) {
                                if (value!.length < 11) {
                                  return "Full Name can't be less than 11 chars";
                                }
                                return null;
                              },
                              hint: "Phone Number",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FoodTextfield(
                              onchange: (newValue) {
                                myemail = newValue;
                              },
                              validator: (value) {
                                if (value!.length < 10) {
                                  return "Email can't be less than 10 chars";
                                }
                                return null;
                              },
                              hint: "E-mail Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FoodTextfield(
                              onchange: (newValue) {
                                mypassword = newValue;
                              },
                              validator: (value) {
                                if (value!.length < 8) {
                                  return "Full Name can't be less than eight chars";
                                }
                                return null;
                              },
                              hint: "Password",
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    MyButton(
                      myf: () async {
                        UserCredential response = await signup();
                        if (response != null) {
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .add({
                            "username": fullname,
                            "email": myemail,
                            "phone": phonenumber
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return FoodHome();
                          }));
                        } else {
                          print("Signup failed");
                        }
                      },
                      bborder: BorderSide(color: Colors.transparent),
                      bcolor: Colors.indigo,
                      btext: "Sign up",
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
