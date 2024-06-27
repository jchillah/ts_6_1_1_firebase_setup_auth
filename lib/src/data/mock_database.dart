import '../domain/user.dart';
import 'database_repository.dart';

class MockDatabase implements DatabaseRepository {
  User? currentUser;

  @override
  Future<void> loginUser(User currentUser) async {
    this.currentUser = currentUser;
  }

  @override
  Future<User?> getUser() async {
    return currentUser;
  }

  @override
  Future<void> removedUser() async {
    currentUser = null;
  }
}
