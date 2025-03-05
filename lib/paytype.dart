import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/menu.dart';
import 'package:ee_project/provider.dart';
import 'package:ee_project/qrpay.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class scan extends StatefulWidget {
  const scan({super.key});

  @override
  State<scan> createState() => _scanState();
}

class _scanState extends State<scan> {
  @override
  Widget build(BuildContext context) {
    String total = Provider.of<Tablenumberprovider>(context).total;
    String table = Provider.of<Tablenumberprovider>(context).tableNumber;
    List<Map<String, dynamic>> orderditems =
        Provider.of<Tablenumberprovider>(context).orderedItems;
    int numberofitems = orderditems.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => menu()));
            },
            color: Colors.white),
        title: Text("TYPE OF PAYMENT", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 10.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SELECT YOUR PAYMENT TYPE",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  "https://lottie.host/57861818-83ba-48e0-8f81-95593fe2d1f2/WmCcuvPn5N.json",
                  height: 200,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pay By Qr Code"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => pay()));
                    },
                    child: Text("Scan Qr"))
              ],
            ),
            SizedBox(height: 4),
            Divider(
              color: Colors.red,
              thickness: 10,
            ),
            // SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(left: 30),
                //   child: Text("1"),
                // ),
                //SizedBox(width: 50),
                Lottie.network(
                  "https://lottie.host/67407505-7bac-4d01-988b-70a1afeddfb9/CXb9Lsfz88.json",
                  height: 150,
                  width: 250,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pay To Cashier"),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => sucess()));
                      var _tableNumberController = TextEditingController();

                      await FirebaseFirestore.instance
                          .collection('bakery')
                          .add({
                        'Total_Amount': total,
                        'Table_no': table,
                        'timestamp': FieldValue.serverTimestamp(),
                        'Pay-Type': 'Cashier',
                        'Number_of_Items': numberofitems,
                        'ordereditems': orderditems,
                      });
                      _showbottomalert("Pay TO Cashier");
                    },
                    child: Text("Move Cashier"))
              ],
            )
          ],
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
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.yellow,
      ),
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => menu()));
    });
  }
}
