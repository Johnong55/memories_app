import '../../core/resources/data_state.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<DataState<UserModel>> call({required String email, required String password}) {
    return _repository.login(email, password);
  }
}

class RegisterUseCase {
  final AuthRepository _repository;
  RegisterUseCase(this._repository);

  Future<DataState<UserModel>> call({required String name, required String email, required String password}) {
    return _repository.register(name, email, password);
  }
}

class LogoutUseCase {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<DataState<void>> call() {
    return _repository.logout();
  }
}
