import 'package:flutter/material.dart';
import 'package:hotel_management/view/login/adminlogin.dart';
import 'package:hotel_management/view/login/cheflogin.dart';
import 'package:hotel_management/view/order_page/orderpage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "KITCHEN MANAGEMENT",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Text(
            "Login AS",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChefLogin(),
                    )),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text("Chef")),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLogin(),
                    )),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text("Admin")),
                  ),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(),
                )),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Place order",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
