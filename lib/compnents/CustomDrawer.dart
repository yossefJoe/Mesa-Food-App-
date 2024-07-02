import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mesa/pages/FoodHome.dart';
import 'package:mesa/pages/FoodMenu.dart';
import 'package:mesa/pages/FoodSearch.dart';
import 'package:mesa/pages/MyOrders.dart';
import 'package:mesa/pages/Myreservations.dart';
import 'package:mesa/pages/Welcomepage.dart';
import 'package:mesa/pages/checkout.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FoodHome();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.store),
          title: Text("HOME"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MyMenu();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.menu_open),
          title: Text("MENU"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FoodSearch();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.search),
          title: Text("SEARCH"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Checkout();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.shopping_cart),
          title: Text("CART"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Reservations();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.note_alt),
          title: Text("RESERVATIONS"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Myorders();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.money_outlined),
          title: Text("ORDERS"),
        ),
        ListTile(
          hoverColor: Colors.grey[200],
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WelcomePage();
            }));
          },
          tileColor: Colors.transparent,
          leading: Icon(Icons.logout),
          title: Text("LOG OUT"),
        ),
      ],
    ));
  }
}
