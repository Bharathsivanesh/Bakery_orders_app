// import 'package:ee_project/menu.dart';
// import 'package:flutter/material.dart';
//
// class about extends StatefulWidget {
//   const about({super.key});
//
//   @override
//   State<about> createState() => _aboutState();
// }
//
// class _aboutState extends State<about> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "ABOUT",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_outlined),
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => menu()));
//           },
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.lightBlueAccent,
//
//       ),
//       body: ,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ee_project/menu.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ABOUT",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => menu()));
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/img_10.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome to our bakery ordering app! At ABC Bakery , we're passionate about bringing you the freshest and most delicious baked goods right to your doorstep. Our app is designed to make your ordering experience seamless and enjoyable. ",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Contact Details:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Email: abc@example.com",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Phone: +1234567890",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Address: 123 Main Street, City, Country",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            Text(
              "Thank You!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
