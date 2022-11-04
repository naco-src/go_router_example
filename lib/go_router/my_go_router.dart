import 'package:go_router/go_router.dart';
import 'package:go_router_example/error_screen.dart';
import 'package:go_router_example/go_router/my_go_router_routes.dart';
import 'package:go_router_example/state.dart';

//RouteName: FeatureName+Route
GoRouter myGoRouter(AuthState? authState) => GoRouter(
      debugLogDiagnostics: true,
      routes: myGoRouterRoutes,
      errorBuilder: (context, state) => const ErrorScreen(),
      refreshListenable: authState,
      redirect: (context, state) {
        final loggedIn = authState?.stateEnum == AuthStateEnum.authenticated;
        final loggingIn = state.subloc == '/login';

        final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
        if (!loggedIn) return loggingIn ? null : '/login$fromp';
        if (loggingIn) return state.queryParams['from'] ?? '/';
        return null;
      },
    );
