import 'dart:async';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Service managing Stay and Accommodation data (Mock & Remote ready)
class StayService {
  final List<PropertyModel> _mockStays = [
    const PropertyModel(
      id: 'stay-1',
      title: 'The Grand Heritage Villa & Homestay',
      description:
          'Experience tranquility and heritage charm in the heart of Shillong with panoramic pine valley views, bonfire area, homemade local cuisine, and high-speed Wi-Fi.',
      stayType: StayType.homestay,
      address: 'Laitumkhrah, Upper Shillong',
      city: 'Shillong, Meghalaya',
      latitude: 25.5788,
      longitude: 91.8933,
      pricePerNight: 3200,
      pricePerMonth: 45000,
      rating: 4.9,
      reviewsCount: 142,
      images: [
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['High-speed WiFi', 'Free Breakfast', 'Bonfire & BBQ', 'Hot Water Geyser', 'Free Parking', 'Mountain View'],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-1',
        name: 'Marilyn Lyngdoh',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined May 2021',
      ),
      availableRooms: 3,
      roomConfiguration: '2 BHK Private Villa (Up to 4 Guests)',
      distanceText: '2.5 km from Ward’s Lake',
    ),
    const PropertyModel(
      id: 'stay-2',
      title: 'Green Nest Luxury Boys & Girls PG',
      description:
          'Fully furnished premium PG accommodation with 3 times hygienic home-style meals, 24/7 power backup, biometric security, RO water, and daily housekeeping.',
      stayType: StayType.pg,
      address: 'Zoo Road, Near Commerce College',
      city: 'Guwahati, Assam',
      latitude: 26.1722,
      longitude: 91.7766,
      pricePerNight: 650,
      pricePerMonth: 8500,
      rating: 4.75,
      reviewsCount: 88,
      images: [
        'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['3 Meals Included', 'High-speed WiFi', 'Daily Housekeeping', '24/7 Security & CCTV', 'Washing Machine', 'Power Backup'],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-2',
        name: 'Bhaben Kalita',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
        isSuperHost: false,
        responseRate: '95%',
        joinedDate: 'Joined Aug 2022',
      ),
      availableRooms: 5,
      roomConfiguration: 'Single & Double Sharing Available',
      distanceText: '500m from Commerce College',
    ),
    const PropertyModel(
      id: 'stay-3',
      title: 'Annapurna Homely Mess & Dining Stays',
      description:
          'Authentic home-cooked Assamese and North Indian meals with short & monthly lodging packages. Clean and family-managed environment.',
      stayType: StayType.mess,
      address: 'Paltan Bazaar, Near Railway Station',
      city: 'Guwahati, Assam',
      latitude: 26.1812,
      longitude: 91.7512,
      pricePerNight: 400,
      pricePerMonth: 5500,
      rating: 4.6,
      reviewsCount: 52,
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['Breakfast, Lunch & Dinner', 'RO Purified Water', 'Dine-in Hall', 'Monthly Meal Cards'],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-3',
        name: 'Pranab & Gita Baruah',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '99%',
        joinedDate: 'Joined Jan 2020',
      ),
      availableRooms: 20,
      roomConfiguration: 'Daily Subscription / Dine-in',
      distanceText: '1.0 km from Guwahati Railway Station',
    ),
    const PropertyModel(
      id: 'stay-4',
      title: 'Boutique Studio Suite Room',
      description:
          'Modern self-contained private room with kitchenette, balcony overlooking greenery, dedicated work desk, smart TV with OTT subscriptions.',
      stayType: StayType.room,
      address: 'Beltola, Survey Road',
      city: 'Guwahati, Assam',
      latitude: 26.1265,
      longitude: 91.7944,
      pricePerNight: 1600,
      pricePerMonth: 18000,
      rating: 4.85,
      reviewsCount: 76,
      images: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['Kitchenette', 'Smart Android TV', 'Air Conditioner', 'Balcony', 'Geyser', 'Dedicated Workspace'],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-4',
        name: 'Ananya Dutta',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined Sep 2021',
      ),
      availableRooms: 2,
      roomConfiguration: 'Private 1 RK Studio',
      distanceText: '1.5 km from Dispur Capital Complex',
    ),
    const PropertyModel(
      id: 'stay-5',
      title: 'Azure Bay Luxury Beach Resort',
      description:
          'Direct beachfront 5-star experience with infinity pool, spa, cocktail sunset lounge, and private beach cabanas in North Goa.',
      stayType: StayType.hotel,
      address: 'Calangute - Baga Road',
      city: 'Goa, India',
      latitude: 15.5494,
      longitude: 73.7535,
      pricePerNight: 6500,
      rating: 4.92,
      reviewsCount: 380,
      images: [
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['Beachfront Access', 'Infinity Pool', 'Spa & Wellness', 'Complimentary Breakfast', 'Bar & Lounge', 'Airport Shuttle'],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-5',
        name: 'Azure Hospitality Group',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined 2019',
      ),
      availableRooms: 8,
      roomConfiguration: 'Deluxe Sea View Suite',
      distanceText: 'Direct Access to Calangute Beach',
    ),
    const PropertyModel(
      id: 'stay-6',
      title: 'Snow Peak Alpine Wooden Cottage',
      description:
          'Charming cedar wood cottage in Old Manali surrounded by apple orchards, with wooden fireplace, panoramic Himalayan snow peaks view.',
      stayType: StayType.homestay,
      address: 'Old Manali Village, Near Manu Temple',
      city: 'Manali, Himachal Pradesh',
      latitude: 32.2530,
      longitude: 77.1750,
      pricePerNight: 2800,
      rating: 4.88,
      reviewsCount: 165,
      images: [
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['Indoor Fireplace', 'Mountain Snow View', 'Organic Orchard', 'High-speed WiFi', 'Cafe & Bakery'],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-6',
        name: 'Tenzin & Sunita',
        avatarUrl: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '98%',
        joinedDate: 'Joined 2021',
      ),
      availableRooms: 2,
      roomConfiguration: '2 Bedroom Wooden Attic Suite',
      distanceText: '1.2 km from Mall Road',
    ),
  ];

  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _mockStays.where((stay) {
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final query = searchQuery.toLowerCase().trim();
        final matchesTitle = stay.title.toLowerCase().contains(query);
        final matchesCity = stay.city.toLowerCase().contains(query);
        final matchesAddress = stay.address.toLowerCase().contains(query);
        final matchesType = stay.stayType.label.toLowerCase().contains(query);
        if (!matchesTitle && !matchesCity && !matchesAddress && !matchesType) {
          return false;
        }
      }

      if (filter != null) {
        if (filter.stayType != null && stay.stayType != filter.stayType) {
          return false;
        }
        if (filter.minPrice != null && stay.pricePerNight < filter.minPrice!) {
          return false;
        }
        if (filter.maxPrice != null && stay.pricePerNight > filter.maxPrice!) {
          return false;
        }
        if (filter.minRating != null && stay.rating < filter.minRating!) {
          return false;
        }
        if (filter.verifiedOnly == true && !stay.isVerified) {
          return false;
        }
        if (filter.city != null && filter.city!.isNotEmpty) {
          if (!stay.city.toLowerCase().contains(filter.city!.toLowerCase())) {
            return false;
          }
        }
        if (filter.amenities.isNotEmpty) {
          final hasAll = filter.amenities.every(
            (req) => stay.amenities.any((a) => a.toLowerCase().contains(req.toLowerCase())),
          );
          if (!hasAll) return false;
        }
      }

      return true;
    }).toList();
  }

  Future<List<PropertyModel>> getFeaturedStays() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _mockStays.where((s) => s.isFeatured).toList();
  }

  Future<List<PropertyModel>> getNearbyStays({required String city}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final cityName = city.split(',').first.trim().toLowerCase();
    final inCity = _mockStays.where((s) => s.city.toLowerCase().contains(cityName)).toList();
    if (inCity.isNotEmpty) return inCity;
    return List.from(_mockStays);
  }

  Future<PropertyModel> getStayById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockStays.firstWhere((s) => s.id == id, orElse: () => _mockStays.first);
  }

  Future<List<ReviewModel>> getStayReviews(String stayId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      ReviewModel(
        id: 'r1',
        userName: 'Rohan Bordoloi',
        userAvatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
        rating: 5.0,
        dateText: '2 weeks ago',
        comment: 'Outstanding stay! The place was spotless, host was very warm, and the food was delicious. Highly recommended!',
      ),
      ReviewModel(
        id: 'r2',
        userName: 'Priya Sharma',
        userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
        rating: 4.8,
        dateText: '1 month ago',
        comment: 'Great location and fast WiFi. Perfect for remote work and a weekend getaway.',
      ),
      ReviewModel(
        id: 'r3',
        userName: 'Devraj Singh',
        userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
        rating: 4.9,
        dateText: '2 months ago',
        comment: 'Super peaceful environment. Smooth check-in with prompt host communication.',
      ),
    ];
  }

  Future<bool> toggleFavorite(String stayId, bool isFavorite) async {
    return !isFavorite;
  }
}

