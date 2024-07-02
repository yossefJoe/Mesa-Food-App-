import 'package:flutter/material.dart';

class FoodTextfield extends StatefulWidget {
  final String? hint;
  final Function(String)? onchange;
  final String? Function(String?)? validator;
  const FoodTextfield({Key? key, this.hint, this.onchange, this.validator})
      : super(key: key);

  @override
  State<FoodTextfield> createState() => _FoodTextfieldState();
}

class _FoodTextfieldState extends State<FoodTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onchange,
      validator: widget.validator,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: widget.hint),
    );
  }
}
