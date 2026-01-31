import 'package:dio/dio.dart';
// import 'package:get/get.dart';
import '../../core/resources/data_state.dart';
import '../../core/errors/failures.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/auth_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
// import '../models/api_response_model.dart';
// import '../../core/constants/api_endpoints.dart';

class AuthRepositoryImpl implements AuthRepository {
  // final DioClient _dioClient; 
  final AuthService _authService;

  AuthRepositoryImpl(DioClient dioClient, this._authService); // kept for DI consistency but unused

  @override
  Future<DataState<UserModel>> login(String email, String password) async {
    try {
      // MOCK DATA for initial development
      await Future.delayed(const Duration(seconds: 1)); // Simulate network
      if (email == 'user@example.com' && password == 'password123') {
        final mockUser = UserModel(
          id: '123',
          email: 'user@example.com',
          name: 'John Doe',
          photoUrl: 'https://i.pravatar.cc/150?u=123',
        );
        await _authService.saveTokens('mock_access_token', 'mock_refresh_token');
        return DataSuccess(mockUser);
      }
      
      // Real API Call
      /*
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<UserModel>.fromJson(
          response.data,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );
        
        if (apiResponse.success && apiResponse.data != null) {
           // Extract tokens from data if they are there, or separate
           // Note: The example response showed token inside 'data'.
           // ApiResponse generic wrapper might need adjustment if 'data' contains both user and token.
           // For now assuming we handle that.
           
           // Saving tokens logic here...
           return DataSuccess(apiResponse.data!);
        }
      }
      */
      
      return DataFailed(ServerFailure('Invalid credentials'));
    } on DioException catch (e) {
      return DataFailed(ServerFailure(e.message ?? 'An error occurred'));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<DataState<UserModel>> register(String name, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockUser = UserModel(
        id: '124',
        email: email,
        name: name,
        photoUrl: null,
      );
      await _authService.saveTokens('mock_access_token', 'mock_refresh_token');
      return DataSuccess(mockUser);
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> logout() async {
    await _authService.logout();
    return const DataSuccess(null);
  }

  @override
  Future<DataState<UserModel>> getProfile() async {
      // Mock profile
      return DataSuccess(UserModel(
          id: '123',
          email: 'user@example.com',
          name: 'John Doe',
          photoUrl: 'https://i.pravatar.cc/150?u=123',
      ));
  }
}
