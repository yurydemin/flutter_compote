import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/main_bloc.dart';
import 'package:provider/provider.dart';

class CounterViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainBloc = Provider.of<MainBloc>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: mainBloc.globalCounter,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: mainBloc.changeGlobalCounter,
                        ),
                      );
                    }),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Сохранить'),
                  color: Colors.grey,
                ),
              ]),
        ),
      ),
    );
  }
}
