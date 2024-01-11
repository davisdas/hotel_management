import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/view/splash/splash.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({super.key, required this.chef});
  final String chef;
  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome> {
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          "Welcome Admin",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Splash(),
                    ),
                    (route) => false);
              },
              child: const Text(
                "Logout",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
      body: StreamBuilder(
        stream: ordercollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot orders = snapshot.data!.docs[index];
                  if (orders["chef"] == widget.chef) {
                    return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    orders["dish"].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    orders['process'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            )));
                  }
                });
          } else {
            return const Text("No DATA found");
          }
        },
      ),
    );
  }
}
