// import 'dart:ffi';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ee_project/admin.dart';
// import 'package:ee_project/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   String enteredUsername = '';
//   String enteredPassword = '';
//   String? maxSoldItem;
//   String? minSoldItem;
//   double totalAmount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     // Future<int> total = calculateTotalAmount();
//     TextEditingController username = TextEditingController();
//     TextEditingController password = TextEditingController();
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/login.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Container(
//             color: Colors.white,
//             height: 300,
//             width: 300,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(20),
//                     child: Text(
//                       'LOGIN',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: 200,
//                       child: TextField(
//                         controller: username,
//                         decoration: InputDecoration(
//                           labelText: 'ENTER USERNAME',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 25),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: 200,
//                       child: TextField(
//                         controller: password,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'ENTER PASSWORD',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 25),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         var tableNumberProvider =
//                             Provider.of<Tablenumberprovider>(context,
//                                 listen: false);
//
//                         // Update the values in the provider class
//                         tableNumberProvider.setMaxSoldItem(maxSoldItem!);
//                         tableNumberProvider.setMinSoldItem(minSoldItem!);
//                         //tableNumberProvider.setta(totalAmount);
//
//                         setState(() {
//                           String enteredUsername = username.text;
//                           String enteredPassword = password.text;
//                           if ('$enteredUsername' == "bharath" &&
//                               '$enteredPassword' == "123") {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Admin()));
//                           } else {
//                             alertmessage("INVALID-DETAIL");
//                           }
//                         });
//                       },
//                       child: Text("LOGIN"),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('bakery')
//                         .orderBy('timestamp')
//                         .snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData) {
//                         return CircularProgressIndicator(); // Return a loading indicator
//                       }
//
//                       var bakeryData = snapshot.data!.docs;
//                       Map<String, int> itemCounts = {};
//
//                       // Find maximum and minimum items and total amount
//                       for (var doc in bakeryData) {
//                         var tableData = doc.data() as Map<String, dynamic>;
//                         double amount =
//                             double.parse(tableData['Total_Amount'] ?? '0.0');
//                         // Add the amount to the total
//
//                         totalAmount += amount;
//
//                         List<dynamic> orderedItems =
//                             tableData['ordereditems'] ?? [];
//
//                         for (var orderedItem in orderedItems) {
//                           String itemName = orderedItem['name'];
//                           int quantity = orderedItem['quantity'] as int? ??
//                               0; // Null check and default value
//                           itemCounts[itemName] =
//                               (itemCounts[itemName] ?? 0) + quantity;
//                         }
//                       }
//
//                       if (itemCounts.isNotEmpty) {
//                         maxSoldItem = itemCounts.entries
//                             .reduce((a, b) => a.value > b.value ? a : b)
//                             .key;
//                         minSoldItem = itemCounts.entries
//                             .reduce((a, b) => a.value < b.value ? a : b)
//                             .key;
//                       } else {
//                         maxSoldItem = null;
//                         minSoldItem = null;
//                       }
//                       return Container();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void alertmessage(String name) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Center(
//           child: Text('$name', style: TextStyle(fontWeight: FontWeight.bold)),
//         ),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }
//
//   // Future<int> calculateTotalAmount() async {
//   //   double amount = 0;
//   //   QuerySnapshot querySnapshot =
//   //       await FirebaseFirestore.instance.collection('bakery').get();
//   //   querySnapshot.docs.forEach((doc) {
//   //     var tableData = doc.data() as Map<String, dynamic>;
//   //     double amount = double.parse(tableData['Total_Amount'] ?? '0.0');
//   //   });
//   //   return amount as int;
//   // }
// }
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/admin.dart';
import 'package:ee_project/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String enteredUsername = '';
  String enteredPassword = '';
  String? maxSoldItem;
  String? minSoldItem;
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            color: Colors.white,
            height: 300,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: 'ENTER USERNAME',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'ENTER PASSWORD',
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var tableNumberProvider =
                            Provider.of<Tablenumberprovider>(context,
                                listen: false);
                        double totalAmount =
                            await _calculateTotalAmountFromFirebase();

                        // Pass the totalAmount to the provider
                        Provider.of<Tablenumberprovider>(context, listen: false)
                            .updateTotalAmount(totalAmount);

                        // Update the values in the provider class
                        tableNumberProvider.setMaxSoldItem(maxSoldItem!);
                        tableNumberProvider.setMinSoldItem(minSoldItem!);
                        // Pass totalAmount to the provider

                        setState(() {
                          String enteredUsername = username.text;
                          String enteredPassword = password.text;
                          if ('$enteredUsername' == "bharath" &&
                              '$enteredPassword' == "12345") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Admin()));
                          } else {
                            alertmessage("INVALID ID ");
                          }
                        });
                      },
                      child: Text("LOGIN"),
                    ),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('bakery')
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); // Return a loading indicator
                      }

                      var bakeryData = snapshot.data!.docs;
                      Map<String, int> itemCounts = {};

                      // Find maximum and minimum items and total amount
                      for (var doc in bakeryData) {
                        var tableData = doc.data() as Map<String, dynamic>;
                        if (tableData.containsKey('Total_Amount') &&
                            tableData['Total_Amount'] is double) {
                          double amount = tableData['Total_Amount'];
                          totalAmount += amount;
                        }

                        List<dynamic> orderedItems =
                            tableData['ordereditems'] ?? [];

                        for (var orderedItem in orderedItems) {
                          String itemName = orderedItem['name'];
                          int quantity = orderedItem['quantity'] as int? ??
                              0; // Null check and default value
                          itemCounts[itemName] =
                              (itemCounts[itemName] ?? 0) + quantity;
                        }
                      }

                      if (itemCounts.isNotEmpty) {
                        maxSoldItem = itemCounts.entries
                            .reduce((a, b) => a.value > b.value ? a : b)
                            .key;
                        minSoldItem = itemCounts.entries
                            .reduce((a, b) => a.value < b.value ? a : b)
                            .key;
                      } else {
                        maxSoldItem = null;
                        minSoldItem = null;
                      }
                      return Text("");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void alertmessage(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text('$name', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<double> _calculateTotalAmountFromFirebase() async {
    double totalAmount = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bakery')
        .where('timestamp', isGreaterThanOrEqualTo: _startOfDay(DateTime.now()))
        .get();
    querySnapshot.docs.forEach((doc) {
      var tableData = doc.data() as Map<String, dynamic>;
      double amount = double.parse(tableData['Total_Amount'] ?? '0.0');
      totalAmount += amount;
    });
    return totalAmount;
  }

// Utility method to get the start of the current day
  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
