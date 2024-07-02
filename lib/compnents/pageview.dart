import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late PageController pc;
  @override
  void initState() {
    pc = new PageController(initialPage: 0, viewportFraction: 0.23);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      padEnds: false,
      controller: pc,
      scrollDirection: Axis.horizontal,
      children: [
        Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "images/ramen.jpg",
                ),
              ),
            ),
            Text("Ramen")
          ],
        ),
        Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "images/san.jpg",
                ),
              ),
            ),
            Text("Sandwishes")
          ],
        ),
        Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "images/mid.png",
                ),
              ),
            ),
            FittedBox(child: Text("Mediterranean"))
          ],
        ),
        Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "images/jap.jpeg",
                ),
              ),
            ),
            Text("Japanese")
          ],
        ),
        Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "images/sweet.jpg",
                ),
              ),
            ),
            Text("Sweets")
          ],
        ),
      ],
    );
  }
}

class MyStack extends StatefulWidget {
  const MyStack({Key? key}) : super(key: key);

  @override
  State<MyStack> createState() => _MyStackState();
}

class _MyStackState extends State<MyStack> with TickerProviderStateMixin {
  TabController? tc;
  int tabindex = 1;
  String? text;
  @override
  void initState() {
    tc = new TabController(length: 3, vsync: this, initialIndex: tabindex);
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            child: TabBarView(controller: tc, children: [
              Container(
                child: Center(
                  child: Text(
                    "Mediterranean",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  "images/mid.png",
                ))),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Sandwishes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/san.jpg"))),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Japanese",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/jap.jpeg"))),
              ),
            ]),
          ),
          Positioned(
            bottom: 40,
            child: TabPageSelector(
              indicatorSize: 10,
              color: Colors.grey,
              selectedColor: Colors.white,
              controller: tc,
            ),
          ),
        ],
      ),
    );
  }
}
