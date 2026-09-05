import '../../models/rental_addon_model.dart';
import '../../models/rental_booking_model.dart';
import '../../models/rental_city_model.dart';
import '../../models/rental_pricing_model.dart';
import '../../models/rental_review_model.dart';
import '../../models/vehicle_feature_model.dart';
import '../../models/vehicle_model.dart';
import '../../models/vehicle_specification_model.dart';
import '../../models/vehicle_variant_model.dart';

/// Campaign model for the hero banner carousel
class RentalBannerCampaign {
  final String id;
  final String title;
  final String subtitle;
  final String badgeText;
  final String ctaText;
  final String imageUrl;
  final String? vehicleTypeId;

  const RentalBannerCampaign({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.ctaText,
    required this.imageUrl,
    this.vehicleTypeId,
  });
}

/// Comprehensive realistic mock data source for the SewaSetu Rental module.
class RentalMockDatasource {
  static final List<RentalCityModel> cities = [
    const RentalCityModel(
      id: 'guwahati',
      name: 'Guwahati',
      state: 'Assam',
      image:
          'https://images.unsplash.com/photo-1596401057633-54a8fe8ef647?auto=format&fit=crop&w=800&q=80',
      description:
          'Gateway to Northeast India. Rent premium SUVs, cruisers, and city cars for your Meghalaya and Kaziranga road trips.',
      shortDescription: 'Gateway to Northeast India',
      isAvailable: true,
      isFeatured: true,
      launchStatus: RentalCityLaunchStatus.available,
      vehicleCount: 15,
      latitude: 26.1445,
      longitude: 91.7362,
    ),
    const RentalCityModel(
      id: 'dibrugarh',
      name: 'Dibrugarh',
      state: 'Assam',
      image:
          'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80',
      description:
          'The Tea City of India. Explore Upper Assam tea gardens and riverbanks with dependable bikes and SUVs.',
      shortDescription: 'Tea City of India',
      isAvailable: true,
      isFeatured: false,
      launchStatus: RentalCityLaunchStatus.available,
      vehicleCount: 8,
      latitude: 27.4728,
      longitude: 94.9120,
    ),
    const RentalCityModel(
      id: 'kolkata',
      name: 'Kolkata',
      state: 'West Bengal',
      image:
          'https://images.unsplash.com/photo-1558431382-27e303142255?auto=format&fit=crop&w=800&q=80',
      description:
          'The City of Joy. Drive through heritage streets, coastal Digha routes, or modern New Town boulevards.',
      shortDescription: 'The City of Joy',
      isAvailable: true,
      isFeatured: true,
      launchStatus: RentalCityLaunchStatus.available,
      vehicleCount: 20,
      latitude: 22.5726,
      longitude: 88.3639,
    ),
    const RentalCityModel(
      id: 'patna',
      name: 'Patna',
      state: 'Bihar',
      image:
          'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?auto=format&fit=crop&w=800&q=80',
      description:
          'Historic riverside capital. Affordable hatchbacks, executive sedans, and high-mileage bikes for city and intercity travel.',
      shortDescription: 'Historic riverside capital',
      isAvailable: true,
      isFeatured: false,
      launchStatus: RentalCityLaunchStatus.available,
      vehicleCount: 12,
      latitude: 25.5941,
      longitude: 85.1376,
    ),
    const RentalCityModel(
      id: 'shillong',
      name: 'Shillong',
      state: 'Meghalaya',
      image:
          'https://images.unsplash.com/photo-1626014303757-65644775be7f?auto=format&fit=crop&w=800&q=80',
      description:
          'Scotland of the East. Rolling hills and misty roads. Service launching soon with curated mountain-ready 4x4s and bikes.',
      shortDescription: 'Launching in Phase 2',
      isAvailable: false,
      isFeatured: true,
      launchStatus: RentalCityLaunchStatus.comingSoon,
      vehicleCount: 0,
      latitude: 25.5788,
      longitude: 91.8933,
    ),
    const RentalCityModel(
      id: 'ranchi',
      name: 'Ranchi',
      state: 'Jharkhand',
      image:
          'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?auto=format&fit=crop&w=800&q=80',
      description:
          'City of Waterfalls. Service launching soon for waterfall trails and scenic highway drives.',
      shortDescription: 'Launching Soon',
      isAvailable: false,
      isFeatured: false,
      launchStatus: RentalCityLaunchStatus.comingSoon,
      vehicleCount: 0,
      latitude: 23.3441,
      longitude: 85.3096,
    ),
    const RentalCityModel(
      id: 'bhubaneswar',
      name: 'Bhubaneswar',
      state: 'Odisha',
      image:
          'https://images.unsplash.com/photo-1599818817758-c2b647bb839c?auto=format&fit=crop&w=800&q=80',
      description:
          'Temple City of India. Coastal Konark and Puri corridors launching in the upcoming expansion.',
      shortDescription: 'Launching Soon',
      isAvailable: false,
      isFeatured: false,
      launchStatus: RentalCityLaunchStatus.comingSoon,
      vehicleCount: 0,
      latitude: 20.2961,
      longitude: 85.8245,
    ),
  ];

