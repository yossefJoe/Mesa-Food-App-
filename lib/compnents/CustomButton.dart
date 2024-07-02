import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback? myf;
  final String? btext;
  final Color? bcolor;
  final BorderSide? bborder;
  final Color? tcolor;
  const MyButton(
      {Key? key, this.myf, this.btext, this.bcolor, this.bborder, this.tcolor})
      : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: MediaQuery.of(context).size.height * 0.075,
      minWidth: MediaQuery.of(context).size.width * 0.8,
      shape: RoundedRectangleBorder(
          side: widget.bborder!, borderRadius: BorderRadius.circular(20)),
      onPressed: widget.myf,
      child: Text(
        "${widget.btext}",
        style: TextStyle(color: widget.tcolor),
      ),
      color: widget.bcolor,
    );
  }
}
