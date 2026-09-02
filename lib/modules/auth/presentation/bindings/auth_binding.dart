import 'package:get/get.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sewasetu/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:sewasetu/modules/auth/domain/repositories/auth_repository.dart';
import 'package:sewasetu/modules/auth/domain/usecases/login_usecase.dart';
import 'package:sewasetu/modules/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthDataSource>(() => AuthRemoteDataSource());
    Get.lazyPut<IAuthRepository>(
      () => AuthRepositoryImpl(Get.find<IAuthDataSource>(), Get.find<IStorageService>()),
    );
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<IAuthRepository>()));
    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: Get.find<LoginUseCase>()),
    );
  }
}
