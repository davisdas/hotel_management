import 'package:flutter/material.dart';

class AdminPdf extends StatefulWidget {
  const AdminPdf({super.key});

  @override
  State<AdminPdf> createState() => _AdminPdfState();
}

class _AdminPdfState extends State<AdminPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Order PDF",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
