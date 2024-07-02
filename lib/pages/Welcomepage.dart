import 'package:flutter/material.dart';
import 'package:mesa/compnents/CustomButton.dart';
import 'package:mesa/pages/foodsignin.dart';
import 'package:mesa/pages/foodsignup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                Text(
                  "Wlcome to MESA",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Check out our menus, order food and make reservations",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(
                  bcolor: Colors.green,
                  btext: "Log in",
                  myf: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FoodSignin();
                    }));
                  },
                  tcolor: Colors.white,
                  bborder: BorderSide(color: Colors.transparent),
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(
                  bcolor: Colors.white,
                  btext: "Sign up",
                  myf: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FoodSignup();
                    }));
                  },
                  tcolor: Colors.black,
                  bborder: BorderSide(color: Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
