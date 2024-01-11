import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/view/adminview/admin_home/admin_home.dart';
import 'package:hotel_management/view/chefview/chef_home/chefhome.dart';
import 'package:hotel_management/view/register/chefregister.dart';

class ChefLogin extends StatefulWidget {
  const ChefLogin({super.key});

  @override
  State<ChefLogin> createState() => _ChefLoginState();
}

class _ChefLoginState extends State<ChefLogin> {
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
              "CHEF LOGIN",
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
                  hintText: "Username",
                  labelText: "Username"),
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

            InkWell(
              onTap: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text, password: password.text);

                  if (credential.user?.uid != null) {
                    //-----------------------------------------------------------------------------------

                    // Get user data from Firestore
                    DocumentSnapshot userSnapshot = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(credential.user?.uid)
                        .get();

                    if (userSnapshot.exists) {
                      // Extract user data and check the role
                      Map<String, dynamic> userData =
                          userSnapshot.data() as Map<String, dynamic>;

                      if (userData['role'] == 'chef') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChefHome(chef: email.text),
                            ),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("user should be  chef to continue")));
                      }
                    }

                    //---------------------------------------------------------------------------------
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Login",
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
                Text("New user?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChefRegister()));
                    },
                    child: Text("REGISTER "))
              ],
            )
          ],
        ),
      ),
    );
  }
}
