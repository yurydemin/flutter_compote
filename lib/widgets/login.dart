import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/auth_bloc.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  StreamSubscription _userChangedSubscription;
  StreamSubscription _errorMessageSubscription;

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    _userChangedSubscription = authBloc.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/home');
    });
    _errorMessageSubscription = authBloc.errorMessage.listen((message) {
      if (message.isNotEmpty) print(message);
    });
    super.initState();
  }

  @override
  void dispose() {
    _userChangedSubscription.cancel();
    _errorMessageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StreamBuilder<String>(
            stream: authBloc.loginUserLogin,
            builder: (context, snapshot) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Логин',
                ),
                keyboardType: TextInputType.text,
                onChanged: authBloc.changeLoginUserLogin,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.loginPassword,
            builder: (context, snapshot) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Пароль',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: authBloc.changeLoginPassword,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isLoginValid,
            builder: (context, snapshot) {
              return FlatButton(
                onPressed: (snapshot.data == true ? authBloc.login : null),
                child: Text('Вход'),
                color: Colors.grey,
              );
            }),
      ],
    );
  }
}
