import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/DisplayData.dart';
import 'package:mesa/compnents/pageview.dart';
import 'package:mesa/model/cart_item_model.dart';
import 'package:mesa/pages/AddToCart.dart';
import 'package:provider/provider.dart';

class FoodHome extends StatefulWidget {
  const FoodHome({Key? key}) : super(key: key);

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  var fms = FirebaseMessaging.instance;

  var food = [];
  late List<dynamic> or;
  Mydata m = new Mydata();
  getdata() {
    m.mylist = [m.Burgers, m.Ramen];
    for (var i = 0; i < 1; i++) {
      m.mylist.forEach((element) {
        setState(() {
          food.addAll(element);
          food..sort((a, b) => a['name'].compareTo(b['name']));
          or = food.where((element) => element["ordered"] > 3).toList();
        });
      });
    }
  }

  @override
  void initState() {
    fms.getToken().then((value) {
      print("===========================");
      print(value);
      print("===========================");
    });
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Home"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: MyBadge())
          ]),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Popular Categories"),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: MyPageView()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Best Deals"),
              ),
              MyStack(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Most Popular"),
              ),
              or.isEmpty
                  ? CircularProgressIndicator(
                      color: Colors.green,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: or.length,
                      itemBuilder: (context, i) {
                        return Card(
                            child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                CartItemModel cartItemModelData = CartItemModel(
                                    id: food[i]['id'],
                                    image: food[i]['image'],
                                    price: food[i]['price'],
                                    name: food[i]['name'],
                                    count: 0);

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddToCart(
                                      cartItemModel: cartItemModelData);
                                }));
                                // اخطبوت الفلاتر والبرمجة
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(or[i]['image']))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(or[i]['name']),
                                  Text(or[i]['price'].toString())
                                ],
                              ),
                            )
                          ],
                        ));
                      })
            ],
          )
        ],
      ),
    );
  }
}
