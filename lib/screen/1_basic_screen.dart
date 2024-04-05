import 'package:flutter/cupertino.dart';
import 'package:go_router_v7_practices/layout/default_layout.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: Text('basic screen'),
      ),
    );
  }
}
