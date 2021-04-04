import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/auth_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
            stream: authBloc.registrationUserLogin,
            builder: (context, snapshot) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Логин',
                ),
                keyboardType: TextInputType.text,
                onChanged: authBloc.changeRegistrationUserLogin,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.registrationPassword,
            builder: (context, snapshot) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Пароль',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: authBloc.changeRegistrationPassword,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.registrationUserName,
            builder: (context, snapshot) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Имя',
                ),
                keyboardType: TextInputType.text,
                onChanged: authBloc.changeRegistrationUserName,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isRegistrationValid,
            builder: (context, snapshot) {
              return FlatButton(
                onPressed: (snapshot.data == true ? authBloc.register : null),
                child: Text('Зарегистрироваться'),
                color: Colors.grey,
              );
            }),
      ],
    );
  }
}
