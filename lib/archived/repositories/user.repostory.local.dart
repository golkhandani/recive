import 'package:recive/archived/models/user.model.dart';
import 'package:recive/archived/repositories/user.repository.interface.dart';

import 'dart:math';

import 'package:recive/utils/sleep.dart';

class UserRepositoryLocal extends IUserRepository {
  @override
  Future<int> fetchUserNotificationCount() async {
    await sleep;
    return Random().nextInt(100);
  }

  @override
  Future<User> fetchUserProfile() async {
    await sleep;
    return const User(
      id: "c2dc2412-bf22-4ce0-9231-8639d636284f",
      name: "Mohammadreza",
      email: "golkhandani@gmail.com",
    );
  }
}
