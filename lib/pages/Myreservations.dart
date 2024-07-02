import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/CustomButton.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/Customtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mesa/compnents/loadingalert.dart';
import 'package:mesa/pages/FoodHome.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  var email, name;
  GlobalKey<FormState> fstate = new GlobalKey<FormState>();

  CollectionReference res =
      FirebaseFirestore.instance.collection("reservations");
  addreservation() async {
    var formdata = fstate.currentState;
    if (formdata!.validate()) {
      showloading(context);
      formdata.save();

      await res
          .add({
            "Reservation name": name,
            "Reservation e-mail": email,
            "userid": FirebaseAuth.instance.currentUser?.uid
          })
          .then((value) => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodHome();
                }))
              })
          .catchError((e) {
            print("error");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Reservations"),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: MyBadge())
          ]),
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Image.asset(
            "images/haw.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Spanish Steak House",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Form(
                  key: fstate,
                  child: Column(
                    children: [
                      FoodTextfield(
                        onchange: (value) {
                          name = value;
                        },
                        hint: "First Name",
                        validator: (value) {
                          if (value!.length < 3) {
                            return "First name Can't be less than 3 chars";
                          }
                          if (value!.length > 30) {
                            return "First name Can't be more than 30 chars";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FoodTextfield(
                        hint: "Last Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FoodTextfield(
                        hint: "Email Address",
                        onchange: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Email Can't be less than 3 chars";
                          }
                          if (value!.length > 30) {
                            return "Email name Can't be more than 30 chars";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FoodTextfield(
                        hint: "Reservation Details",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              MyButton(
                bborder: BorderSide(color: Colors.transparent),
                bcolor: Colors.green,
                btext: "Make Reservation",
                tcolor: Colors.white,
                myf: () async {
                  await addreservation();
                },
              )
            ],
          ),
        )
      ]),
    );
  }
}
