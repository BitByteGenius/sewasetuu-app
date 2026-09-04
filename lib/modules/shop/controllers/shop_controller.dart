import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/shop_repository_impl.dart';
import '../models/product_model.dart';
import '../models/shop_category_model.dart';
import '../models/shop_state_model.dart';

/// Controller for the main Shop discovery screen
class ShopController extends GetxController {
  final ShopRepository repository;

  ShopController({ShopRepository? repository})
      : repository = repository ?? ShopRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;

  // Data collections
  final RxList<ShopStateModel> featuredStates = <ShopStateModel>[].obs;
  final RxList<ShopStateModel> allStates = <ShopStateModel>[].obs;
  final RxList<ShopCategoryModel> categories = <ShopCategoryModel>[].obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> popularProducts = <ProductModel>[].obs;

  // Region filtering: 'All', 'North East', 'East', 'North', 'West', 'South'
  final RxString selectedRegion = 'All'.obs;
  final List<String> availableRegions = const [
    'All',
    'North East',
    'East',
    'North',
    'West',
    'South',
  ];

  @override
  void onInit() {
    super.onInit();
    loadShopFeed();
  }

  Future<void> loadShopFeed() async {
    try {
      state.value = ViewState.loading;

      final futures = await Future.wait([
        repository.getFeaturedStates(),
        repository.getAllStates(),
        repository.getCategories(),
        repository.getFeaturedProducts(),
        repository.getPopularProducts(),
      ]);

      featuredStates.assignAll(futures[0] as List<ShopStateModel>);
      allStates.assignAll(futures[1] as List<ShopStateModel>);
      categories.assignAll(futures[2] as List<ShopCategoryModel>);
      featuredProducts.assignAll(futures[3] as List<ProductModel>);
      popularProducts.assignAll(futures[4] as List<ProductModel>);

      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void selectRegion(String region) {
    selectedRegion.value = region;
  }

  List<ShopStateModel> get statesByRegion {
    if (selectedRegion.value == 'All') return allStates;
    return allStates
        .where((s) => s.region.toLowerCase() == selectedRegion.value.toLowerCase())
        .toList();
  }

  Future<void> refreshFeed() async {
    await loadShopFeed();
  }
}
