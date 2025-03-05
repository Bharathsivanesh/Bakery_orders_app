import 'dart:math';

import 'package:ee_project/about.dart';
import 'package:ee_project/admin.dart';
import 'package:ee_project/cakes.dart';
import 'package:ee_project/drink.dart';
import 'package:ee_project/finalpay.dart';
import 'package:ee_project/fried.dart';
import 'package:ee_project/junk.dart';
import 'package:ee_project/login.dart';
import 'package:ee_project/main.dart';
import 'package:ee_project/puffs.dart';
import 'package:ee_project/paytype.dart';
import 'package:flutter/material.dart';
import 'package:ee_project/qrpay.dart';
import 'package:ee_project/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'items.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class menu extends StatelessWidget {
  const menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: page(),
    );
  }
}

class page extends StatefulWidget {
  const page({Key? key}) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          "MENU LIST",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => cart()));
            },
          )
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 40.0,
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme:
                IconThemeData(color: Colors.yellow), // Set the icon color
          ),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('ABC Bakery'),
                accountEmail: Text('ABC@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/logo.jpg'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box_outlined,
                ),
                title: Text('ABOUT'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage())),
              ),
              ListTile(
                leading: Icon(
                  Icons.directions,
                ),
                title: Text('Direction'),
                onTap: () {
                  _launchMaps();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_back,
                ),
                title: Text('Back'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => menu())),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app_outlined,
                ),
                title: Text('Exit'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Splash())),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.white], // Adjust colors as needed
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    // Replace these placeholders with your actual images
                    Image.asset('images/cas1.jpg', fit: BoxFit.cover),
                    Image.asset('images/cas2.jpg', fit: BoxFit.cover),
                    Image.asset('images/cas3.jpg', fit: BoxFit.cover),
                  ],
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.linear,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    viewportFraction: 2.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(10.0),

                ///here left(17)
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SELECT CATEGEORY",
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chat()));
                          },
                          child: function('images/chat.png', "Chats"),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => drink()));
                          },
                          child: function('images/jui.png', "Beverage"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cake()));
                          },
                          child: function('images/cak.png', "Cakes"),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => fried()));
                          },
                          child: function('images/ric.png', "Deep Fried"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => puff()));
                          },
                          child: function('images/mainpuf.jpg', "Puffs Item"),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => junk()));
                          },
                          child: function('images/sna.png', "Junk Food"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.admin_panel_settings),
          //   label: 'Admin',
          // ),
        ],
        onTap: (index) {
          setState(() {
            switch (index) {
              case 1:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => scan()));
                break;
              case 2:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
                break;

              // first pass table value to cart (this only required)
            }
          });
        },
      ),
    );
  }

  Container function(String image, String name) {
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
      height: 140,
      width: 150,
      child: Column(
        children: [
          Image.asset(image, height: 100, width: 180),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Text("$name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }

  void _launchMaps() async {
    // Replace latitude and longitude with your bakery's location
    final latitude = 37.7749;
    final longitude = -122.4194;
    final url = 'https://maps.app.goo.gl/aSkAHFMVPGbSULQJ6';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
