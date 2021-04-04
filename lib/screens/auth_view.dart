import 'package:flutter/material.dart';
import 'package:flutter_compote/widgets/login.dart';
import 'package:flutter_compote/widgets/registration.dart';

enum FormType { login, registration }

class AuthView extends StatefulWidget {
  AuthView({Key key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  FormType _formType = FormType.login;

  _switchForm() {
    setState(() {
      _formType =
          _formType == FormType.login ? FormType.registration : FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _formType == FormType.login ? 'Вход' : 'Регистрация',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      _formType == FormType.login
                          ? LoginForm()
                          : RegistrationForm(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formType == FormType.registration
                          ? 'Уже есть аккаунт?'
                          : 'Еще нет аккаунта? ',
                    ),
                    FlatButton(
                      key: Key('fieldChangeForm'),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: _formType == FormType.registration
                                ? 'Войти'
                                : 'Регистрация',
                          )
                        ], style: Theme.of(context).textTheme.bodyText1),
                      ),
                      onPressed: _switchForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
