import 'package:fengwuxp_openfeign_example/src/views/demo_simple_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dart feign example',
      home: DemoSimpleView(),
    );
  }
}
