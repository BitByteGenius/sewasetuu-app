import '../models/service_category_item.dart';
import '../models/service_faq_item.dart';
import '../models/service_offer_item.dart';
import '../models/service_popular_item.dart';
import '../models/service_relocation_item.dart';
import '../models/service_review_item.dart';
import '../models/service_spotlight_item.dart';
import '../models/service_subcategory_item.dart';
import 'services_mock_data.dart';

/// Abstract repository contract defining data operations for the Services module.
/// Decouples Controllers and UI from the underlying data source (Mock vs Remote REST/GraphQL API).
abstract class ServicesRepository {
  Future<List<ServiceCategoryItem>> getHeaderCategories();
  Future<List<ServiceOfferItem>> getPromotionalOffers();
  Future<ServiceSpotlightItem?> getSpotlightService();
  Future<List<ServiceSubcategoryItem>> getCleaningSubcategories();
  Future<List<ServiceSubcategoryItem>> getRepairSubcategories();
  Future<List<ServicePopularItem>> getPopularServices();
  Future<List<ServiceRelocationItem>> getRelocationOptions();
  Future<List<ServiceReviewItem>> getCustomerReviews();
  Future<List<ServiceFaqItem>> getFaqItems();
}

/// Default repository implementation.
/// To switch to a live backend, simply replace the return calls below with your API HTTP client calls.
class ServicesRepositoryImpl implements ServicesRepository {
  @override
  Future<List<ServiceCategoryItem>> getHeaderCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.headerCategories;
  }

  @override
  Future<List<ServiceOfferItem>> getPromotionalOffers() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.promotionalOffers;
  }

  @override
  Future<ServiceSpotlightItem?> getSpotlightService() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.spotlightService;
  }

  @override
  Future<List<ServiceSubcategoryItem>> getCleaningSubcategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.homeCleaningSubcategories;
  }

  @override
  Future<List<ServiceSubcategoryItem>> getRepairSubcategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.homeRepairSubcategories;
  }

  @override
  Future<List<ServicePopularItem>> getPopularServices() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.popularServices;
  }

  @override
  Future<List<ServiceRelocationItem>> getRelocationOptions() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.relocationOptions;
  }

  @override
  Future<List<ServiceReviewItem>> getCustomerReviews() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.customerReviews;
  }

  @override
  Future<List<ServiceFaqItem>> getFaqItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return ServicesMockData.faqItems;
  }
}
