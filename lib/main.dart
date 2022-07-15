import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/error_screen.dart';
import 'package:go_router_example/login_screen.dart';
import 'package:go_router_example/state.dart';
import 'package:go_router_example/test_pop_util.dart';
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
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              title: 'Flutter Demo',
            );
          },
        );
      },
    );
  }

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const MyHomePage(),
      ),
      GoRoute(
        name: 'test_pop_util',
        path: '/test_pop_util',
        builder: (context, state) => const TestPopUtil(),
      ),
      GoRoute(
        name: "page2",
        path: '/page2',
        builder: (context, state) => const SecondPage(),
      ),
      GoRoute(
        path: '/page3',
        builder: (context, state) => const ThirdPage(),
      ),
      GoRoute(
        path: '/page4',
        builder: (context, state) => const Page4(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: authState,
    redirect: (state) {
      final loggedIn = authState?.stateEnum == AuthStateEnum.authenticated;
      final loggingIn = state.subloc == '/login';

      final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
      if (!loggedIn) return loggingIn ? null : '/login$fromp';
      if (loggingIn) return state.queryParams['from'] ?? '/';
      return null;
    },
  );

  Future<AuthState> _getLoginInfo() async {
    await Future.delayed(
      const Duration(seconds: 3),
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
                  onPressed: () {},
                  child:
                      const Text('navigate to  push usecases examples screen')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/test_pop_util');
                  },
                  child: const Text('Test pop util')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/notfound');
                  },
                  child: const Text('Error handling')),
            ],
          ),
        ),
      ),
    );
  }
}
