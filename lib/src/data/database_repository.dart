import 'package:ts_6_1_1_firebase_setup_auth/src/domain/user.dart';

abstract class DatabaseRepository {
  Future<void> loginUser(User currentUser);
  Future<User?> getUser();
  Future<void> removedUser();
}
