import 'package:flutter/material.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/pages/checkout.dart';
import 'package:provider/provider.dart';

class MyBadge extends StatefulWidget {
  const MyBadge({Key? key}) : super(key: key);

  @override
  State<MyBadge> createState() => _MyBadgeState();
}

//هو دي اي فين الديزين
//دي ال badge اللى بيظهر عليها ال count
//اه وصلت
//العداد مش شغال
class _MyBadgeState extends State<MyBadge> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCart>(
      builder: (context, cart, child) {
        return Badge(
          isLabelVisible: cart.products.length == 0 ? false : true,
          label: Text("${cart.products.length}"),
          child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Checkout();
                }));
              },
              icon: Icon(Icons.shopping_cart)),
        );
      },
    );
  }
}
