import 'package:flutter/material.dart';

class NestedChildScreen extends StatelessWidget {
  final String routerName;

  const NestedChildScreen({
    required this.routerName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(routerName),
    );
  }
}
