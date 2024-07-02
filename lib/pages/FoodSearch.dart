import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/DisplayData.dart';
import 'package:mesa/model/cart_item_model.dart';
import 'package:mesa/pages/AddToCart.dart';
import 'package:provider/provider.dart';

class FoodSearch extends StatefulWidget {
  const FoodSearch({
    Key? key,
  }) : super(key: key);

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  late String search;
  TextEditingController te = new TextEditingController();
  var food = [];
  var foundfood = [];
  Mydata m = new Mydata();
  getdata() {
    m.mylist = [m.Burgers, m.Ramen];
    m.mylist.forEach((element) {
      setState(() {
        food.addAll(element);
        food..sort((a, b) => a['name'].compareTo(b['name']));
      });
    });
  }

  getresults(String enteredKeyword) {
    List results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = food;
    } else {
      results = food
          .where((element) => element["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        foundfood = results;
      });
    }
  }

  @override
  void initState() {
    getdata();
    foundfood = food;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            height: 30,
            child: TextFormField(
                cursorColor: Colors.blue,
                controller: te,
                decoration: InputDecoration(
                    prefixIconColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey[200],
                    filled: true),
                onChanged: (val) {
                  getresults(val);
                  setState(() {
                    search = val;
                  });
                }),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  te.clear();
                  setState(() {
                    foundfood = food;
                  });
                },
                child: Text("Clear")),
            Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: MyBadge())
          ],
        ),
        body: ListView(
          children: [
            foundfood.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: foundfood.length,
                    itemBuilder: (context, i) {
                      return Consumer<MyCart>(
                          builder: (context, controller, child) {
                        return GestureDetector(
                            child: ListTile(
                                onTap: () {
                                  if (controller.products
                                          .where((CartItemModel element) =>
                                              element.id == food[i]['id'])
                                          .toList()
                                          .length !=
                                      0) {
                                    int x = controller.products
                                        .where((element) =>
                                            element.id == food[i]['id'])
                                        .map((element) => element.count)
                                        .first;
                                    CartItemModel cartItemModelData = CartItemModel(
                                        id: food[i]['id'],
                                        image: food[i]['image'],
                                        price: food[i]['price'],
                                        name: food[i]['name'],
                                        // هنا انا بسئله بقوله لو في في الليستا بتاعتى id == product_id =>بيقي وانت داخل على المنج خليلي الcount fjhui .n hgn td cart
                                        // عشان لما اجي اضيف ميبداش من الصفر
                                        count: x);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return AddToCart(
                                          cartItemModel: cartItemModelData);
                                    }));
                                  } else {
                                    CartItemModel cartItemModelData =
                                        CartItemModel(
                                            id: food[i]['id'],
                                            image: food[i]['image'],
                                            price: food[i]['price'],
                                            name: food[i]['name'],
                                            count: 0);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return AddToCart(
                                          cartItemModel: cartItemModelData);
                                    }));
                                  }
                                },
                                trailing: Text("${foundfood[i]['price']}"),
                                subtitle: Text(
                                    "${foundfood[i]['ingredients'].join(",")}"),
                                tileColor: Colors.grey[200],
                                title: Text("${foundfood[i]['name']}")));
                      });
                    })
                : Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ],
        ));
  }
}
