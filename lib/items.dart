// import 'dart:html';

import 'dart:ui';

import 'package:ee_project/cart.dart';
import 'package:ee_project/menu.dart';
import 'package:ee_project/qrpay.dart';
import 'package:ee_project/provider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  Map<String, int> itemCounts = {};
  int c = 0;
  int ans = 0;
  int? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAST FOODS",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => menu()));
          },
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("images/fast.png"),
                width: 1.0 * MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              color: Colors.blue, // Set your desired background color
              height: 50.0, // Set the height of the colored background
              child: Marquee(
                text: "Baked With Love And sale With low",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white, // Set text color if needed
                ),
                blankSpace: 100.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlueAccent, Colors.white],
              )),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            method("KAALAN", "images/kalan.jpg", 30),
                            method("BHEL PURI", "images/bel.jpg", 25),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            method("PANI PURI", "images/pani.jpg", 30),
                            method("GOPI 65", "images/gopi.jpg", 50),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            method("ATHO", "images/65gopi.jpg", 20),
                            method("MEAL MAKER", "images/meal.jpg", 50),
                          ],
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showbottomalert(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  Container method(String name, String image, int rs) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 185,
      width: 150,
      child: Column(
        children: [
          Image.asset(image, width: 180, height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(name)],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rs-\$$rs"),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(10, 35),
                    padding: EdgeInsets.all(4),
                  ),
                  onPressed: () {
                    var tablenumberprovider = Provider.of<Tablenumberprovider>(
                        context,
                        listen: false);
                    tablenumberprovider.addTocart(name, image, rs);
                    _showbottomalert("ADDED TO CART");
                  },
                  child: Text(
                    "ADD CART",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
