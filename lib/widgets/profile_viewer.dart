import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/auth_bloc.dart';
import 'package:flutter_compote/blocs/main_bloc.dart';
import 'package:flutter_compote/models/app_user.dart';
import 'package:flutter_compote/widgets/counter_viewer.dart';
import 'package:provider/provider.dart';

class ProfileViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    final mainBloc = Provider.of<MainBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<AppUser>(
                stream: authBloc.user,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData
                      ? 'name: ${snapshot.data.name}\ndate: ${snapshot.data.registrationDate}'
                      : '');
                }),
            StreamBuilder<String>(
                stream: mainBloc.globalCounter,
                builder: (context, snapshot) {
                  return FlatButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CounterViewer()));
                    },
                    child: Text('Counter ${snapshot.data}'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
