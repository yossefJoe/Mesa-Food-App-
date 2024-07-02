import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mesa/compnents/Cart.dart';
import 'package:mesa/pages/FoodHome.dart';
import 'package:mesa/pages/Welcomepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

int mynum = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return MyCart();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Application name
        title: 'Flutter Hello World',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          // useMaterial3: true,
          primarySwatch: Colors.amber,
        ),
        // A widget which will be started on application startup
        home: FirebaseAuth.instance.currentUser != null
            ? FoodHome()
            : WelcomePage(),
      ),
    );
  }
}
