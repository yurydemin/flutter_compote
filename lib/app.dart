import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/main_bloc.dart';
import 'package:flutter_compote/blocs/auth_bloc.dart';
import 'package:flutter_compote/screens/auth_view.dart';
import 'package:flutter_compote/screens/home_view.dart';
import 'package:provider/provider.dart';

final authBloc = AuthBloc();
final mainBloc = MainBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => authBloc),
          Provider(create: (context) => mainBloc),
        ],
        child: MaterialApp(
          home: AuthView(),
          onGenerateRoute: Routes.materialRoutes,
        ));
  }

  @override
  void dispose() {
    authBloc.dispose();
    mainBloc.dispose();
    super.dispose();
  }
}

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/auth":
        return MaterialPageRoute(builder: (context) => AuthView());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomeView());
      default:
        return MaterialPageRoute(builder: (context) => AuthView());
    }
  }
}
