import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCrudController {
  ////////menu
  CollectionReference menucollection =
      FirebaseFirestore.instance.collection('menu');
  // add
  addData({required String dish, required String description}) async {
    menucollection.add({"dish": dish, "description": description});
  }

  // // edit

  editData(
      {required String docId,
      required String updatedDish,
      required String updateddescription}) {
    menucollection
        .doc(docId)
        .update({"dish": updatedDish, "description": updateddescription});
  }

  // delete

  deleteData({required String docId}) {
    menucollection.doc(docId).delete();
  }

  /////////order
  CollectionReference ordercollection =
      FirebaseFirestore.instance.collection('orders');

  //addorder
  addorder({
    required String dish,
    required int quantity,
    required int tebleno,
  }) async {
    ordercollection.add({
      "dish": dish,
      "quantity": quantity,
      "tebleno": tebleno,
      "process": "pending",
      "chef": "Not assigned"
    });
  }

  CollectionReference inventorycollection =
      FirebaseFirestore.instance.collection('inventory');
  additem({
    required String item,
    required String quantity,
  }) {
    inventorycollection.add({
      "item": item,
      "quantity": quantity,
    });
  }

  deleteitem({required String docId}) {
    inventorycollection.doc(docId).delete();
  }

  edititem(
      {required String docId,
      required String updateditem,
      required int updatedquantity}) {
    inventorycollection
        .doc(docId)
        .update({"item": updateditem, "quantity": updatedquantity});
  }
  // /assign order

  assignorder({required String docId, required String chef}) {
    ordercollection.doc(docId).update({"chef": chef});
  }
}
