import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/controller/firebase_controller/firebase_crud_controller.dart';
import 'package:hotel_management/view/adminview/admin_inventory/admininventory.dart';
import 'package:hotel_management/view/adminview/admin_menu/adminmenu.dart';
import 'package:hotel_management/view/adminview/adnin_pdf/adminpdf.dart';
import 'package:hotel_management/view/login/cheflogin.dart';
import 'package:hotel_management/view/splash/splash.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Menu
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminMenu(),
                          )),
                      child: Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "Menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),

                  // Inventory
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminInventory(),
                          )),
                      child: Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "Inventory",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              // orders
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Orders",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminPdf(),
                            ));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              "Save PDF",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                    child: StreamBuilder(
                  stream: ordercollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot orders =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tileColor: Colors.purple,
                                leading: CircleAvatar(
                                  child: Text(orders['tebleno'].toString()),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      orders['dish'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "(${orders['quantity']})",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(orders['process']),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    const Text(
                                      "assigned",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (orders['chef'] == "Not assigned") {
                                          return _showDialog(
                                              context, orders.id);
                                        }
                                      },
                                      child: Text(
                                        orders['chef'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text("No DATA found");
                    }
                  },
                )),
              )
            ],
          ),
        ));
  }
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    print("User logged out successfully");
  } catch (e) {
    print("Error logging out: $e");
  }
}

CollectionReference chefcollection =
    FirebaseFirestore.instance.collection('users');
CollectionReference ordercollection =
    FirebaseFirestore.instance.collection('orders');
FirebaseCrudController firebaseCrudController = FirebaseCrudController();

void _showDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Chef List"),
        content: Container(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
            stream: chefcollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: SizedBox(
                    width: 100,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot chef = snapshot.data!.docs[index];
                        if (chef["role"] == "chef") {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    chef["user"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () =>
                                          firebaseCrudController.assignorder(
                                              docId: id, chef: chef['user']),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Assign",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              } else {
                return const Text("No DATA found");
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
