import 'package:ee_project/menu.dart';
import 'package:ee_project/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _CartState();
}

class _CartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    String table = Provider.of<Tablenumberprovider>(context).tableNumber;
    List<Map<String, dynamic>> orderedItems =
        Provider.of<Tablenumberprovider>(context).orderedItems;
    int totalAmount = 0;
    for (Map<String, dynamic> item in orderedItems) {
      int basePrice = item['price'] ?? 0;
      int quantity = item['quantity'] ?? 1;
      totalAmount += basePrice * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CART PAGE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        menu())); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topRight,
          colors: [Colors.lightBlueAccent, Colors.white],
        )),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.shopping_cart),
                ),
                Text(
                  "SHOPPING CART",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Text("Verify Your Quantity And Click Checkout"),
            SizedBox(height: 20),
            Text("TABLE NO:" + table,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),

            // Food Items Container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.lightBlueAccent, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // List of Food Items
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderedItems.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item = orderedItems[index];
                          int basePrice = item['price'] ?? 0;

                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Food Item Image
                                Image.asset(
                                  item['image'],
                                  width: 50,
                                  height: 50,
                                ),

                                // Food Item details
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item['name']),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            // Decrease quantity logic
                                            setState(() {
                                              if (item['quantity'] != null &&
                                                  item['quantity']! > 0) {
                                                item['quantity'] =
                                                    item['quantity']! - 1;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                            "${item['quantity'] ?? 1}"), // Display current quantity
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            // Increase quantity logic
                                            setState(() {
                                              item['quantity'] =
                                                  (item['quantity'] ?? 1) + 1;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Price
                                Text(
                                  "Rs.${basePrice * (item['quantity'] ?? 1)}",
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      // Remove item logic
                                      setState(() {
                                        orderedItems.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Total Amount: Rs.$totalAmount",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<Tablenumberprovider>(context,
                                      listen: false)
                                  .settotal(totalAmount.toString());
                              _showbottomalert("READY TO PAYMENT");
                            },
                            child: Text("Final CheckOut"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
}
