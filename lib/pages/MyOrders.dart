import 'package:flutter/material.dart';
import 'package:mesa/compnents/Badge.dart';
import 'package:mesa/compnents/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  CollectionReference noteref = FirebaseFirestore.instance.collection("orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Orders"),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: MyBadge())
          ]),
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
                future: noteref
                    .where("userid",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot
                                              .data?.docs[i]["order"].length,
                                          itemBuilder: (context, i) {
                                            return ListTile(
                                              title: Text(
                                                  "${snapshot.data?.docs[i]["order"][i]['name']}"),
                                              leading: Text(
                                                  "${snapshot.data?.docs[i]["order"][i]['quantity']}"),
                                              trailing: Text("\$" +
                                                  "${snapshot.data?.docs[i]["order"][i]['price']}"),
                                            );
                                          }),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total : \$" +
                                      "${snapshot.data?.docs[i]['price']}"),
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Reorder",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return CircularProgressIndicator(
                    color: Colors.amber,
                  );
                }),
          ],
        ),
      ]),
    );
  }
}
