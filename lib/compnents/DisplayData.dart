import 'package:flutter/material.dart';

mixin class Mydata {
  final Burgers = [
    {
      "id": 1,
      "name": "Big Burg",
      "price": 7.0,
      "ordered": 4,
      "ingredients": ["cheese", "carrots", "onion", "beef"],
      "image": "images/burger.jpg",
    },
    {
      "id": 2,
      "name": "Big Tasty",
      "price": 7.0,
      "ordered": 3,
      "ingredients": ["cheese", "big tasty sauce", "tomato", "beef"],
      "image": "images/burger.jpg",
    },
    {
      "id": 3,
      "name": "Big Mac",
      "price": 7.0,
      "ordered": 3,
      "ingredients": ["cheese", "lettuce", "douple pan", "beef"],
      "image": "images/burger.jpg",
    },
  ];
// طب لو ضيفت list جديدة
// ال id هيمشي ازا هاقولك
  final Ramen = [
    {
      "id": 4,
      "name": "Miso Ramen",
      "price": 9.0,
      "ordered": 5,
      "ingredients": ["Noodles", "Tomato", "egg"],
      "image": "images/ramen.jpg",
    },
    {
      "id": 5,
      "name": "Pesto Ramen",
      "price": 10.0,
      "ordered": 2,
      "ingredients": ["Pesto", "egg", "Noodles"],
      "image": "images/ramen.jpg",
    },
    {
      "id": 6,
      "name": "Chicken Ramen",
      "price": 12.0,
      "ordered": 1,
      "ingredients": ["Chicken", "egg", "Noodles"],
      "image": "images/ramen.jpg",
    },
  ];
  // اي اوجكت لازم يكون ليه id
  // any list ملهاش id
  // ?? لحظه
  //

  var mylist = [];

  final Menunames = [
    "Burgers",
    "Ramen",
    "Sandwiches",
    "Mexican",
    "Japanese",
    "Mediterranean"
  ];
  final Menuimages = [
    "images/burger.jpg",
    "images/ramen.jpg",
    "images/san.jpg",
    "images/taco.png",
    "images/jap.jpeg",
    "images/mid.png"
  ];
}

class getd with ChangeNotifier {
  void getlistin() {}
}
