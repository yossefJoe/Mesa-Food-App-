import 'package:flutter/material.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/compnents/loadingalert.dart';
import 'package:mesa/pages/FoodHome.dart';
import 'package:provider/provider.dart';

class MyDialoge extends AlertDialog {
  final BuildContext context;
  MyDialoge(this.context)
      : super(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Consumer<MyCart>(
                    builder: (context, controller, child) {
                      return MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            "Pay " + "{\$${controller.totalPrice()}}",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            showloading(context);
                            await controller.addorder();
                            controller.removeAll();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return FoodHome();
                            }));
                          });
                    },
                  )
                ],
              ),
            )
          ],
          title: Expanded(
              child: TextFormField(
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo)),
                prefixIconColor: Colors.grey,
                hintText: "1234 1234 1234 1234",
                prefixIcon: Icon(Icons.credit_card_sharp)),
          )),
          content: Row(
            children: [
              Expanded(
                  child: TextFormField(
                cursorColor: Colors.indigo,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo)),
                    hintText: "Expiration date"),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextFormField(
                      cursorColor: Colors.indigo,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo)),
                          hintText: "CVC")))
            ],
          ),
        );
}
