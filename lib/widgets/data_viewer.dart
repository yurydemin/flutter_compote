import 'package:flutter/material.dart';
import 'package:flutter_compote/blocs/main_bloc.dart';
import 'package:flutter_compote/models/public_data.dart';
import 'package:flutter_compote/widgets/counter_viewer.dart';
import 'package:provider/provider.dart';

class DataViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainBloc = Provider.of<MainBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Public data'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder<String>(
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
          ),
        ],
      ),
      body: StreamBuilder<List<PublicData>>(
        stream: mainBloc.fetchPublicData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Center(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var publicData = snapshot.data[index];
                return ListTile(
                  title: Text(publicData.name),
                  subtitle: Text(publicData.poster),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
