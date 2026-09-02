import 'package:sewasetu/modules/stay/property/data/models/stay_model.dart';
import 'package:sewasetu/modules/stay/review/domain/entities/review_entity.dart';
import 'package:sewasetu/shared/enums/stay_type.dart';

/// Mock Remote Data Source for Stay domain with rich realistic properties.
abstract class IStayDataSource {
  Future<List<StayModel>> fetchStays();
  Future<StayModel> fetchStayById(String id);
  Future<List<StayReviewEntity>> fetchStayReviews(String stayId);
}

class StayMockDataSource implements IStayDataSource {
  final List<StayModel> _mockStays = [
    StayModel(
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
      host: const StayHostModel(
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
    StayModel(
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
      rating: 4.8,
      reviewsCount: 89,
      images: [
        'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['3 Meals Included', 'Air Conditioner', 'High-speed WiFi', 'Laundry Service', '24x7 Security', 'Study Desk'],
      isFeatured: true,
      isVerified: true,
      isFavorite: true,
      host: const StayHostModel(
        id: 'host-2',
        name: 'Bhaben Kalita',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
        isSuperHost: false,
        responseRate: '95%',
        joinedDate: 'Joined Aug 2022',
      ),
      availableRooms: 5,
      roomConfiguration: 'Single & Double Sharing Available',
      distanceText: '500m from Zoo Tiniali',
    ),
    StayModel(
      id: 'stay-3',
      title: 'Annapurna Executive Mess & Dining Hub',
      description:
          'Wholesome Assamese and North Indian monthly meal subscriptions with home delivery, custom diet plans, clean kitchen, and fresh ingredients.',
      stayType: StayType.mess,
      address: 'Uzan Bazar, Riverside Road',
      city: 'Guwahati, Assam',
      latitude: 26.1888,
      longitude: 91.7522,
      pricePerNight: 180,
      pricePerMonth: 3800,
      rating: 4.7,
      reviewsCount: 210,
      images: [
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
      ],
      amenities: ['Monthly Tiffin Delivery', 'Pure Veg & Non-Veg', 'Sunday Special Feast', 'RO Filtered Water'],
      isFeatured: false,
      isVerified: true,
      isFavorite: false,
      host: const StayHostModel(
        id: 'host-3',
        name: 'Ratul Sarmah',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
        isSuperHost: true,
        responseRate: '99%',
        joinedDate: 'Joined Jan 2020',
      ),
      availableRooms: 20,
      roomConfiguration: 'Daily Subscription / Dine-in',
      distanceText: '1.0 km from Guwahati Railway Station',
    ),
    StayModel(
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
      host: const StayHostModel(
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
    StayModel(
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
      host: const StayHostModel(
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
    StayModel(
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
      host: const StayHostModel(
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

  @override
  Future<List<StayModel>> fetchStays() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_mockStays);
  }

  @override
  Future<StayModel> fetchStayById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockStays.firstWhere(
      (stay) => stay.id == id,
      orElse: () => _mockStays.first,
    );
  }

  @override
  Future<List<StayReviewEntity>> fetchStayReviews(String stayId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      const StayReviewEntity(
        id: 'r1',
        userName: 'Rohan Bordoloi',
        userAvatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
        rating: 5.0,
        dateText: '2 weeks ago',
        comment: 'Outstanding stay! The place was spotless, host was very warm, and the food was delicious. Highly recommended!',
      ),
      const StayReviewEntity(
        id: 'r2',
        userName: 'Priya Sharma',
        userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
        rating: 4.8,
        dateText: '1 month ago',
        comment: 'Great location and fast WiFi. Perfect for remote work and a weekend getaway.',
      ),
      const StayReviewEntity(
        id: 'r3',
        userName: 'Devraj Singh',
        userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
        rating: 4.9,
        dateText: '2 months ago',
        comment: 'Super peaceful environment. Smooth check-in with prompt host communication.',
      ),
    ];
  }
}
