//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ee_project/menu.dart';
// import 'package:ee_project/profit.dart';
// import 'package:ee_project/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class Admin extends StatefulWidget {
//   const Admin({Key? key}) : super(key: key);
//
//   @override
//   State<Admin> createState() => _AdminState();
// }
//
// class _AdminState extends State<Admin> {
//   double totalAmount = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "ADMIN-PANEL",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.red,
//         toolbarHeight: 100,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: 50,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => menu()),
//             );
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "ITEMS DETAILS OF TODAY ORDER",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'DATE: ${_getCurrentDate()}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('bakery')
//                     .orderBy('timestamp')
//                     .where('timestamp',
//                         isGreaterThanOrEqualTo: _startOfDay(DateTime.now()))
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return CircularProgressIndicator();
//                   }
//
//                   var bakeryData = snapshot.data!.docs;
//                   Provider.of<Tablenumberprovider>(context, listen: false)
//                       .resetTotalAmount();
//                   // Calculate totalAmount only when fetching data
//                   totalAmount = 0;
//
//                   return Wrap(
//                     spacing: 16.0,
//                     runSpacing: 16.0,
//                     children: bakeryData.map((doc) {
//                       var tableData = doc.data() as Map<String, dynamic>;
//
//                       DateTime timestamp =
//                           (tableData['timestamp'] as Timestamp).toDate();
//                       String Date =
//                           DateFormat('dd-MM-yyyy/hh-mm-ss').format(timestamp);
//                       double amount =
//                           double.parse(tableData['Total_Amount'] ?? '0.0');
//                       Provider.of<Tablenumberprovider>(context, listen: false)
//                           .updateTotalAmount(amount);
//
//                       return Container(
//                         width: MediaQuery.of(context).size.width / 2 - 16,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 4,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 '$Date',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Text('Table No: ${tableData['Table_no']}'),
//                             Text('Total Amount: ${tableData['Total_Amount']}'),
//                             Text('Pay Type: ${tableData['Pay-Type']}'),
//                             Text('Ordered Items:'),
//                             for (var orderedItem
//                                 in tableData['ordereditems'] ?? [])
//                               Text(
//                                 '${orderedItem['name']} - ${orderedItem['quantity'] ?? 1}',
//                               ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Total Amount:  ${Provider.of<Tablenumberprovider>(context).totalAmount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.redAccent,
//         selectedItemColor: Colors.lightBlueAccent,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assessment),
//             label: 'ORDERS',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.monetization_on),
//             label: 'PROFIT',
//           ),
//         ],
//         onTap: (Index) {
//           setState(() {
//             switch (Index) {
//               case 1:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => profit()),
//                 );
//             }
//           });
//         },
//       ),
//     );
//   }
//
//   String _getCurrentDate() {
//     DateTime now = DateTime.now();
//     String formattedDate =
//         "${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)}";
//     return formattedDate;
//   }
//
//   String _addLeadingZero(int number) {
//     return number.toString().padLeft(2, '0');
//   }
//
//   DateTime _startOfDay(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/cart.dart';
import 'package:ee_project/menu.dart';
import 'package:ee_project/profit.dart';
import 'package:ee_project/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADMIN-PANEL",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.red,
        toolbarHeight: 100,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 50,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => menu()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ITEMS DETAILS OF TODAY ORDER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DATE: ${_getCurrentDate()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bakery')
                    .orderBy('timestamp')
                    .where('timestamp',
                        isGreaterThanOrEqualTo: _startOfDay(DateTime.now()))
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  var bakeryData = snapshot.data!.docs;

                  // Calculate totalAmount only when fetching data
                  totalAmount = 0;

                  return Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: bakeryData.map((doc) {
                      var tableData = doc.data() as Map<String, dynamic>;

                      DateTime timestamp =
                          (tableData['timestamp'] as Timestamp).toDate();
                      String Date =
                          DateFormat('dd-MM-yyyy/hh-mm-ss').format(timestamp);
                      // double amount =
                      //     double.parse(tableData['Total_Amount'] ?? '0.0');
                      // Provider.of<Tablenumberprovider>(context, listen: false)
                      //     .updateTotalAmount(amount);

                      return Container(
                        width: MediaQuery.of(context).size.width / 2 - 16,
                        height: 200,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                '$Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('Table No: ${tableData['Table_no']}'),
                            Text('Total Amount: ${tableData['Total_Amount']}'),
                            Text('Pay Type: ${tableData['Pay-Type']}'),
                            Text('Ordered Items:'),
                            for (var orderedItem
                                in tableData['ordereditems'] ?? [])
                              Text(
                                '${orderedItem['name']} - ${orderedItem['quantity'] ?? 1}',
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Total Amount:  ${Provider.of<Tablenumberprovider>(context).totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        selectedItemColor: Colors.lightBlueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'ORDERS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'PROFIT',
          ),
        ],
        onTap: (int index) async {
          try {
            if (index == 1) {
              // Call function to calculate total amount from Firebase
              await _calculateTotalAmountFromFirebase();

              // Navigate to the profit page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profit()),
              );
            }
          } catch (e) {
            print("Navigation Error: $e");
          }
        },
      ),
    );
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)}";
    return formattedDate;
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _calculateTotalAmountFromFirebase() async {
    double totalAmountFromFirebase = 0;
    final snapshot =
        await FirebaseFirestore.instance.collection('bakery').get();
    final docs = snapshot.docs;

    for (var doc in docs) {
      final tableData = doc.data();
      // double amount = double.parse(tableData['Total_Amount'] ?? '0.0');
      double amount =
          double.tryParse(tableData['Total_Amount'] ?? '0.0') ?? 0.0;

      totalAmountFromFirebase += amount;
    }

    Provider.of<Tablenumberprovider>(context, listen: false)
        .setta(totalAmountFromFirebase);
  }
}
