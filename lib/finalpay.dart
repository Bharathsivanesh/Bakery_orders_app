import 'package:ee_project/menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class sucess extends StatefulWidget {
  const sucess({super.key});

  @override
  State<sucess> createState() => _sucessState();
}

class _sucessState extends State<sucess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Text(
          "PAYMENT SUCESSFULL",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => menu()));
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                child: Lottie.network(
                  "https://lottie.host/6f651b32-8602-47e7-a335-1225d25355db/gmKIF4s25D.json",
                ),
                height: 450,
                width: 500),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => menu()));
            },
            child: Text("Back To Main"),
          )
        ],
      ),
    );
  }
}