// Clean aliases so existing usecase/repository tests and bindings work seamlessly
abstract class IStayDataSource {
  Future<List<PropertyModel>> fetchStays();
  Future<PropertyModel> fetchStayById(String id);
  Future<List<ReviewModel>> fetchStayReviews(String stayId);
}

class StayMockDataSource implements IStayDataSource {
  final StayService _service = StayService();

  @override
  Future<List<PropertyModel>> fetchStays() => _service.getStays();

  @override
  Future<PropertyModel> fetchStayById(String id) => _service.getStayById(id);

  @override
  Future<List<ReviewModel>> fetchStayReviews(String stayId) => _service.getStayReviews(stayId);
}

abstract class IStayRepository {
  Future<List<PropertyModel>> getStays({StayFilterCriteria? filter, String? searchQuery, int page = 1, int limit = 20});
  Future<List<PropertyModel>> getFeaturedStays();
  Future<List<PropertyModel>> getNearbyStays({required String city});
  Future<PropertyModel> getStayById(String id);
  Future<List<ReviewModel>> getStayReviews(String stayId);
  Future<bool> toggleFavorite(String stayId, bool isFavorite);
}

class StayRepositoryImpl implements IStayRepository {
  final IStayDataSource dataSource;
  final StayService _service = StayService();

