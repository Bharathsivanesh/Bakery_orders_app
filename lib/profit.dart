import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/admin.dart';
import 'package:ee_project/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class profit extends StatefulWidget {
  const profit({Key? key});

  @override
  State<profit> createState() => _ProfitState();
}

class _ProfitState extends State<profit> {
  Map<String, int> itemCounts = {};
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFIT-PAGE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Admin()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ONE MONTH DETAILS",
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
                    '${_getCurrentDate()} TO ${_getDateAfterOneWeek()}',
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
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  var bakeryData = snapshot.data!.docs;

                  return Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: bakeryData.map((doc) {
                      var tableData = doc.data() as Map<String, dynamic>;
                      DateTime? timestamp =
                          (tableData['timestamp'] as Timestamp?)?.toDate();
                      String? date = timestamp != null
                          ? DateFormat('dd-MM-yyyy/hh-mm-ss').format(timestamp)
                          : null;

                      // Only display if date is not null
                      if (date != null) {
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
                                  '$date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text('Table No: ${tableData['Table_no']}'),
                              Text(
                                  'Total Amount: ${tableData['Total_Amount']}'),
                              Text('Pay Type: ${tableData['Pay-Type']}'),
                              Text('Ordered Items:'),
                              for (var orderedItem
                                  in tableData['ordereditems'] ?? [])
                                Text(
                                    '${orderedItem['name']} - ${orderedItem['quantity'] ?? 1}'),
                            ],
                          ),
                        );
                      } else {
                        // If date is null, return an empty container
                        return Container();
                      }
                    }).toList(),
                  );
                },
              ),
              Divider(height: 15, color: Colors.red),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SELL DETAILS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          'HIGHEST SOLD : "${Provider.of<Tablenumberprovider>(context).maxSoldItem.toUpperCase()} "',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          'LOWEST SOLD: "${Provider.of<Tablenumberprovider>(context).minSoldItem}"',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOTAL AMOUNT = ${Provider.of<Tablenumberprovider>(context).ta}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCurrentDate() {
    DateTime specificDate = DateTime.parse('2024-01-25');
    return DateFormat('dd-MM-yyyy').format(specificDate);
  }

  String _getDateAfterOneWeek() {
    var now = DateTime.now();
    var oneWeekLater = now.add(Duration(days: 20));
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(oneWeekLater);
  }
}
