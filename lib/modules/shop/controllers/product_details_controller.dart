import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/shop_repository.dart';
import '../data/repositories/shop_repository_impl.dart';
import '../models/product_model.dart';
import '../models/product_review_model.dart';
import '../models/product_variant_model.dart';
import 'cart_controller.dart';

/// Controller for single product details, image carousel, variants and cart additions
class ProductDetailsController extends GetxController {
  final ShopRepository repository;
  final ProductModel product;

  ProductDetailsController({
    required this.product,
    ShopRepository? repository,
  }) : repository = repository ?? ShopRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;
  final RxInt activeImageIndex = 0.obs;
  final Rx<ProductVariantModel?> selectedVariant = Rx<ProductVariantModel?>(null);
  final RxInt quantity = 1.obs;
  final RxInt activeTab = 0.obs; // 0: Overview, 1: Cultural Heritage, 2: Reviews
  final RxList<ProductReviewModel> reviews = <ProductReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (product.variants.isNotEmpty) {
      selectedVariant.value = product.variants.first;
    }
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      state.value = ViewState.loading;
      final result = await repository.getProductReviews(product.id);
      reviews.assignAll(result);
      state.value = ViewState.loaded;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void setActiveImage(int index) {
    activeImageIndex.value = index;
  }

  void selectVariant(ProductVariantModel variant) {
    selectedVariant.value = variant;
  }

  void setTab(int index) {
    activeTab.value = index;
  }

  void incrementQuantity() {
    if (quantity.value < product.stock) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  double get currentEffectivePrice {
    return product.price + (selectedVariant.value?.priceDelta ?? 0.0);
  }

  void addToCart() {
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }
    final cartCtrl = Get.find<CartController>();
    cartCtrl.addToCart(
      product,
      variant: selectedVariant.value,
      quantity: quantity.value,
    );
  }
}
