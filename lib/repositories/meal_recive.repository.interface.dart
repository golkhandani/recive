import 'package:recive/models/recive.model.dart';

abstract class IMealReciveRepository {
  Future<List<String>> quickSearch({required String query});
  Future<List<Recive>> search();
}
