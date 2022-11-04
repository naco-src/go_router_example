import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/go_router/my_go_router.dart';
import 'package:go_router_example/state.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late final AuthState? authState;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthState>(
      future: _getLoginInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        authState = snapshot.data;
        return ChangeNotifierProvider<AuthState?>.value(
          value: authState,
          builder: (context, child) {
            return MaterialApp.router(
              routerConfig: myGoRouter(authState),
              title: 'Flutter Demo',
            );
          },
        );
      },
    );
  }

  Future<AuthState> _getLoginInfo() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final authState = AuthState();
    authState.setAuthStatus(AuthStateEnum.authenticated);
    return authState;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed('pushUsecaseDemoScreen');
                  },
                  child: const Text('push usecases')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/test_pop_util');
                  },
                  child: const Text('Test pop util')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed('QueryParamsUsecaseDemoScreen');
                  },
                  child: const Text('go QueryParamsUsecaseDemoScreen')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/notfound');
                  },
                  child: const Text('Dummy page')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/nested_navigation');
                },
                child: const Text('Nested navigation'),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed('RefreshAndBackToPreviousPageUsecaseDemo');
                  },
                  child: const Text('RefreshAndBackToPreviousPageUsecaseDemo')),
            ],
          ),
        ),
      ),
    );
  }
}
