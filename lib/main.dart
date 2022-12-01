import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sign_in/sign_in.dart';
import 'package:user_repository/user_repository.dart';

import 'home.dart';

void main() {
  usePathUrlStrategy();

  runApp(const App());
}

final _router = GoRouter(initialLocation: '/home', routes: [
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
      name: 'sign-in',
      path: '/sign-in',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: SignInScreen(
            onSignInSuccess: () {},
            userRepository: UserRepository(),
          ),
        );
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
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          SignInLocalizations.delegate
        ],
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate);
  }
}