  StayRepositoryImpl(this.dataSource);

  @override
  Future<List<PropertyModel>> getStays({StayFilterCriteria? filter, String? searchQuery, int page = 1, int limit = 20}) =>
      _service.getStays(filter: filter, searchQuery: searchQuery);

  @override
  Future<List<PropertyModel>> getFeaturedStays() => _service.getFeaturedStays();

  @override
  Future<List<PropertyModel>> getNearbyStays({required String city}) => _service.getNearbyStays(city: city);

  @override
  Future<PropertyModel> getStayById(String id) => _service.getStayById(id);

  @override
  Future<List<ReviewModel>> getStayReviews(String stayId) => _service.getStayReviews(stayId);

  @override
  Future<bool> toggleFavorite(String stayId, bool isFavorite) => _service.toggleFavorite(stayId, isFavorite);
}

class GetStaysUseCase {
  final IStayRepository repository;
  GetStaysUseCase(this.repository);

  Future<List<PropertyModel>> call({StayFilterCriteria? filter, String? searchQuery}) =>
      repository.getStays(filter: filter, searchQuery: searchQuery);

  Future<List<PropertyModel>> getFeatured() => repository.getFeaturedStays();
  Future<List<PropertyModel>> getNearby(String city) => repository.getNearbyStays(city: city);
  Future<bool> toggleFavorite(String stayId, bool isFavorite) => repository.toggleFavorite(stayId, isFavorite);
}

class GetStayDetailsUseCase {
  final IStayRepository repository;
  GetStayDetailsUseCase(this.repository);

  Future<PropertyModel> getDetails(String id) => repository.getStayById(id);
  Future<List<ReviewModel>> getReviews(String id) => repository.getStayReviews(id);
}

class SearchStaysUseCase {
  final IStayRepository repository;
  SearchStaysUseCase(this.repository);

  Future<List<PropertyModel>> call(String query) => repository.getStays(searchQuery: query);
}
