import '../electrician/data/home_services_data.dart';
import '../electrician/models/home_service_model.dart';
import '../home_cleaning/models/kitchen_cleaning_model.dart';

/// Unified Abstract Repository interface for all Home Services submodules.
/// Encapsulates data fetching operations and provides seamless toggle between
/// Mock Data Sources and Live REST API Endpoints.
abstract class HomeServicesRepository {
  Future<List<HomeServiceCategory>> getCategories(String serviceType);
  Future<List<HomeServiceItem>> getServices(String serviceType, {String? categoryId});
  Future<List<HomeServiceOfferBanner>> getOfferBanners(String serviceType);
  Future<List<KitchenFaqItem>> getFaqs(String serviceType);
  Future<RatingBreakdownModel> getRatingBreakdown(String serviceType);
}

/// Primary Repository implementation.
/// Currently powered by high-fidelity local data sources.
/// To switch to a live backend API, replace the data source methods below with your HTTP client calls.
class HomeServicesRepositoryImpl implements HomeServicesRepository {
  final bool useMockData;

  HomeServicesRepositoryImpl({this.useMockData = true});

  @override
  Future<List<HomeServiceCategory>> getCategories(String serviceType) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    switch (serviceType.toLowerCase()) {
      case 'electrician':
        return HomeServicesData.electricianCategories;
      case 'plumbing':
        return HomeServicesData.plumbingCategories;
      case 'carpentry':
      case 'carpenter':
        return HomeServicesData.carpentryCategories;
      default:
        return HomeServicesData.electricianCategories;
    }
  }

  @override
  Future<List<HomeServiceItem>> getServices(String serviceType, {String? categoryId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    List<HomeServiceItem> items;
    switch (serviceType.toLowerCase()) {
      case 'electrician':
        items = HomeServicesData.electricianServices;
        break;
      case 'plumbing':
        items = HomeServicesData.plumbingServices;
        break;
      case 'carpentry':
      case 'carpenter':
        items = HomeServicesData.carpentryServices;
        break;
      default:
        items = HomeServicesData.electricianServices;
    }

    if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
      return items.where((item) => item.categoryId == categoryId).toList();
    }
    return items;
  }

  @override
  Future<List<HomeServiceOfferBanner>> getOfferBanners(String serviceType) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    switch (serviceType.toLowerCase()) {
      case 'electrician':
        return HomeServicesData.electricianBanners;
      case 'plumbing':
        return HomeServicesData.plumbingBanners;
      case 'carpentry':
      case 'carpenter':
        return HomeServicesData.carpentryBanners;
      default:
        return HomeServicesData.electricianBanners;
    }
  }

  @override
  Future<List<KitchenFaqItem>> getFaqs(String serviceType) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return HomeServicesData.defaultFaqs;
  }

  @override
  Future<RatingBreakdownModel> getRatingBreakdown(String serviceType) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return HomeServicesData.ratingBreakdown;
  }
}
