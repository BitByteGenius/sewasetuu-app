import '../models/service_category_item.dart';
import '../models/service_faq_item.dart';
import '../models/service_offer_item.dart';
import '../models/service_popular_item.dart';
import '../models/service_relocation_item.dart';
import '../models/service_review_item.dart';
import '../models/service_spotlight_item.dart';
import '../models/service_subcategory_item.dart';

/// Centralized mock data repository for the Services module.
/// Decoupled from UI to enable straightforward backend API integration.
class ServicesMockData {
  /// Top 4x2 quick-access service categories
  static const List<ServiceCategoryItem> headerCategories = [
    ServiceCategoryItem(
      id: 'cat_instant',
      title: 'Instant\nServices',
      imageUrl: 'https://images.unsplash.com/photo-1521791136064-7986c2920216?auto=format&fit=crop&w=400&q=80',
      badgeText: '15 mins',
      durationText: '15 mins',
      isInstant: true,
    ),
    ServiceCategoryItem(
      id: 'cat_cleaning',
      title: 'Home\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_packers',
      title: 'Packers\n& Movers',
      imageUrl: 'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_appliances',
      title: 'AC Service\n& Appliances',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_repairs',
      title: 'Plumbing,\nElectrician & Carpentry',
      imageUrl: 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_painting',
      title: 'Home\nPainting',
      imageUrl: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_legal',
      title: 'Home\nTuition',
      imageUrl: 'https://images.unsplash.com/photo-1450133064473-71024230f91b?auto=format&fit=crop&w=400&q=80',
    ),
    ServiceCategoryItem(
      id: 'cat_interiors',
      title: 'Home\nInteriors',
      imageUrl: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  /// Promotional carousel offers ("Offers for you")
  static const List<ServiceOfferItem> promotionalOffers = [
    ServiceOfferItem(
      id: 'offer_1',
      categoryTag: 'APPLIANCE REPAIR OFFER',
      discountHeadline: '10% Off on First Booking',
      discountHighlight: '10% Off',
      couponCode: 'NEWAPP50',
      imageUrl: 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?auto=format&fit=crop&w=400&q=80',
      infoTooltip: 'Valid on first appliance booking',
    ),
    ServiceOfferItem(
      id: 'offer_2',
      categoryTag: 'DEEP CLEANING SPECIAL',
      discountHeadline: 'Flat ₹200 Off on Full Home Clean',
      discountHighlight: 'Flat ₹200 Off',
      couponCode: 'CLEAN200',
      imageUrl: 'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?auto=format&fit=crop&w=400&q=80',
      infoTooltip: 'Minimum order value ₹999',
    ),
    ServiceOfferItem(
      id: 'offer_3',
      categoryTag: 'HOME PAINTING DEAL',
      discountHeadline: 'Upto 25% Off on Full Consultation',
      discountHighlight: 'Upto 25% Off',
      couponCode: 'PAINT25',
      imageUrl: 'https://images.unsplash.com/photo-1562259949-e8e7689d7828?auto=format&fit=crop&w=400&q=80',
      infoTooltip: 'Free site laser measurement',
    ),
  ];

  /// "In the Spotlight" featured service card
  static const ServiceSpotlightItem spotlightService = ServiceSpotlightItem(
    id: 'spotlight_cleaning',
    title: 'Machine Deep Cleaning',
    subtitle: 'Removes 99% of hidden dust',
    discountBadgeText: 'FLAT ₹200 OFF',
    promoCode: 'NEWCLEAN200',
    imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=800&q=80',
    badges: [
      SpotlightBadge(iconType: 'smile', label: '12L+ Happy\nCustomers'),
      SpotlightBadge(iconType: 'star', label: '4.9 Rated\nPartners'),
      SpotlightBadge(iconType: 'guarantee', label: 'Re-Clean\nGuarantee'),
    ],
    ctaText: 'Book Full Home Deep Cleaning',
  );

  /// Home Cleaning circular sub-categories
  static const List<ServiceSubcategoryItem> homeCleaningSubcategories = [
    ServiceSubcategoryItem(
      id: 'clean_bath',
      name: 'Bathroom\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'clean_kitchen',
      name: 'Kitchen\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'clean_premium',
      name: 'Premium\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'clean_sofa',
      name: 'Sofa\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'clean_full',
      name: 'Full Home\nCleaning',
      imageUrl: 'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?auto=format&fit=crop&w=300&q=80',
    ),
  ];

  /// Home Repair circular sub-categories
  static const List<ServiceSubcategoryItem> homeRepairSubcategories = [
    ServiceSubcategoryItem(
      id: 'repair_tap',
      name: 'Tap\nRepair',
      imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'repair_switchboard',
      name: 'Switch Board\nRepair',
      imageUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'repair_hinge',
      name: 'Cupboard\nHinge',
      imageUrl: 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'repair_geyser',
      name: 'Geyser\nRepair',
      imageUrl: 'https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=300&q=80',
    ),
    ServiceSubcategoryItem(
      id: 'repair_fan',
      name: 'Fan\nRepair',
      imageUrl: 'https://images.unsplash.com/photo-1615873968403-89e068629265?auto=format&fit=crop&w=300&q=80',
    ),
  ];

  /// 2x2 Popular Services grid
  static const List<ServicePopularItem> popularServices = [
    ServicePopularItem(
      id: 'pop_movers',
      title: 'Packers &\nMovers',
      imageUrl: 'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?auto=format&fit=crop&w=600&q=80',
      rating: 4.8,
    ),
    ServicePopularItem(
      id: 'pop_painting',
      title: 'Home Painting',
      imageUrl: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?auto=format&fit=crop&w=600&q=80',
      rating: 4.9,
    ),
    ServicePopularItem(
      id: 'pop_interiors',
      title: 'Home Interiors',
      imageUrl: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=600&q=80',
      rating: 4.8,
    ),
    ServicePopularItem(
      id: 'pop_wall_panelling',
      title: 'Wall Panelling',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=600&q=80',
      rating: 4.8,
    ),
  ];

  /// Relocation Simplified section
  static const List<ServiceRelocationItem> relocationOptions = [
    ServiceRelocationItem(
      id: 'relo_between',
      title: 'Between Cities',
      subtitle: 'Get Free Quote',
      imageUrl: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=400&q=80',
      badgeText: 'Free Quote',
    ),
    ServiceRelocationItem(
      id: 'relo_within',
      title: 'Within the City',
      subtitle: 'Upto 30% off',
      imageUrl: 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?auto=format&fit=crop&w=400&q=80',
      badgeText: 'Upto 30% off',
    ),
  ];

  /// Customer Reviews
  static const List<ServiceReviewItem> customerReviews = [
    ServiceReviewItem(
      id: 'rev_1',
      userName: 'Manoj Dua',
      userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
      serviceName: 'Home Cleaning Service',
      rating: 4.8,
      comment:
          'Painting and cleaning services from SewaSetu was something that I recently came to know about. Prices are really cheap since there is no middleman just reliable local experts.',
    ),
    ServiceReviewItem(
      id: 'rev_2',
      userName: 'Daniyal Khan',
      userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
      serviceName: 'Home Repair Service',
      rating: 4.7,
      comment:
          'These guys saved my weekend! I didn\'t have to spend hours searching for a trusted electrician and plumber. They took the hassle out of repairs completely.',
    ),
    ServiceReviewItem(
      id: 'rev_3',
      userName: 'Priya Sharma',
      userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
      serviceName: 'Packers & Movers',
      rating: 4.9,
      comment:
          'Relocated from Bengaluru to Hyderabad. The team packed every delicate item with multi-layer bubble wrap. Arrived on time without a single scratch!',
    ),
  ];

  /// Frequently Asked Questions
  static const List<ServiceFaqItem> faqItems = [
    ServiceFaqItem(
      id: 'faq_1',
      question: 'How to book a service on SewaSetu?',
      answer:
          'Select your desired service, choose your preferred date and time slot, and confirm your booking. A background-verified expert will be assigned immediately.',
    ),
    ServiceFaqItem(
      id: 'faq_2',
      question: 'Are all service professionals background-verified?',
      answer:
          'Yes, every partner goes through rigorous government ID verification, criminal background checks, and hands-on skill evaluations before onboarding.',
    ),
    ServiceFaqItem(
      id: 'faq_3',
      question: 'What is the Re-Clean Guarantee?',
      answer:
          'If you are not 100% satisfied with the cleanliness or quality of the completed job, we will send an expert to re-clean for free within 48 hours.',
    ),
    ServiceFaqItem(
      id: 'faq_4',
      question: 'Can I reschedule or cancel my service booking?',
      answer:
          'Yes, you can reschedule or cancel anytime up to 2 hours before the scheduled appointment through the My Bookings tab at zero cancellation fees.',
    ),
    ServiceFaqItem(
      id: 'faq_5',
      question: 'Are prices fixed or subject to change on arrival?',
      answer:
          'All standard prices and rates are completely upfront and transparent. No hidden charges will ever be levied by our service partners.',
    ),
  ];
}
