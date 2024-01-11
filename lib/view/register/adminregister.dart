import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/view/login/adminlogin.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool isloading = false;
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
              "Admin REGISTER",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),

            // Username
            TextFormField(
              controller: usernamecontroller,
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
              controller: passwordcontroller,
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

            isloading
                ? CircularProgressIndicator()
                : InkWell(
                    onTap: () async {
                      isloading = true;
                      setState(() {});
                      try {
                        print(usernamecontroller.text);
                        print(passwordcontroller.text);
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: usernamecontroller.text,
                          password: passwordcontroller.text,
                        );
                        usercollection.doc(credential.user?.uid).set(
                            {"user": usernamecontroller.text, "role": "admin"});
                        print(credential.user?.uid);

                        if (credential.user?.uid != null) {
                          isloading = false;
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminLogin(),
                              ));
                        } else {
                          isloading = false;
                          setState(() {});
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                        isloading = false;
                        setState(() {});
                      } catch (e) {
                        isloading = false;
                        setState(() {});
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