  static final List<RentalBannerCampaign> campaigns = [
    const RentalBannerCampaign(
      id: 'cmp_weekend',
      title: 'Weekend Escape',
      subtitle: 'Save up to 25% on your mountain road trip with premium 4x4s',
      badgeText: 'SPECIAL OFFER',
      ctaText: 'Explore SUVs',
      imageUrl:
          'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1200&q=80',
      vehicleTypeId: 'suv',
    ),
    const RentalBannerCampaign(
      id: 'cmp_electric',
      title: 'Electric Future',
      subtitle: 'Zero emissions, instant torque. Tata Nexon EV & Ather 450X',
      badgeText: 'GREEN DRIVE',
      ctaText: 'View EVs',
      imageUrl:
          'https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=1200&q=80',
      vehicleTypeId: 'electric',
    ),
    const RentalBannerCampaign(
      id: 'cmp_bikes',
      title: 'Ride Pure Freedom',
      subtitle: 'Rent Royal Enfield Classic 350 & Himalayan with helmets included',
      badgeText: 'POPULAR',
      ctaText: 'Rent a Bike',
      imageUrl:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=1200&q=80',
      vehicleTypeId: 'bike',
    ),
    const RentalBannerCampaign(
      id: 'cmp_luxury',
      title: 'Drive in Distinction',
      subtitle: 'Arrive in style with BMW 3 Series Gran Limousine & Mercedes-Benz',
      badgeText: 'PREMIUM',
      ctaText: 'Explore Luxury',
      imageUrl:
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=1200&q=80',
      vehicleTypeId: 'luxury',
    ),
  ];

