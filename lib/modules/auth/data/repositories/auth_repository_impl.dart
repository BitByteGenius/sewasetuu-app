import 'dart:convert';
import 'package:sewasetu/core/constants/app_constants.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sewasetu/modules/auth/domain/entities/user_entity.dart';
import 'package:sewasetu/modules/auth/domain/repositories/auth_repository.dart';
import 'package:sewasetu/modules/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDataSource _remoteDataSource;
  final IStorageService _storageService;

  AuthRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<bool> sendOtp(String phone) async {
    return await _remoteDataSource.sendOtp(phone);
  }

  @override
  Future<UserEntity> verifyOtp(String phone, String otp) async {
    final user = await _remoteDataSource.verifyOtp(phone, otp);
    await _storageService.setString(AppConstants.tokenKey, 'jwt_dummy_token_${user.id}');
    await _storageService.setString(AppConstants.userKey, jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userJson = _storageService.getString(AppConstants.userKey);
    if (userJson != null) {
      try {
        return UserModel.fromJson(jsonDecode(userJson));
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _storageService.remove(AppConstants.tokenKey);
    await _storageService.remove(AppConstants.userKey);
  }
}
