import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<bool> sendOtp(String phone);
  Future<UserEntity> verifyOtp(String phone, String otp);
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
}
