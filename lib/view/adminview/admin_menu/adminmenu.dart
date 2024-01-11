import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/controller/firebase_controller/firebase_crud_controller.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  FirebaseCrudController firebaseCrudController = FirebaseCrudController();
  TextEditingController dish = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController editdish = TextEditingController();
  TextEditingController editdescription = TextEditingController();
  CollectionReference menucollection =
      FirebaseFirestore.instance.collection('menu');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Menu",
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        firebaseCrudController.deleteData(
                                            docId: menu.id);
                                      },
                                      icon: Icon(Icons.delete)),
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
                                                          "Edit Menu",
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
                                                            controller:
                                                                editdish,
                                                            decoration:
                                                                const InputDecoration(
                                                              label:
                                                                  Text("Dish"),
                                                              border:
                                                                  OutlineInputBorder(),
                                                            )),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              editdescription,
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "Description"),
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
                                                              .editData(
                                                                  docId:
                                                                      menu.id,
                                                                  updatedDish:
                                                                      editdish
                                                                          .text,
                                                                  updateddescription:
                                                                      editdescription
                                                                          .text);
                                                          Navigator.pop(
                                                              context);
                                                          dish.clear();
                                                          description.clear();
                                                        },
                                                        child: const Text(
                                                          "Edit",
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
            return Text("No DATA found");
          }
        },
      ),

      // ////add to menu
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
                          Text(
                            "Add New Menu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: dish,
                              decoration: InputDecoration(
                                label: Text("Dish"),
                                border: OutlineInputBorder(),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: description,
                            decoration: InputDecoration(
                              label: Text("Description"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await firebaseCrudController.addData(
                              dish: dish.text,
                              description: description.text,
                            );
                            Navigator.pop(context);
                            dish.clear();
                            description.clear();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple),
                          ))
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
