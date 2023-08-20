import 'package:recive/archived/models/fasting.model.dart';

abstract class IFastingRepository {
  Future<Fasting> getInfo();
}
