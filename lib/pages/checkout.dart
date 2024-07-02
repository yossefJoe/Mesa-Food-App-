import 'package:flutter/material.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/Mydialoge.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var counts = {};
// دي صفحة محتويات ال controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Consumer<MyCart>(
          builder: (context, controller, child) {
            return controller.products.isEmpty
                ? Text("")
                : MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyDialoge(context));
                          });
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                  );
          },
        ),
        appBar: AppBar(
          title: Text("Your Cart"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Consumer<MyCart>(
              builder: (context, controller, child) {
                return controller.products.length == 0
                    ? Column(children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text("Your Cart Is Empty!"),
                          ),
                        )
                      ])
                    : Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.products.length,
                              itemBuilder: (context, i) {
                                return Dismissible(
                                  direction: DismissDirection.horizontal,
                                  key: Key("$i"),
                                  confirmDismiss: (direction) async {
                                    if (controller.products.length != 0) {
                                      controller.removeProduct(
                                          controller.products[i]);
                                    }
                                  },
                                  // عايز انهي صفحة ؟
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                          "${controller.products[i].count}"),
                                      leading:
                                          Text(controller.products[i].name),
                                      trailing: Text("\$" +
                                          controller.products[i].price
                                              .toString()),
                                    ),
                                  ),
                                );
                              }),
                          Consumer<MyCart>(
                            builder: (context, controller, child) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total"),
                                    Text("\$" "${controller.totalPrice()}")
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
              },
            ),
          ],
        ));
  }
}
