import 'package:flutter/material.dart';
import 'package:mesa/model/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyCart with ChangeNotifier {
  List<CartItemModel> products = [];
  //double _price = 0.0;
  // List myo = [];
  //Add Product
  Future<dynamic> addProduct(CartItemModel product) async {
    // check this item count ==0  if found  => add product  if  count >0 => this product found before so edit in count =1
    if (products
            .where((CartItemModel element) => element.id == product.id)
            .toList()
            .length ==
        0) products.add(product);
    products
        .where((CartItemModel element) => element.id == product.id)
        .first
        .count = 1;
    notifyListeners();
  }

// احر حاجة كنت بتشوفها كانت ال id
// واخد بالى بس بفكر في هندلتها
// تقريبا المشكلة في العنصر اللى متباصي في الميثود في الصفحة مش هنا
  // update the  count  {add}
  Future<dynamic> addQty(CartItemModel product) async {
    if (products
            .where((CartItemModel element) => element.id == product.id)
            .toList()
            .length ==
        0) {
      products.add(product);
    }
    //edit count
    product.count = product.count + 1;
    // edit in products List
    products
        .where((CartItemModel element) => element.id == product.id)
        .first
        .count = product.count;

    notifyListeners();
  }

// update the  count  {remove}
  Future<dynamic> removeQty(CartItemModel product) async {
    if (product.count > 0) {
      product.count = product.count - 1;
      if (product.count == 0)
        products
            .removeWhere((CartItemModel element) => element.id == product.id);
      else
        products
            .where((CartItemModel element) => element.id == product.id)
            .first
            .count = product.count;
    }
    notifyListeners();
  }

// انا ملاحظ انها بتزيد من الزرار نفسه انا عايزها تزيد من add to cart
  // delete product
  Future<dynamic> removeProduct(CartItemModel product) async {
    products.removeWhere((CartItemModel element) => element.id == product.id);
    notifyListeners();
  }

  //getv total
  double totalPrice() {
    double total = 0;
    products.forEach((CartItemModel element) {
      total += element.price * element.count;
    });
    return total;
  }

  addorder() async {
    CollectionReference noteref =
        FirebaseFirestore.instance.collection("orders");
    List yourItemList = [];
    for (int i = 0; i < products.length; i++)
      yourItemList.add({
        "name": products[i].name,
        "price": products[i].price,
        "quantity": products[i].count
      });

    if (products.isEmpty == false) {
      print("11111111111");
      await noteref.add({
        "order": yourItemList,
        "userid": FirebaseAuth.instance.currentUser?.uid,
        "price": totalPrice()
      }).catchError((e) {
        print("error");
      });
    }
  }

  void removeAll() {
    products.clear();
    notifyListeners();
  }
/*
  void add(AddToCart item) {
    items.add(item);
    _price += item.price!;
    notifyListeners();
  }

  void remove(AddToCart item) {
    items.removeWhere((element) => element == item);
    for (var i = 0; i < item.count!; i++) {
      _price -= item.price!;
    }

*/
  // items.remove(item);
  // _price -= item.price!;

  notifyListeners();
}
/*
  void addorder(List mylist) {
    myo.add(mylist);
    _price = totalprice;
  }

  double get totalprice {
    return _price;
  }

  double get orderprice {
    return totalprice;
  }

  List get basketitem {
    return items.toSet().toList();
    // return items;
  }
  */

// int get duplicatecount {
//   items.forEach((x) {
//     if (otherNumbers.contains(x)) {
//       repeatedNumbers.add(x);
//     } else {
//       otherNumbers.add(x);
//     }
//   });
//   notifyListeners();

//   return repeatedNumbers.length;
// }

// List get orders {
//   return basketitem;
// }
//}
