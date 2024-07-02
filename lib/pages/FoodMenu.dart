import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:mesa/compnents/DisplayData.dart';
import 'package:mesa/compnents/MenuDisplay.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Menu"),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: MyBadge())
          ]),
      body: ListView(
        children: [
          GridView.builder(
              itemCount: Mydata().Menunames.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MyDisplay(
                          pagetitle: Mydata().Menunames[i],
                        );
                      }));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        Mydata().Menunames[i],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Mydata().Menuimages[i]))),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
