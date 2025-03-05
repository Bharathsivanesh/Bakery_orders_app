import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee_project/finalpay.dart';
import 'package:ee_project/paytype.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ee_project/cart.dart';
import 'package:ee_project/provider.dart';

class pay extends StatefulWidget {
  const pay({Key? key}) : super(key: key);

  @override
  State<pay> createState() => _CartState();
}

class _CartState extends State<pay> {
  @override
  Widget build(BuildContext context) {
    String total = Provider.of<Tablenumberprovider>(context).total;
    String table = Provider.of<Tablenumberprovider>(context).tableNumber;
    List<Map<String, dynamic>> orderditems =
        Provider.of<Tablenumberprovider>(context).orderedItems;
    int numberofitems = orderditems.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR-SCANNER", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
        toolbarHeight: 120,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => scan()));
          },
          color: Colors.white,
        ),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(10),
                // bottomRight: Radius.circular(10),
                )),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.red, width: 10),
            left: BorderSide(color: Colors.red, width: 10),
            right: BorderSide(color: Colors.red, width: 10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "QR Codes Make Accepting Payment \nQuick And Easy !!!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: QrImageView(
                    data:
                        // "upi://pay?pa=your-merchant-upi-id@upi&mc=your-merchant-code&tid=your-transaction-id&tr=your-transaction-ref-id&tn=your-transaction-note&am=$total&cu=INR",
                        "upi://pay?pa=bharathsivanesh@oksbi&pn=Bharath%20Sivanesh&mc=your-merchant-code&tid=your-transaction-id&tr=your-transaction-ref-id&tn=your-transaction-note&am=$total&cu=INR",
                    version: QrVersions.auto,
                    size: 300,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "GO -> SCAN -> PAY",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => sucess()));
                    var _tableNumberController = TextEditingController();

                    await FirebaseFirestore.instance.collection('bakery').add({
                      'Total_Amount': total,
                      'Table_no': table,
                      'timestamp': FieldValue.serverTimestamp(),
                      'Pay-Type': 'QR Payed',
                      'Number_of_Items': numberofitems,
                      'ordereditems': orderditems,
                    });
                  },
                  child: Text("Sucess"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
