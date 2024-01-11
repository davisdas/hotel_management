import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management/view/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDoadhP3XuuQ8tppr_VLZN-CTlCgubFEjQ",
    appId: "1:239455850641:android:5f9bd7b50e5ba1d4306f30",
    messagingSenderId: "",
    projectId: "hotel-management-68758",
    storageBucket: "hotel-management-68758.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Splash());
  }
}
