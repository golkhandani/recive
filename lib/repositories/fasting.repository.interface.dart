import 'package:recive/models/fasting.model.dart';

abstract class IFastingRepository {
  Future<Fasting> getInfo();
}
