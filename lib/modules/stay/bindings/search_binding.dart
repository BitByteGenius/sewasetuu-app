import 'package:get/get.dart';
import 'package:sewasetu/modules/stay/controllers/search_controller.dart';

/// Bindings for Stay Search
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
