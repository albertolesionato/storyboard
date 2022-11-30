import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:login/login.dart';

import 'home.dart';

void main() {
  usePathUrlStrategy();

  runApp(const App());
}

final _router = GoRouter(initialLocation: '/login', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return Home(child: child);
      },
      routes: [
        GoRoute(
            name: 'home',
            path: '/:tab(home|settings)',
            pageBuilder: (context, state) {
              final index = state.params['tab'] == 'home' ? 0 : 1;

              return NoTransitionPage(
                  child: IndexedStack(
                index: index,
                children: [HomeScreen(), SettingsScreen()],
              ));
            })
      ]),
  GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: LoginScreen());
      })
]);


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Nav Storyboard',
        theme: ThemeData.light(),
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate);
  }
}
