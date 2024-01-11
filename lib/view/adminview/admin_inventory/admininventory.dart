import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_management/controller/firebase_controller/firebase_crud_controller.dart';

class AdminInventory extends StatefulWidget {
  const AdminInventory({super.key});

  @override
  State<AdminInventory> createState() => _AdminInventoryState();
}

class _AdminInventoryState extends State<AdminInventory> {
  FirebaseCrudController firebaseCrudController = FirebaseCrudController();
  TextEditingController item = TextEditingController();
  TextEditingController quantity = TextEditingController();
  CollectionReference inventorycollection =
      FirebaseFirestore.instance.collection('inventory');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          "Inventory",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: inventorycollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot inventory = snapshot.data!.docs[index];
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    inventory['item'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quntity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    inventory['quantity'].toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        firebaseCrudController.deleteitem(
                                            docId: inventory.id);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Edit Item",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .purple),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                            controller: item,
                                                            decoration:
                                                                const InputDecoration(
                                                              label:
                                                                  Text("Item"),
                                                              border:
                                                                  OutlineInputBorder(),
                                                            )),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          controller: quantity,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "Quantity"),
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          await firebaseCrudController
                                                              .edititem(
                                                                  docId:
                                                                      inventory
                                                                          .id,
                                                                  updateditem:
                                                                      item.text,
                                                                  updatedquantity:
                                                                      int.parse(
                                                                          quantity
                                                                              .text));
                                                          Navigator.pop(
                                                              context);
                                                          item.clear();
                                                          quantity.clear();
                                                        },
                                                        child: const Text(
                                                          "Save",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .purple),
                                                        ))
                                                  ],
                                                ));
                                      },
                                      icon: const Icon(Icons.edit))
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                });
          } else {
            return const Text("No DATA found");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Edit Menu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: item,
                              decoration: const InputDecoration(
                                label: Text("Item"),
                                border: OutlineInputBorder(),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: quantity,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              label: Text("Quantity"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await firebaseCrudController.additem(
                                item: item.text, quantity: quantity.text);
                            Navigator.pop(context);
                            item.clear();
                            quantity.clear();
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple),
                          ))
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
