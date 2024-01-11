import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_management/view/login/cheflogin.dart';

class ChefRegister extends StatefulWidget {
  const ChefRegister({super.key});

  @override
  State<ChefRegister> createState() => _ChefRegisterState();
}

class _ChefRegisterState extends State<ChefRegister> {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CHEF REGISTER",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),

            // Username
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  hintText: "Email",
                  labelText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),

            //  password
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  hintText: "Password",
                  labelText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),

            // login button
// vSz2fvij7CQmbJkZNjT0vGcoa4v2
            InkWell(
              onTap: () async {
                try {
                  print(email.text);
                  print(password.text);
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  usercollection
                      .doc(credential.user?.uid)
                      .set({"user": email.text, "role": "chef"});

                  print(credential.user?.uid);

                  if (credential.user?.uid != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChefLogin(),
                        ));
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),

            //new user text
            Row(
              children: [
                Text("alredy have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("LOGIN"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
