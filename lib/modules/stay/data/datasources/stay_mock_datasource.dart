import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sewasetu/core/storage/storage_service.dart';
import 'package:sewasetu/modules/stay/models/property_model.dart';
import 'package:sewasetu/modules/stay/models/review_model.dart';
import 'package:sewasetu/modules/stay/models/stay_filter_criteria.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Contract for Stay Local/Mock Data Source
abstract class IStayMockDataSource {
  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
  });
  Future<List<PropertyModel>> getSavedStays();
  Future<List<PropertyModel>> getFeaturedStays();
  Future<List<PropertyModel>> getNearbyStays({required String city});
  Future<PropertyModel> getStayById(String id);
  Future<List<ReviewModel>> getStayReviews(String stayId);
  Future<bool> toggleFavorite(String stayId, [bool? currentFavorite]);
}

/// Standalone, fully functional Mock Data Source for Stays
class StayMockDataSourceImpl implements IStayMockDataSource {
  final List<PropertyModel> _mockStays = const [
    PropertyModel(
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
      depositAmount: 15000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.9,
      reviewsCount: 142,
      images: [
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'High-speed WiFi',
        'Free Breakfast',
        'Bonfire & BBQ',
        'Hot Water Geyser',
        'Free Parking',
        'Mountain View'
      ],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-1',
        name: 'Marilyn Lyngdoh',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined May 2021',
      ),
      availableRooms: 3,
      roomConfiguration: '2 BHK Private Villa',
      distanceText: '2.5 km from Ward’s Lake',
    ),
    PropertyModel(
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
      depositAmount: 3000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.75,
      reviewsCount: 88,
      images: [
        'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        '3 Meals Included',
        'High-speed WiFi',
        'Daily Housekeeping',
        '24/7 Security & CCTV',
        'Washing Machine',
        'Power Backup'
      ],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-2',
        name: 'Bhaben Kalita',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
        isSuperHost: false,
        responseRate: '95%',
        joinedDate: 'Joined Aug 2022',
      ),
      availableRooms: 5,
      roomConfiguration: 'Single & Double Sharing PG',
      distanceText: '500m from Commerce College',
    ),
    PropertyModel(
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
      depositAmount: 1500,
      furnishingStatus: 'Semi-Furnished',
      availableFrom: 'Available Now',
      rating: 4.6,
      reviewsCount: 52,
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'Breakfast, Lunch & Dinner',
        'RO Purified Water',
        'Dine-in Hall',
        'Monthly Meal Cards'
      ],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-3',
        name: 'Pranab & Gita Baruah',
        avatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '99%',
        joinedDate: 'Joined Jan 2020',
      ),
      availableRooms: 20,
      roomConfiguration: 'Daily Subscription Mess',
      distanceText: '1.0 km from Railway Station',
    ),
    PropertyModel(
      id: 'stay-4',
      title: 'Boutique Studio Suite 1RK',
      description:
          'Modern self-contained private 1RK room with kitchenette, balcony overlooking greenery, dedicated work desk, smart TV with OTT subscriptions.',
      stayType: StayType.room,
      address: 'Beltola, Survey Road',
      city: 'Guwahati, Assam',
      latitude: 26.1265,
      longitude: 91.7944,
      pricePerNight: 1600,
      pricePerMonth: 18000,
      depositAmount: 8000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.85,
      reviewsCount: 76,
      images: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'Kitchenette',
        'Smart Android TV',
        'Air Conditioner',
        'Balcony',
        'Geyser',
        'Dedicated Workspace'
      ],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-4',
        name: 'Ananya Dutta',
        avatarUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined Sep 2021',
      ),
      availableRooms: 2,
      roomConfiguration: '1RK',
      distanceText: '1.5 km from Dispur Capital',
    ),
    PropertyModel(
      id: 'stay-5',
      title: 'Azure Bay Luxury Beach Hotel & Resort',
      description:
          'Direct beachfront 5-star experience with infinity pool, spa, cocktail sunset lounge, and private beach cabanas in North Goa.',
      stayType: StayType.hotel,
      address: 'Calangute - Baga Road',
      city: 'Goa, India',
      latitude: 15.5494,
      longitude: 73.7535,
      pricePerNight: 6500,
      pricePerMonth: 120000,
      depositAmount: 30000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.92,
      reviewsCount: 380,
      images: [
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'Beachfront Access',
        'Infinity Pool',
        'Spa & Wellness',
        'Complimentary Breakfast',
        'Bar & Lounge',
        'Airport Shuttle'
      ],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-5',
        name: 'Azure Hospitality Group',
        avatarUrl:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined 2019',
      ),
      availableRooms: 8,
      roomConfiguration: 'Deluxe Sea View Suite Hotel',
      distanceText: 'Direct Access to Calangute Beach',
    ),
    PropertyModel(
      id: 'stay-6',
      title: 'Snow Peak Alpine Wooden Cottage Homestay',
      description:
          'Charming cedar wood cottage in Old Manali surrounded by apple orchards, with wooden fireplace, panoramic Himalayan snow peaks view.',
      stayType: StayType.homestay,
      address: 'Old Manali Village, Near Manu Temple',
      city: 'Manali, Himachal Pradesh',
      latitude: 32.2530,
      longitude: 77.1750,
      pricePerNight: 2800,
      pricePerMonth: 38000,
      depositAmount: 10000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.88,
      reviewsCount: 165,
      images: [
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'Indoor Fireplace',
        'Mountain Snow View',
        'Organic Orchard',
        'High-speed WiFi',
        'Cafe & Bakery'
      ],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-6',
        name: 'Tenzin & Sunita',
        avatarUrl:
            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '98%',
        joinedDate: 'Joined 2021',
      ),
      availableRooms: 2,
      roomConfiguration: '2 BHK Wooden Attic Suite',
      distanceText: '1.2 km from Mall Road',
    ),
    PropertyModel(
      id: 'stay-7',
      title: 'Kamakhya Vista 1BHK Executive Flat',
      description:
          'Modern 1BHK apartment located within 200 meters of Kamakhya Gate. Includes modular kitchen, air conditioning, high-speed fiber internet, and 24/7 security.',
      stayType: StayType.room,
      address: 'Fatashil Main Road, Kamakhya Gate',
      city: 'Guwahati, Assam',
      latitude: 26.1568,
      longitude: 91.7096,
      pricePerNight: 1200,
      pricePerMonth: 14500,
      depositAmount: 5000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.92,
      reviewsCount: 44,
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        'High-speed WiFi',
        'Air Conditioner',
        'Modular Kitchen',
        'Geyser',
        'Lift & Generator'
      ],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-7',
        name: 'Niloy Sengupta',
        avatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '100%',
        joinedDate: 'Joined 2022',
      ),
      availableRooms: 1,
      roomConfiguration: '1BHK',
      distanceText: '160m from Kamakhya Gate',
    ),
    PropertyModel(
      id: 'stay-8',
      title: 'Hillview 2BHK Premium Residence',
      description:
          'Spacious 2BHK family apartment with balcony facing Kamakhya hills. Ideal for working professionals and families, located 280m from current GPS center.',
      stayType: StayType.room,
      address: 'Kamakhya Temple Road, Fatashil',
      city: 'Guwahati, Assam',
      latitude: 26.1542,
      longitude: 91.7076,
      pricePerNight: 1800,
      pricePerMonth: 22000,
      depositAmount: 10000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Immediate',
      rating: 4.84,
      reviewsCount: 62,
      images: [
        'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        '2 Covered Parking',
        'High-speed WiFi',
        'Power Backup',
        'Washing Machine',
        'Smart TV'
      ],
      isFeatured: true,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-8',
        name: 'Dr. Sarma',
        avatarUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '98%',
        joinedDate: 'Joined 2020',
      ),
      availableRooms: 2,
      roomConfiguration: '2BHK',
      distanceText: '280m from Kamakhya Gate',
    ),
    PropertyModel(
      id: 'stay-9',
      title: 'Royal Horizon 3BHK Luxury Flat',
      description:
          'Premium 3BHK apartment within 350 meters of location center. Master bedroom with ensuite bathroom, grand living space, and dedicated car parking.',
      stayType: StayType.room,
      address: 'Nursery Bus Stop, Fatashil',
      city: 'Guwahati, Assam',
      latitude: 26.1582,
      longitude: 91.7104,
      pricePerNight: 2600,
      pricePerMonth: 32000,
      depositAmount: 15000,
      furnishingStatus: 'Fully Furnished',
      availableFrom: 'Next Week',
      rating: 4.95,
      reviewsCount: 31,
      images: [
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: [
        '3 Master Bedrooms',
        '3 Balconies',
        'Reserved Parking',
        '24/7 Power Backup',
        'Intercom & CCTV'
      ],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: StayHostEntity(
        id: 'host-9',
        name: 'Pooja Choudhury',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
        isSuperHost: false,
        responseRate: '96%',
        joinedDate: 'Joined 2023',
      ),
      availableRooms: 1,
      roomConfiguration: '3BHK',
      distanceText: '350m from Kamakhya Gate',
    ),
  ];

  static final Set<String> _favoriteIds = <String>{};
  static bool _initialized = false;

  void _initFavorites() {
    if (_initialized) return;
    _initialized = true;
    try {
      if (Get.isRegistered<IStorageService>()) {
        final storage = Get.find<IStorageService>();
        final raw = storage.getString('stay_favorite_ids');
        if (raw != null && raw.isNotEmpty) {
          final List<dynamic> list = jsonDecode(raw);
          _favoriteIds.addAll(list.cast<String>());
        }
      }
    } catch (_) {}
  }

  void _persistFavorites() {
    try {
      if (Get.isRegistered<IStorageService>()) {
        final storage = Get.find<IStorageService>();
        storage.setString('stay_favorite_ids', jsonEncode(_favoriteIds.toList()));
      }
    } catch (_) {}
  }

  PropertyModel _mapWithFavorite(PropertyModel stay) {
    _initFavorites();
    return stay.copyWith(isFavorite: _favoriteIds.contains(stay.id));
  }

  @override
  Future<List<PropertyModel>> getStays({
    StayFilterCriteria? filter,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));

    return _mockStays.where((stay) {
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final query = searchQuery.toLowerCase().trim();
        final matchesTitle = stay.title.toLowerCase().contains(query);
        final matchesCity = stay.city.toLowerCase().contains(query);
        final matchesAddress = stay.address.toLowerCase().contains(query);
        final matchesType = stay.stayType.label.toLowerCase().contains(query);
        final matchesConfig = stay.roomConfiguration.toLowerCase().contains(query);
        if (!matchesTitle && !matchesCity && !matchesAddress && !matchesType && !matchesConfig) {
          return false;
        }
      }

      if (filter != null) {
        if (filter.stayType != null && stay.stayType != filter.stayType) {
          return false;
        }
        if (filter.roomCategory != null &&
            filter.roomCategory!.isNotEmpty &&
            filter.roomCategory != 'All') {
          final cat = filter.roomCategory!.toLowerCase().trim();
          final matchesTitle = stay.title.toLowerCase().contains(cat);
          final matchesConfig = stay.roomConfiguration.toLowerCase().contains(cat);
          final matchesType = stay.stayType.name.toLowerCase() == cat ||
              stay.stayType.label.toLowerCase().contains(cat);
          if (!matchesTitle && !matchesConfig && !matchesType) {
            return false;
          }
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
          final targetCity = filter.city!.toLowerCase().trim();
          if (!stay.city.toLowerCase().contains(targetCity) &&
              !stay.address.toLowerCase().contains(targetCity)) {
            return false;
          }
        }
        if (filter.userLatitude != null &&
            filter.userLongitude != null &&
            filter.maxRadiusMeters != null) {
          final distMeters = Geolocator.distanceBetween(
            filter.userLatitude!,
            filter.userLongitude!,
            stay.latitude,
            stay.longitude,
          );
          if (distMeters > filter.maxRadiusMeters!) {
            return false;
          }
        }
        if (filter.amenities.isNotEmpty) {
          final hasAll = filter.amenities.every(
            (req) => stay.amenities
                .any((a) => a.toLowerCase().contains(req.toLowerCase())),
          );
          if (!hasAll) return false;
        }
      }

      return true;
    }).map(_mapWithFavorite).toList();
  }

  @override
  Future<List<PropertyModel>> getSavedStays() async {
    _initFavorites();
    await Future.delayed(const Duration(milliseconds: 50));
    return _mockStays
        .where((s) => _favoriteIds.contains(s.id))
        .map(_mapWithFavorite)
        .toList();
  }

  @override
  Future<List<PropertyModel>> getFeaturedStays() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockStays
        .where((s) => s.isFeatured)
        .map(_mapWithFavorite)
        .toList();
  }

  @override
  Future<List<PropertyModel>> getNearbyStays({required String city}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final cityName = city.split(',').first.trim().toLowerCase();
    final inCity = _mockStays
        .where((s) => s.city.toLowerCase().contains(cityName))
        .map(_mapWithFavorite)
        .toList();
    if (inCity.isNotEmpty) return inCity;
    return _mockStays.map(_mapWithFavorite).toList();
  }

  @override
  Future<PropertyModel> getStayById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final found = _mockStays.firstWhere((s) => s.id == id,
        orElse: () => _mockStays.first);
    return _mapWithFavorite(found);
  }

  @override
  Future<List<ReviewModel>> getStayReviews(String stayId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      ReviewModel(
        id: 'r1',
        userName: 'Rohan Bordoloi',
        userAvatar:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
        rating: 5.0,
        dateText: '2 weeks ago',
        comment:
            'Outstanding stay! The place was spotless, host was very warm, and the food was delicious. Highly recommended!',
      ),
      ReviewModel(
        id: 'r2',
        userName: 'Priya Sharma',
        userAvatar:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
        rating: 4.8,
        dateText: '1 month ago',
        comment:
            'Great location and fast WiFi. Perfect for remote work and a weekend getaway.',
      ),
      ReviewModel(
        id: 'r3',
        userName: 'Devraj Singh',
        userAvatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
        rating: 4.9,
        dateText: '2 months ago',
        comment:
            'Super peaceful environment. Smooth check-in with prompt host communication.',
      ),
    ];
  }

  @override
  Future<bool> toggleFavorite(String stayId, [bool? currentFavorite]) async {
    _initFavorites();
    final bool isFav = _favoriteIds.contains(stayId);
    final bool newFav = currentFavorite != null ? !currentFavorite : !isFav;
    if (newFav) {
      _favoriteIds.add(stayId);
    } else {
      _favoriteIds.remove(stayId);
    }
    _persistFavorites();
    return newFav;
  }
}
