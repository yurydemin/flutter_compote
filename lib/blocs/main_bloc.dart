import 'package:flutter_compote/models/public_data.dart';
import 'package:flutter_compote/services/public_api_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MainBloc {
  final _db = PublicApiService();
  final _globalCounter = BehaviorSubject<String>.seeded('');

  Stream<String> get globalCounter => _globalCounter.stream;
  Function(String) get changeGlobalCounter => _globalCounter.sink.add;

  Stream<List<PublicData>> fetchPublicData() =>
      _db.fetchPublicData().catchError((error) => print(error)).asStream();

  dispose() {
    _globalCounter.close();
  }
}
