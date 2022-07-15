import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar myAppBar(BuildContext context) {
  final goRouter = GoRouter.of(context);

  return AppBar(
    title: Text(goRouter.location),
    actions: [
      ElevatedButton(
          onPressed: () {
            goRouter.pop();
          },
          child: const Text('goRouter.pop'))
    ],
  );
}
