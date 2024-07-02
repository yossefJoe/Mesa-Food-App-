import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/model/cart_item_model.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddToCart extends StatelessWidget {
  final CartItemModel cartItemModel;
  AddToCart({Key? key, required this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("${cartItemModel.name}"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: MyBadge())
          ]),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${cartItemModel.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Image.asset("${cartItemModel.image}"),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width * 0.35,
                  child:
                      Consumer<MyCart>(builder: (context, controller, child) {
                    return Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.removeQty(cartItemModel);
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 15,
                            )),
                        Text(
                          "${cartItemModel.count}",
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.addQty(cartItemModel);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 15,
                            )),
                        //فين الصفحه الى قبلها الى لما تدول على زرار يدخلك هنا
                      ],
                    );
                  })),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Card(
                  child: Text("${cartItemModel.price}" + ".0"),
                ),
                SizedBox(
                  width: 10,
                ),
                Consumer<MyCart>(
                  builder: (context, cart, child) {
                    return MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // زودت 3 هنا بس عمل الكونت بتاعهم 1
                        // كدة هنا بيعمل ايه ؟
                        // بعدد واحد للعنصر الواحد متقدرش تزود الكميه غير من زرار الزائد
                        // هنا بيضيف المنتج للكارت  ب
                        // ماينفعش زي الاول ؟
                        // كنت عامله بيزود العدد اللى زرار + عمله ابعت فويس
                        // رجعت زودت 3 من حاجة مازادتش
                        // المفروض الكود دا ان الزواده تكون جوه الكارت ذات نفيها وهنا في صفحه المنتج يبقي .vhv
                        // زرار ال add
                        // بس هاهندله واقولك في الاخر عملت اي

                        cart.addProduct(cartItemModel).then((value) {
                          Fluttertoast.showToast(
                              msg: "${cartItemModel.name}" +
                                  " Was Added Successfully to the cart",
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.of(context).pop();
                        });
/*
                        });
                       
                        for (var i = 0; i < mynum; i++) {
                          cart.add(widget);
                          widget.count = widget.count! + 1;
                        }
                        */

                        // هنا نسينا الميثود بتاعت add
                      },
                      color: Colors.green,
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