  static final List<VehicleModel> vehicles = [
    // 1. Mahindra Thar 4x4
    const VehicleModel(
      id: 'veh_thar_01',
      brand: 'Mahindra',
      name: 'Thar 4x4 Hard Top',
      model: 'LX Diesel AT',
      vehicleType: RentalVehicleType.suv,
      category: 'SUV',
      images: [
        'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1511919884226-fd3cad34687c?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'The undisputed off-road icon. Equipped with 4-wheel drive, high ground clearance, convertible rugged appeal, and modern comforts. Ideal for Meghalaya and hill terrains.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata'],
      rating: 4.9,
      reviewCount: 148,
      pricePerHour: 220,
      pricePerDay: 3499,
      securityDeposit: 2000,
      transmission: 'Automatic',
      fuelType: 'Diesel',
      seats: 4,
      mileage: '15 km/l',
      enginePower: '2.2L mHawk Diesel (130 bhp)',
      topSpeedKmH: 155,
      year: 2024,
      freeCancellationHours: 12,
      isAvailable: true,
      isFeatured: true,
      isPopular: true,
      isPremium: true,
      features: [
        VehicleFeatureModel(
          id: 'ft_4wd',
          name: '4x4 Shift-on-the-fly',
          icon: 'terrain',
          category: 'safety',
        ),
        VehicleFeatureModel(
          id: 'ft_screen',
          name: '7" Touchscreen Navigation',
          icon: 'smart_screen',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_rollcage',
          name: 'Built-in Roll Cage',
          icon: 'security',
          category: 'safety',
        ),
        VehicleFeatureModel(
          id: 'ft_ac',
          name: 'Climate Control',
          icon: 'ac_unit',
          category: 'comfort',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'trans',
          label: 'Transmission',
          value: '6-Speed Torque Converter',
          iconName: 'settings',
        ),
        VehicleSpecificationModel(
          key: 'fuel',
          label: 'Fuel Type',
          value: 'Diesel (57L Tank)',
          iconName: 'local_gas_station',
        ),
        VehicleSpecificationModel(
          key: 'ground_clearance',
          label: 'Ground Clearance',
          value: '226 mm',
          iconName: 'height',
        ),
        VehicleSpecificationModel(
          key: 'boot',
          label: 'Luggage Capacity',
          value: '3 Small Bags',
          iconName: 'luggage',
        ),
      ],
      variants: [
        VehicleVariantModel(
          id: 'var_thar_black',
          name: 'Napoli Black',
          color: 'Black',
          colorCode: '#1A1A1A',
          transmission: 'Automatic',
          fuelType: 'Diesel',
          pricePerDay: 3499,
        ),
        VehicleVariantModel(
          id: 'var_thar_red',
          name: 'Rage Red',
          color: 'Red',
          colorCode: '#D32F2F',
          transmission: 'Manual',
          fuelType: 'Diesel',
          pricePerDay: 3199,
        ),
      ],
    ),

    // 2. Hyundai Creta SX
    const VehicleModel(
      id: 'veh_creta_02',
      brand: 'Hyundai',
      name: 'Creta SX (O)',
      model: '1.5 Petrol IVT',
      vehicleType: RentalVehicleType.suv,
      category: 'SUV',
      images: [
        'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1502877338535-766e1452684a?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Spacious, ultra-refined 5-seater urban SUV. Panoramic sunroof, ventilated seats, Bose sound system, and smooth automatic transmission.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata', 'patna'],
      rating: 4.8,
      reviewCount: 215,
      pricePerHour: 180,
      pricePerDay: 2699,
      securityDeposit: 1500,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      seats: 5,
      mileage: '17 km/l',
      enginePower: '1.5L MPi (115 bhp)',
      topSpeedKmH: 170,
      year: 2024,
      freeCancellationHours: 6,
      isAvailable: true,
      isFeatured: true,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_sunroof',
          name: 'Panoramic Sunroof',
          icon: 'wb_sunny',
          category: 'comfort',
        ),
        VehicleFeatureModel(
          id: 'ft_ventilated',
          name: 'Ventilated Front Seats',
          icon: 'air',
          category: 'comfort',
        ),
        VehicleFeatureModel(
          id: 'ft_adas',
          name: 'Level 2 ADAS Safety',
          icon: 'shield',
          category: 'safety',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'trans',
          label: 'Transmission',
          value: 'Intelligent Variable IVT',
          iconName: 'settings',
        ),
        VehicleSpecificationModel(
          key: 'fuel',
          label: 'Fuel Type',
          value: 'Petrol (50L Tank)',
          iconName: 'local_gas_station',
        ),
        VehicleSpecificationModel(
          key: 'boot',
          label: 'Boot Space',
          value: '433 Liters (3 Suitcases)',
          iconName: 'luggage',
        ),
      ],
    ),

