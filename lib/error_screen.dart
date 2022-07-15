import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This page isn\'t available'),
        backgroundColor: Colors.red,
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          context.go('/');
        },
        child: const Text('Back to home'),
      )),
    );
  }
}
