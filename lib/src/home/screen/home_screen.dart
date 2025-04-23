import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text('Home')),
      body: Placeholder(),
    );
  }
}
