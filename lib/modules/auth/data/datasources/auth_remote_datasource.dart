import 'package:sewasetu/modules/auth/data/models/user_model.dart';

abstract class IAuthDataSource {
  Future<bool> sendOtp(String phone);
  Future<UserModel> verifyOtp(String phone, String otp);
}

class AuthRemoteDataSource implements IAuthDataSource {
  @override
  Future<bool> sendOtp(String phone) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<UserModel> verifyOtp(String phone, String otp) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(
      id: 'usr_101',
      name: 'Gulshan Kumar',
      phone: phone,
      email: 'gulshan@example.com',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
      isVerified: true,
    );
  }
}
