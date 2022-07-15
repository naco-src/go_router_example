import 'package:flutter/material.dart';
import 'package:go_router_example/state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context
                  .read<AuthState>()
                  .setAuthStatus(AuthStateEnum.authenticated);
            },
            child: const Text("Login")),
      ),
    );
  }
}