    // 3. Tata Nexon EV Empowered
    const VehicleModel(
      id: 'veh_nexon_ev_03',
      brand: 'Tata',
      name: 'Nexon EV Long Range',
      model: 'Empowered+ 40.5 kWh',
      vehicleType: RentalVehicleType.electric,
      category: 'Electric SUV',
      images: [
        'https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Experience the zero-emission electric rush. 465 km certified ARAI range, ultra-silent cabin, 360-degree camera, and fast-charging enabled at all SewaSetu hubs.',
      cityIds: ['guwahati', 'kolkata', 'patna'],
      rating: 4.9,
      reviewCount: 92,
      pricePerHour: 190,
      pricePerDay: 2899,
      securityDeposit: 2000,
      transmission: 'Automatic',
      fuelType: 'Electric',
      seats: 5,
      mileage: '465 km Range',
      enginePower: 'Permanent Magnet Motor (142 bhp)',
      topSpeedKmH: 150,
      year: 2024,
      freeCancellationHours: 6,
      isAvailable: true,
      isFeatured: true,
      isPopular: false,
      isPremium: true,
      features: [
        VehicleFeatureModel(
          id: 'ft_fastcharge',
          name: 'CCS2 Fast Charging (10-80% in 56m)',
          icon: 'bolt',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_v2v',
          name: 'V2L Power Bank Mode',
          icon: 'power',
          category: 'tech',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'battery',
          label: 'Battery Pack',
          value: '40.5 kWh High Density',
          iconName: 'battery_charging_full',
        ),
        VehicleSpecificationModel(
          key: 'range',
          label: 'Real-world Range',
          value: '310 - 340 km',
          iconName: 'speed',
        ),
      ],
    ),

    // 4. BMW 3 Series Gran Limousine
    const VehicleModel(
      id: 'veh_bmw_04',
      brand: 'BMW',
      name: '3 Series Gran Limousine',
      model: '330Li M Sport',
      vehicleType: RentalVehicleType.luxury,
      category: 'Luxury Sedan',
      images: [
        'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1580273916550-e323be2ae537?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'The pinnacle of executive luxury and sheer driving pleasure. Extended wheelbase for first-class rear legroom, Harmon Kardon audio, and twin-power turbo performance.',
      cityIds: ['guwahati', 'kolkata'],
      rating: 5.0,
      reviewCount: 64,
      pricePerHour: 550,
      pricePerDay: 7999,
      securityDeposit: 5000,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      seats: 5,
      mileage: '15.3 km/l',
      enginePower: '2.0L TwinPower Turbo (258 bhp)',
      topSpeedKmH: 250,
      year: 2024,
      freeCancellationHours: 24,
      isAvailable: true,
      isFeatured: true,
      isPopular: false,
      isPremium: true,
      features: [
        VehicleFeatureModel(
          id: 'ft_hk',
          name: 'Harman Kardon Surround Sound',
          icon: 'speaker',
          category: 'comfort',
        ),
        VehicleFeatureModel(
          id: 'ft_hud',
          name: 'Head-up Display',
          icon: 'visibility',
          category: 'tech',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'accel',
          label: '0 - 100 km/h',
          value: '6.2 Seconds',
          iconName: 'timer',
        ),
        VehicleSpecificationModel(
          key: 'trans',
          label: 'Gearbox',
          value: '8-Speed Steptronic Sport',
          iconName: 'settings',
        ),
      ],
    ),

    // 5. Toyota Innova Hycross
    const VehicleModel(
      id: 'veh_innova_05',
      brand: 'Toyota',
      name: 'Innova Hycross Strong Hybrid',
      model: 'ZX (O) 7-Seater',
      vehicleType: RentalVehicleType.car,
      category: 'Premium MUV',
      images: [
        'https://images.unsplash.com/photo-1542282088-72c9c27ed0cd?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'The ultimate family and VIP road trip machine. Ottoman captain chairs, dual-zone AC, unmatched reliability, and hybrid fuel efficiency for long tours across Assam and Bengal.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata', 'patna'],
      rating: 4.9,
      reviewCount: 310,
      pricePerHour: 240,
      pricePerDay: 3799,
      securityDeposit: 2500,
      transmission: 'Automatic',
      fuelType: 'Hybrid',
      seats: 7,
      mileage: '23.2 km/l',
      enginePower: '2.0L Self-Charging Hybrid (184 bhp)',
      topSpeedKmH: 175,
      year: 2024,
      freeCancellationHours: 12,
      isAvailable: true,
      isFeatured: false,
      isPopular: true,
      isPremium: true,
      features: [
        VehicleFeatureModel(
          id: 'ft_ottoman',
          name: 'Powered Ottoman Captain Seats',
          icon: 'airline_seat_recline_extra',
          category: 'comfort',
        ),
        VehicleFeatureModel(
          id: 'ft_dual_ac',
          name: 'Triple Zone Climate Control',
          icon: 'ac_unit',
          category: 'comfort',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'seats',
          label: 'Seating Capacity',
          value: '7 Captain Config',
          iconName: 'people',
        ),
        VehicleSpecificationModel(
          key: 'efficiency',
          label: 'Mileage',
          value: '23.24 km/l Hybrid',
          iconName: 'eco',
        ),
      ],
    ),

    // 6. Maruti Suzuki Swift ZXi
    const VehicleModel(
      id: 'veh_swift_06',
      brand: 'Maruti Suzuki',
      name: 'Swift ZXi+',
      model: '1.2 DualJet AMT',
      vehicleType: RentalVehicleType.car,
      category: 'Hatchback',
      images: [
        'https://images.unsplash.com/photo-1590362891991-f776e747a588?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Agile, peppy, and immensely economical. Effortless city parking, cruise control, keyless entry, and 22+ km/l mileage.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata', 'patna'],
      rating: 4.7,
      reviewCount: 420,
      pricePerHour: 99,
      pricePerDay: 1499,
      securityDeposit: 1000,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      seats: 5,
      mileage: '22.5 km/l',
      enginePower: '1.2L Z-Series Petrol (82 bhp)',
      topSpeedKmH: 160,
      year: 2024,
      freeCancellationHours: 4,
      isAvailable: true,
      isFeatured: false,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_apple_carplay',
          name: 'Wireless Apple CarPlay & Android Auto',
          icon: 'phone_android',
          category: 'tech',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'economy',
          label: 'Fuel Economy',
          value: '22.5 km/l',
          iconName: 'local_gas_station',
        ),
      ],
    ),

    // 7. Royal Enfield Himalayan 450
    const VehicleModel(
      id: 'veh_himalayan_07',
      brand: 'Royal Enfield',
      name: 'Himalayan 450 Sherpa',
      model: 'Summit Hanle Black',
      vehicleType: RentalVehicleType.bike,
      category: 'Adventure Bike',
      images: [
        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Built for all roads and no roads. Liquid-cooled 452cc Sherpa engine, 200mm suspension travel, Google Maps integrated Tripper Dash, and switchable rear ABS.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata'],
      rating: 4.9,
      reviewCount: 180,
      pricePerHour: 110,
      pricePerDay: 1699,
      securityDeposit: 1000,
      transmission: 'Manual',
      fuelType: 'Petrol',
      seats: 2,
      mileage: '30 km/l',
      enginePower: '452cc Liquid-Cooled (40 bhp)',
      topSpeedKmH: 155,
      year: 2024,
      freeCancellationHours: 6,
      isAvailable: true,
      isFeatured: true,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_tripper',
          name: 'TFT Full-map Tripper Dash',
          icon: 'map',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_helmet',
          name: '1x DOT Certified Helmet Included',
          icon: 'sports_motorsports',
          category: 'safety',
        ),
        VehicleFeatureModel(
          id: 'ft_panniers',
          name: 'Luggage Carrier Rack Fitted',
          icon: 'inventory_2',
          category: 'convenience',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'suspension',
          label: 'Ground Clearance',
          value: '230 mm',
          iconName: 'height',
        ),
        VehicleSpecificationModel(
          key: 'fuel',
          label: 'Tank Capacity',
          value: '17 Liters (450+ km Range)',
          iconName: 'local_gas_station',
        ),
      ],
    ),

