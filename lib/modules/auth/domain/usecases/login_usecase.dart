import 'package:sewasetu/modules/auth/domain/entities/user_entity.dart';
import 'package:sewasetu/modules/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> sendOtp(String phone) async {
    return await repository.sendOtp(phone);
  }

  Future<UserEntity> verifyOtp(String phone, String otp) async {
    return await repository.verifyOtp(phone, otp);
  }

  Future<UserEntity?> getCurrentUser() async {
    return await repository.getCurrentUser();
  }

  Future<void> logout() async {
    return await repository.logout();
  }
}
