import 'package:flutter/material.dart';

class CompletedTab extends StatefulWidget {
  const new({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed", style: TextStyle(color: Colors.white)),
    );
  }
}
