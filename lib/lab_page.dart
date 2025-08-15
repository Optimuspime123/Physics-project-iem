import 'package:flutter/material.dart';

class LabPage extends StatelessWidget {
  const LabPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Page"),
      ),
      body: Center(
        child: Text("This so is the Lab page"),
      ),
    );
  }
}