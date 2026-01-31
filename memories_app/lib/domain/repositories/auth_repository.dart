import '../../core/resources/data_state.dart';
import '../../data/models/user_model.dart'; // Ideally should be Entity, but using Model for speed
// If we were strict: import '../../domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> login(String email, String password);
  Future<DataState<UserModel>> register(String name, String email, String password);
  Future<DataState<void>> logout();
  Future<DataState<UserModel>> getProfile();
}
