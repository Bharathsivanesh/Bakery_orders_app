import 'dart:async';
import 'dart:typed_data';
// import 'dart:js';
import 'package:ee_project/cart.dart';
import 'package:ee_project/items.dart';
import 'package:ee_project/finalpay.dart';
import 'package:ee_project/login.dart';
import 'package:ee_project/practice.dart';
import 'package:ee_project/paytype.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/menu.dart';
import 'package:ee_project/profit.dart';
import 'package:ee_project/qrpay.dart';
import 'package:ee_project/provider.dart';
import 'package:ee_project/paytype.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
           //replace here your firebase api
  }
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Tablenumberprovider(),
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context as BuildContext).pushReplacement(
        PageTransition(
          //package for pagetransition
          child: Dashboard(),
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Center(
              child: ClipOval(
                child: Image(
                  image: AssetImage('images/img_3.png'),
                  fit: BoxFit.cover,
                  width: 250.0,
                  height: 250.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                "ABC Bakery",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Baked With Love And Care",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController _tableNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/img_2.png'),
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 30),
                Text(
                  "Enter The Table No ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'DancingScript-VariableFont'),
                ),
                SizedBox(height: 20),
                Container(
                  width: 150,
                  child: TextField(
                    controller: _tableNumberController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Table Number',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    String enteredTableNumber = _tableNumberController.text;
                    Provider.of<Tablenumberprovider>(context, listen: false)
                        .settablenumber(enteredTableNumber);
                    if (enteredTableNumber.isEmpty) {
                      _showbottomalert("ENTER TABLE NUMBER");
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => menu(),
                        ),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showbottomalert(String name) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
