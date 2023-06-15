import 'package:recive/models/user.model.dart';

abstract class IUserRepository {
  Future<User> fetchUserProfile();
  Future<int> fetchUserNotificationCount();
}
