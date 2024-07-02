import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/DisplayData.dart';
import 'package:mesa/model/cart_item_model.dart';
import 'package:mesa/pages/AddToCart.dart';
import 'package:provider/provider.dart';

class MyDisplay extends StatefulWidget {
  final String? pagetitle;
  final String? chosen;

  const MyDisplay({Key? key, this.pagetitle, this.chosen}) : super(key: key);

  @override
  State<MyDisplay> createState() => _MyDisplayState();
}

class _MyDisplayState extends State<MyDisplay> with Mydata {
  var ldata = [];
  getdata() {
    mylist = [Burgers, Ramen];
    mylist[Menunames.indexOf(widget.pagetitle!)].forEach((element) {
      setState(() {
        ldata.add(element);
        ldata.toSet().toList();
      });
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

// run
// لسة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.pagetitle!),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: MyBadge())
        ],
      ),
      body: ListView(children: [
        ListView.builder(
            itemCount: ldata.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Consumer<MyCart>(builder: (context, controller, child) {
                return GestureDetector(
                  child: ListTile(
                    onTap: () {
                      if (controller.products
                              .where((CartItemModel element) =>
                                  element.id == ldata[i]['id'])
                              .toList()
                              .length !=
                          0) {
                        int x = controller.products
                            .where((element) => element.id == ldata[i]['id'])
                            .map((element) => element.count)
                            .first;
                        CartItemModel cartItemModelData = CartItemModel(
                            id: ldata[i]['id'],
                            image: ldata[i]['image'],
                            price: ldata[i]['price'],
                            name: ldata[i]['name'],
                            count: x);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddToCart(cartItemModel: cartItemModelData);
                        }));
                      } else {
                        CartItemModel cartItemModelData = CartItemModel(
                            id: ldata[i]['id'],
                            image: ldata[i]['image'],
                            price: ldata[i]['price'],
                            name: ldata[i]['name'],
                            count: 0);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddToCart(cartItemModel: cartItemModelData);
                        }));
                      }
                    },
                    tileColor: Colors.grey[200],
                    title: Text(ldata[i]['name']),
                    subtitle: Text("${ldata[i]['ingredients']}"),
                    trailing: Text("\$" + "${ldata[i]['price']}"),
                  ),
                );
              });
            })
      ]),
    );
  }
}
