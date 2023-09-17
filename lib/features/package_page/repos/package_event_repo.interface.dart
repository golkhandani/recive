import 'package:recive/features/package_page/models/package.dart';

abstract class IPackageEventRepo {
  Future<List<PackageAbstract>> packages({
    required int limit,
    PackageAbstract? lastItem,
  });

  Future<Package> packageById({
    required String id,
  });
}
