
import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!', style: TextStyle(color: Colors.white, fontSize: 40),),
      ),
    );
  }
}