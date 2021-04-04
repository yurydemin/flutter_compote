import 'dart:async';
import 'dart:convert';
import 'package:flutter_compote/models/app_user.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final _registrationUserName = BehaviorSubject<String>();
  final _registrationUserLogin = BehaviorSubject<String>();
  final _registrationPassword = BehaviorSubject<String>();

  final _loginUserLogin = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  final _user = BehaviorSubject<AppUser>();
  final _errorMessage = BehaviorSubject<String>();

  // registration
  Stream<String> get registrationUserName =>
      _registrationUserName.stream.transform(validateUserName);
  Stream<String> get registrationUserLogin =>
      _registrationUserLogin.stream.transform(validateUserLogin);
  Stream<String> get registrationPassword =>
      _registrationPassword.stream.transform(validatePassword);
  Stream<bool> get isRegistrationValid => CombineLatestStream.combine3(
      registrationUserName,
      registrationUserLogin,
      registrationPassword,
      (name, login, password) => true);
  // login
  Stream<String> get loginUserLogin =>
      _loginUserLogin.stream.transform(validateUserLogin);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(validatePassword);
  Stream<bool> get isLoginValid => CombineLatestStream.combine2(
      _loginUserLogin, _loginPassword, (login, password) => true);

  Stream<AppUser> get user => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;

  // Setters
  Function(String) get changeRegistrationUserName =>
      _registrationUserName.sink.add;
  Function(String) get changeRegistrationUserLogin =>
      _registrationUserLogin.sink.add;
  Function(String) get changeRegistrationPassword =>
      _registrationPassword.sink.add;

  Function(String) get changeLoginUserLogin => _loginUserLogin.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  dispose() {
    _registrationUserName.close();
    _registrationUserLogin.close();
    _registrationPassword.close();

    _loginUserLogin.close();
    _loginPassword.close();

    _user.close();
    _errorMessage.close();
  }

  // Validators
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length > 0) {
      sink.add(userName.trim());
    } else {
      sink.addError('User name can\'t be empty');
    }
  });

  final validateUserLogin = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length > 0) {
      sink.add(userName.trim());
    } else {
      sink.addError('Login can\'t be empty');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 0) {
      sink.add(password.trim());
    } else {
      sink.addError('Password can\'t be empty');
    }
  });

  // Functions
  register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString(_registrationUserLogin.value);
    if (userJson != null) {
      _errorMessage.sink.add('User already exists');
    } else {
      var user = AppUser(
          login: _registrationUserLogin.value,
          password: _registrationPassword.value,
          name: _registrationUserName.value,
          registrationDate:
              DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()));
      prefs.setString(_registrationUserLogin.value, json.encode(user.toJson()));
      _user.sink.add(user);
    }
  }

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString(_loginUserLogin.value);
    if (userJson != null) {
      var user = AppUser.fromJson(json.decode(userJson));
      if (user.password == _loginPassword.value)
        _user.sink.add(user);
      else
        _errorMessage.sink.add('Incorret password');
    } else {
      _errorMessage.sink.add('User doesn\'t exist');
    }
  }

  logout() async {
    _user.sink.add(null);
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }
}