    // 8. Royal Enfield Classic 350
    const VehicleModel(
      id: 'veh_classic_08',
      brand: 'Royal Enfield',
      name: 'Classic 350 Reborn',
      model: 'Stealth Black Dual Channel',
      vehicleType: RentalVehicleType.bike,
      category: 'Cruiser',
      images: [
        'https://images.unsplash.com/photo-1599819811279-d5ad9cccf838?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Timeless design, signature thump, and buttery-smooth J-series engine. The premier cruiser choice for highway cruising and city boulevard rides.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata', 'patna'],
      rating: 4.8,
      reviewCount: 290,
      pricePerHour: 80,
      pricePerDay: 1199,
      securityDeposit: 1000,
      transmission: 'Manual',
      fuelType: 'Petrol',
      seats: 2,
      mileage: '36 km/l',
      enginePower: '349cc Single-Cylinder (20.2 bhp)',
      topSpeedKmH: 120,
      year: 2024,
      freeCancellationHours: 6,
      isAvailable: true,
      isFeatured: false,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_helmet',
          name: '1x ISI Certified Helmet Included',
          icon: 'sports_motorsports',
          category: 'safety',
        ),
        VehicleFeatureModel(
          id: 'ft_abs',
          name: 'Dual Channel ABS',
          icon: 'shield',
          category: 'safety',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'engine',
          label: 'Engine',
          value: '349cc J-Platform OHC',
          iconName: 'build',
        ),
      ],
    ),

    // 9. Ather 450X Gen 3
    const VehicleModel(
      id: 'veh_ather_09',
      brand: 'Ather',
      name: '450X Gen 3',
      model: '3.7 kWh Warp Mode',
      vehicleType: RentalVehicleType.scooter,
      category: 'Electric Scooter',
      images: [
        'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Smartest scooter on the road. Warp mode 0-40 in 3.3s, onboard Google Maps, auto hold hill assist, and zero petrol expense. Perfect for city exploration.',
      cityIds: ['guwahati', 'kolkata', 'patna'],
      rating: 4.9,
      reviewCount: 165,
      pricePerHour: 55,
      pricePerDay: 699,
      securityDeposit: 500,
      transmission: 'Automatic',
      fuelType: 'Electric',
      seats: 2,
      mileage: '110 km TrueRange',
      enginePower: '6.4 kW PMSM Motor (26 Nm)',
      topSpeedKmH: 90,
      year: 2024,
      freeCancellationHours: 4,
      isAvailable: true,
      isFeatured: true,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_touch',
          name: '7" Water-Resistant Touchscreen',
          icon: 'touch_app',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_reverse',
          name: 'Reverse Assist Park Mode',
          icon: 'swap_horiz',
          category: 'convenience',
        ),
        VehicleFeatureModel(
          id: 'ft_helmet',
          name: '1x Helmet Provided',
          icon: 'sports_motorsports',
          category: 'safety',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'range',
          label: 'TrueRange',
          value: '105 - 110 km per charge',
          iconName: 'battery_charging_full',
        ),
        VehicleSpecificationModel(
          key: 'accel',
          label: '0 - 40 km/h',
          value: '3.3 Seconds',
          iconName: 'speed',
        ),
      ],
    ),

    // 10. Honda Activa 6G
    const VehicleModel(
      id: 'veh_activa_10',
      brand: 'Honda',
      name: 'Activa 6G Premium',
      model: '110cc Smart Key',
      vehicleType: RentalVehicleType.scooter,
      category: 'Commuter Scooter',
      images: [
        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Indias most trusted, hassle-free automatic scooter. Smart Key with remote lock/unlock, silent ACG starter, and unmatched convenience for everyday city errands.',
      cityIds: ['guwahati', 'dibrugarh', 'kolkata', 'patna'],
      rating: 4.7,
      reviewCount: 512,
      pricePerHour: 45,
      pricePerDay: 499,
      securityDeposit: 500,
      transmission: 'Automatic',
      fuelType: 'Petrol',
      seats: 2,
      mileage: '55 km/l',
      enginePower: '109.5cc eSP (7.8 bhp)',
      topSpeedKmH: 85,
      year: 2024,
      freeCancellationHours: 4,
      isAvailable: true,
      isFeatured: false,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_helmet',
          name: '1x Helmet Provided Free',
          icon: 'sports_motorsports',
          category: 'safety',
        ),
        VehicleFeatureModel(
          id: 'ft_keyless',
          name: 'Smart Keyless Ignition',
          icon: 'key',
          category: 'convenience',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'mileage',
          label: 'Mileage',
          value: '55 km/l eSP Tech',
          iconName: 'local_gas_station',
        ),
      ],
    ),

    // 11. Mercedes-Benz GLA
    const VehicleModel(
      id: 'veh_gla_11',
      brand: 'Mercedes-Benz',
      name: 'GLA 220d 4MATIC',
      model: 'AMG Line',
      vehicleType: RentalVehicleType.luxury,
      category: 'Luxury SUV',
      images: [
        'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'Sporty, commanding, and impeccably equipped. All-wheel drive 4MATIC confidence, 64-color ambient lighting, MBUX digital cockpit, and active brake assist.',
      cityIds: ['kolkata', 'guwahati'],
      rating: 5.0,
      reviewCount: 48,
      pricePerHour: 600,
      pricePerDay: 8499,
      securityDeposit: 5000,
      transmission: 'Automatic',
      fuelType: 'Diesel',
      seats: 5,
      mileage: '16.5 km/l',
      enginePower: '2.0L Turbo Diesel (190 bhp)',
      topSpeedKmH: 220,
      year: 2024,
      freeCancellationHours: 24,
      isAvailable: true,
      isFeatured: false,
      isPopular: false,
      isPremium: true,
      features: [
        VehicleFeatureModel(
          id: 'ft_mbux',
          name: 'MBUX Dual 10.25" Screens',
          icon: 'desktop_windows',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_4matic',
          name: '4MATIC All-Wheel Drive',
          icon: 'all_inclusive',
          category: 'safety',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'top_speed',
          label: 'Top Speed',
          value: '222 km/h',
          iconName: 'speed',
        ),
      ],
    ),

    // 12. KTM Duke 390
    const VehicleModel(
      id: 'veh_duke_12',
      brand: 'KTM',
      name: 'Duke 390 Gen 3',
      model: 'Electronic Orange',
      vehicleType: RentalVehicleType.bike,
      category: 'Sports Bike',
      images: [
        'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=1000&q=80',
      ],
      description:
          'The Corner Rocket. 46 bhp LC4c powerhouse, bi-directional quickshifter, launch control, cornering ABS, and adjustable WP suspension.',
      cityIds: ['guwahati', 'kolkata', 'patna'],
      rating: 4.9,
      reviewCount: 110,
      pricePerHour: 140,
      pricePerDay: 1999,
      securityDeposit: 1500,
      transmission: 'Manual',
      fuelType: 'Petrol',
      seats: 2,
      mileage: '28 km/l',
      enginePower: '399cc Liquid-Cooled (46 bhp)',
      topSpeedKmH: 170,
      year: 2024,
      freeCancellationHours: 6,
      isAvailable: true,
      isFeatured: false,
      isPopular: true,
      isPremium: false,
      features: [
        VehicleFeatureModel(
          id: 'ft_quickshifter',
          name: 'Quickshifter+ Bi-directional',
          icon: 'swap_calls',
          category: 'tech',
        ),
        VehicleFeatureModel(
          id: 'ft_helmet',
          name: '1x Premium Helmet Included',
          icon: 'sports_motorsports',
          category: 'safety',
        ),
      ],
      specifications: [
        VehicleSpecificationModel(
          key: 'power',
          label: 'Power to Weight',
          value: '46 bhp @ 165 kg',
          iconName: 'bolt',
        ),
      ],
    ),
  ];

  static final List<RentalAddonModel> addons = [
    const RentalAddonModel(
      id: 'addon_insurance_zero',
      name: 'Zero-Liability Protection Shield',
      description:
          'Complete bumper-to-bumper damage protection with zero out-of-pocket liability for accidental damages.',
      pricePerDay: 299,
      oneTimeFee: 0,
      iconName: 'verified_user',
      applicableVehicleTypes: [
        RentalVehicleType.all,
        RentalVehicleType.car,
        RentalVehicleType.suv,
        RentalVehicleType.luxury,
        RentalVehicleType.electric,
      ],
      isRequired: false,
      isSelected: true, // Recommended
    ),
    const RentalAddonModel(
      id: 'addon_doorstep',
      name: 'Doorstep Delivery & Pickup',
      description:
          'Our verified executive delivers the vehicle directly to your hotel, airport, or residence and picks it up upon return.',
      pricePerDay: 0,
      oneTimeFee: 399,
      iconName: 'local_shipping',
      applicableVehicleTypes: [RentalVehicleType.all],
      isRequired: false,
      isSelected: false,
    ),
    const RentalAddonModel(
      id: 'addon_helmet_extra',
      name: 'Pillion Rider Extra Helmet',
      description:
          '1 extra ISI/DOT certified sanitised full-face helmet for your pillion companion.',
      pricePerDay: 49,
      oneTimeFee: 0,
      iconName: 'sports_motorsports',
      applicableVehicleTypes: [RentalVehicleType.bike, RentalVehicleType.scooter],
      isRequired: false,
      isSelected: false,
    ),
    const RentalAddonModel(
      id: 'addon_riding_jacket',
      name: 'All-Weather Riding Gear Kit',
      description:
          'CE-Level 2 armored riding jacket and breathable tactile touchscreen gloves for mountain touring.',
      pricePerDay: 199,
      oneTimeFee: 0,
      iconName: 'shield',
      applicableVehicleTypes: [RentalVehicleType.bike],
      isRequired: false,
      isSelected: false,
    ),
    const RentalAddonModel(
      id: 'addon_child_seat',
      name: 'ISOFIX Child Safety Seat',
      description:
          'Cushioned, rear or forward facing child seat meeting European safety standard ECE R44/04.',
      pricePerDay: 149,
      oneTimeFee: 0,
      iconName: 'child_friendly',
      applicableVehicleTypes: [
        RentalVehicleType.car,
        RentalVehicleType.suv,
        RentalVehicleType.luxury,
      ],
      isRequired: false,
      isSelected: false,
    ),
    const RentalAddonModel(
      id: 'addon_extra_driver',
      name: 'Additional Authorized Driver',
      description:
          'Add a secondary verified driver to the rental policy so you can share driving duties on long journeys.',
      pricePerDay: 99,
      oneTimeFee: 0,
      iconName: 'group_add',
      applicableVehicleTypes: [
        RentalVehicleType.car,
        RentalVehicleType.suv,
        RentalVehicleType.luxury,
        RentalVehicleType.electric,
      ],
      isRequired: false,
      isSelected: false,
    ),
    const RentalAddonModel(
      id: 'addon_gps_mount',
      name: 'Vibration Dampening Phone Mount & Fast Charger',
      description:
          'QuadLock-compatible motorcycle phone mount with fast USB charging harness.',
      pricePerDay: 39,
      oneTimeFee: 0,
      iconName: 'phone_android',
      applicableVehicleTypes: [RentalVehicleType.bike, RentalVehicleType.scooter],
      isRequired: false,
      isSelected: false,
    ),
  ];

  static final List<RentalReviewModel> reviews = [
    RentalReviewModel(
      id: 'rev_01',
      userName: 'Pranab Bora',
      userAvatar:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80',
      rating: 5.0,
      date: DateTime.now().subtract(const Duration(days: 4)),
      comment:
          'Booked the Thar 4x4 from Guwahati for a 4-day trip to Cherrapunji and Dawki. Car was immaculate, full tank, zero paperwork friction. Conquering Meghalaya foggy hills was effortless. Best rental in Assam!',
      verifiedRental: true,
      vehicleModelName: 'Mahindra Thar 4x4',
      tripPhoto:
          'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=900&q=80',
      tripRoute: 'Guwahati ➔ Cherrapunji & Dawki',
      cityName: 'Guwahati',
      duration: '4-Day Road Trip',
    ),
    RentalReviewModel(
      id: 'rev_02',
      userName: 'Rhea Sengupta',
      userAvatar:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=250&q=80',
      rating: 5.0,
      date: DateTime.now().subtract(const Duration(days: 9)),
      comment:
          'Rented the BMW 3 Series for a premier wedding weekend in Kolkata. Doorstep delivery at Salt Lake was right on the dot. Showroom condition, velvet smooth drive, and zero security deposit fuss. Truly 5-star experience!',
      verifiedRental: true,
      vehicleModelName: 'BMW 3 Series Gran Limousine',
      tripPhoto:
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=900&q=80',
      tripRoute: 'Kolkata ➔ Mandarmani Coast',
      cityName: 'Kolkata',
      duration: '3-Day Luxury Getaway',
    ),
    RentalReviewModel(
      id: 'rev_03',
      userName: 'Amitav Das',
      userAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80',
      rating: 4.9,
      date: DateTime.now().subtract(const Duration(days: 14)),
      comment:
          'Himalayan 450 tackled the tea garden trails and river bridges like a dream. Sanitized helmet and puncture kit provided saved our peace of mind. Best bike rental experience in Upper Assam!',
      verifiedRental: true,
      vehicleModelName: 'Royal Enfield Himalayan 450',
      tripPhoto:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=900&q=80',
      tripRoute: 'Dibrugarh ➔ Roing Valley Circuit',
      cityName: 'Dibrugarh',
      duration: '5-Day Explorer Tour',
    ),
    RentalReviewModel(
      id: 'rev_04',
      userName: 'Sneha Roy',
      userAvatar:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80',
      rating: 5.0,
      date: DateTime.now().subtract(const Duration(days: 20)),
      comment:
          'Quiet, powerful, and astonishingly economical! Took Nexon EV on the expressway to Kaziranga. Battery range easily covered the journey, and the AC kept us fresh all day. Highly recommended!',
      verifiedRental: true,
      vehicleModelName: 'Tata Nexon EV Max',
      tripPhoto:
          'https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=900&q=80',
      tripRoute: 'Guwahati ➔ Kaziranga National Park',
      cityName: 'Guwahati',
      duration: '2-Day Eco Safari',
    ),
    RentalReviewModel(
      id: 'rev_05',
      userName: 'Vikramaditya & Family',
      userAvatar:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80',
      rating: 4.9,
      date: DateTime.now().subtract(const Duration(days: 25)),
      comment:
          'Spacious boot accommodated all our family luggage. Child safety seat was fitted beforehand as requested. Transparent fuel policy with zero hidden charges. Made our Bihar heritage road trip seamless!',
      verifiedRental: true,
      vehicleModelName: 'Hyundai Creta SX',
      tripPhoto:
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=900&q=80',
      tripRoute: 'Patna ➔ Nalanda & Rajgir Circuit',
      cityName: 'Patna',
      duration: '3-Day Heritage Tour',
    ),
  ];

  /// Initial sample active booking for demonstration
  static final List<RentalBookingModel> initialBookings = [
    RentalBookingModel(
      id: 'bk_sample_01',
      bookingNumber: 'SW-RNT-2026-9842',
      userId: 'usr_guest_01',
      vehicleId: 'veh_thar_01',
      vehicle: vehicles.first,
      cityId: 'guwahati',
      cityName: 'Guwahati',
      pickupDateTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
      returnDateTime: DateTime.now().add(const Duration(days: 4, hours: 2)),
      pickupLocation: 'Guwahati Airport Hub (GAU)',
      returnLocation: 'Guwahati Airport Hub (GAU)',
      isDoorstepDelivery: false,
      selectedAddons: [addons.first],
      pricing: RentalPricingModel.calculate(
        basePricePerDay: 3499,
        durationDays: 2,
        addonCost: 598,
        deliveryFee: 0,
        discountAmount: 200,
        securityDeposit: 2000,
      ),
      status: RentalBookingStatus.confirmed,
      paymentStatus: 'paid',
      driverName: 'SewaSetu Traveler',
      driverPhone: '+91 98765 43210',
      driverLicenseNumber: 'AS01 20230048123',
    ),
  ];
}
