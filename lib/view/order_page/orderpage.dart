import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_management/controller/firebase_controller/firebase_crud_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference menucollection =
        FirebaseFirestore.instance.collection('menu');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Order Page.",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: menucollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot menu = snapshot.data!.docs[index];
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.purple,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        menu["dish"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        menu["description"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _showDialog(context, menu["dish"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Place Order",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          } else {
            return Text("No DATA found");
          }
        },
      ),
    );
  }
}

void _showDialog(BuildContext context, String dish) {
  FirebaseCrudController firebaseCrudController = FirebaseCrudController();
  TextEditingController qunatity = TextEditingController();
  TextEditingController tableno = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(dish),
        content: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Quantity"),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: qunatity,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Table No."),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: tableno,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),

          ///placing order
          TextButton(
            onPressed: () async {
              await firebaseCrudController.addorder(
                  dish: dish,
                  quantity: int.parse(qunatity.text),
                  tebleno: int.parse(tableno.text));
              Navigator.pop(context);
            },
            child: Text('Order'),
          ),
        ],
      );
    },
  );
}
