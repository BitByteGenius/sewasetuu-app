import 'package:flutter/material.dart';
import '../models/kitchen_cleaning_model.dart';

/// Repository / Mock data feed for Kitchen Cleaning module.
/// Decoupled for simple swap with REST / GraphQL backend APIs.
class KitchenCleaningData {
  /// Quick section navigation tabs
  static const List<KitchenCleaningNavCategory> navCategories = [
    KitchenCleaningNavCategory(
      id: 'occupied',
      title: 'Occupied\nKitchen\nCleaning',
      imageUrl:
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.kitchen_rounded,
    ),
    KitchenCleaningNavCategory(
      id: 'empty',
      title: 'Empty\nKitchen\nCleaning',
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.countertops_rounded,
    ),
    KitchenCleaningNavCategory(
      id: 'mini',
      title: 'Mini Services',
      imageUrl:
          'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=300&q=80',
      fallbackIcon: Icons.grid_view_rounded,
    ),
  ];

  /// Promotional offer banners
  static const List<KitchenCleaningOfferBanner> promoBanners = [
    KitchenCleaningOfferBanner(
      id: 'banner_1',
      tagText: 'EARLY BOOKING OFFER ⓘ',
      headline: 'Flat ₹200 off on Cleaning',
      promoCode: 'DIWALI200',
      imageUrl:
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=400&q=80',
    ),
    KitchenCleaningOfferBanner(
      id: 'banner_2',
      tagText: 'NEW USER DEAL ⓘ',
      headline: 'Flat 10% off For New Users',
      promoCode: 'NEWCLEAN10',
      imageUrl:
          'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  /// Ratings & Reviews breakdown
  static const RatingBreakdownModel ratingBreakdown = RatingBreakdownModel(
    avgRating: 4.77,
    totalCount: 192208,
    starCounts: {
      5: 176097,
      4: 5224,
      3: 2729,
      2: 2046,
      1: 6112,
    },
  );

  /// SewaSetu / Why Us feature steps
  static const List<String> whyUsFeatures = [
    '1. Use of top quality, specialised & safe chemicals',
    '2. Use of Mechanised and Professional Equipment',
    '3. Experienced, Trained and Background Verified Partners',
  ];

  /// Frequently Asked Questions
  static const List<KitchenFaqItem> faqItems = [
    KitchenFaqItem(
      id: 'faq_1',
      question:
          'Do kitchen cleaning services use eco-friendly or non-toxic cleaning products?',
      answer:
          'Absolutely! Our cleaning arsenal includes certified green products that effectively eliminate germs and grime. These biodegradable solutions ensure your family’s safety while protecting the environment from harmful chemical residues.',
    ),
    KitchenFaqItem(
      id: 'faq_2',
      question: 'Can I customise the cleaning tasks based on my specific needs?',
      answer:
          'Certainly! We understand every kitchen has unique requirements. Our flexible service packages allow you to prioritise specific areas, add extra tasks, or focus on particular appliances based on your household’s needs.',
    ),
    KitchenFaqItem(
      id: 'faq_3',
      question: 'Are kitchen cleaning services flexible with scheduling?',
      answer:
          'We pride ourselves on accommodating busy lifestyles with flexible timing options. Whether you need early morning, evening, or weekend slots, our scheduling system adapts to your convenience and availability preferences.',
    ),
    KitchenFaqItem(
      id: 'faq_4',
      question:
          'Are there specific cleaning products used by professional kitchen cleaning services?',
      answer:
          'Our professionals utilise industrial-grade, food-safe cleaning solutions specifically formulated for kitchen environments. These powerful yet gentle products tackle stubborn grease and bacteria while maintaining surface integrity and hygiene standards.',
    ),
    KitchenFaqItem(
      id: 'faq_5',
      question:
          'What areas of the kitchen do professional cleaning services typically cover?',
      answer:
          'We provide wall-to-wall coverage, including appliance interiors, backsplashes, light fixtures, and ventilation systems. Our systematic approach ensures that every corner, crevice, and surface receives thorough attention for a complete kitchen transformation.',
    ),
    KitchenFaqItem(
      id: 'faq_6',
      question: 'How much does it cost for kitchen cleaning services?',
      answer:
          'Our competitive pricing structure ranges from Rs 800 to Rs 1,200, depending on the kitchen’s complexity and size. This investment ensures professional-grade cleaning that saves you time while maintaining the highest hygiene standards.',
    ),
    KitchenFaqItem(
      id: 'faq_7',
      question: 'How is the cost of kitchen cleaning services determined?',
      answer:
          'Pricing calculations take into account multiple variables, including square footage, appliance count, cleaning frequency, and the current condition of the property. Our transparent assessment process ensures fair pricing tailored to your specific cleaning requirements.',
    ),
    KitchenFaqItem(
      id: 'faq_8',
      question: 'Will my kitchen be sanitised after cleaning?',
      answer:
          'Every service concludes with comprehensive sanitisation using hospital-grade disinfectants. This final step eliminates 99.9% of bacteria and viruses, ensuring your kitchen meets the highest standards of health and safety.',
    ),
    KitchenFaqItem(
      id: 'faq_9',
      question: 'Do I need to provide any cleaning supplies or equipment?',
      answer:
          'Our service includes all professional-grade equipment and eco-friendly supplies. You can relax while our fully equipped team handles everything from specialised tools to premium cleaning solutions.',
    ),
    KitchenFaqItem(
      id: 'faq_10',
      question: 'Can I reschedule or cancel my cleaning service?',
      answer:
          'Our user-friendly platform allows easy rescheduling or cancellation up to 4 hours before service time. To maintain fair scheduling for all customers, minimal fees may apply for last-minute changes.',
    ),
  ];

  /// Main services dataset
  static const List<KitchenCleaningServiceItem> allServices = [
    // --- SECTION 1: Occupied Kitchen Cleaning ---
    KitchenCleaningServiceItem(
      id: 'occ_essential',
      sectionId: 'occupied',
      title: 'Occupied Kitchen Cleaning',
      badgeText: 'Essential ★',
      badgeColor: Color(0xFFB45309), // Brownish Gold
      rating: 4.74,
      ratingCount: '5.6K+',
      duration: '3 hrs',
      price: 1459.0,
      imageUrl:
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80',
      bulletPoints: [
        'Degreasing of kitchen tiles, floor & slab, gas stove / hob',
        'Sink & under-the-sink, exhaust & fan dusting',
        'Kitchen floors, windows & switchboard fixtures cleaning',
        'Utensil removal / rearrangement not included',
        'Cabinet cleaning - exterior only',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_occ_ess_1',
          name: 'Up to 2 BHK Kitchen',
          price: 1459.0,
          description: 'Standard kitchen deep clean',
        ),
        ServiceOptionItem(
          id: 'opt_occ_ess_2',
          name: '3+ BHK Large Kitchen',
          price: 1799.0,
          description: 'Extended area & dual counters',
        ),
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'occ_power_steam',
      sectionId: 'occupied',
      title: 'Power Steam',
      rating: 4.77,
      ratingCount: '6.5K+',
      duration: '3 hrs',
      price: 1959.0,
      bulletPoints: [
        'High-pressure steam degreasing of kitchen tiles, slabs & gas stove / hob',
        'Sink & under-the-sink, exhaust & fan dusting',
        'Kitchen floors, windows & switchboard fixtures cleaning',
        'Utensil removal / rearrangement included',
        'Cabinet cleaning - exterior & interior',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_occ_steam_1',
          name: 'Standard Steam Clean',
          price: 1959.0,
        ),
        ServiceOptionItem(
          id: 'opt_occ_steam_2',
          name: 'Steam + Deep Chimney Scrub',
          price: 2299.0,
        ),
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'occ_eco_smart',
      sectionId: 'occupied',
      title: 'Eco-Smart 🌿',
      isEcoSafe: true,
      rating: 4.72,
      ratingCount: '2.2K+',
      duration: '2 hrs 30 mins',
      price: 2009.0,
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=600&q=80',
      bulletPoints: [
        'Odourless eco-smart deep cleaning',
        'High-pressure steam + active foam degreases tiles, slabs & gas stove/hob without fumes',
        'Includes all of Power Steam cleaning (sink, cabinets, utensils, exhaust & more)',
        'Non-corrosive and safe for family & pets',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_eco_1',
          name: 'Eco-Smart Standard',
          price: 2009.0,
        ),
        ServiceOptionItem(
          id: 'opt_eco_2',
          name: 'Eco-Smart Premium Organic',
          price: 2399.0,
        ),
      ],
    ),

    // --- SECTION 2: Empty Kitchen Cleaning ---
    KitchenCleaningServiceItem(
      id: 'emp_essential',
      sectionId: 'empty',
      title: 'Empty Kitchen Cleaning',
      badgeText: 'Essential ★',
      badgeColor: Color(0xFFB45309),
      rating: 4.75,
      ratingCount: '4K+',
      duration: '2 hrs 30 mins',
      price: 849.0,
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
      bulletPoints: [
        'Degreasing of kitchen tiles, slabs & gas stove / hob',
        'Sink & under-the-sink, exhaust & fan dusting',
        'Kitchen floors, windows & switchboard fixtures cleaning',
        'Cabinet cleaning - exterior & interior',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_emp_1',
          name: 'Up to 2 BHK Empty Kitchen',
          price: 849.0,
        ),
        ServiceOptionItem(
          id: 'opt_emp_2',
          name: '3+ BHK Empty Kitchen',
          price: 1099.0,
        ),
      ],
    ),

    // --- APPLIANCES & STANDALONE SERVICES ---
    KitchenCleaningServiceItem(
      id: 'app_fridge',
      sectionId: 'appliances',
      title: 'Fridge Cleaning',
      rating: 4.75,
      ratingCount: '22.3K+',
      duration: '30 mins',
      price: 379.0,
      startsAtText: 'Starts at ₹379',
      imageUrl:
          'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Removing and placing back all food items',
        'Cleaning of shelves and trays',
        'Wiping interior & exterior surfaces',
        'Removal of food stains, crumbs, and odors',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_fridge_1',
          name: 'Single Door Fridge',
          price: 379.0,
        ),
        ServiceOptionItem(
          id: 'opt_fridge_2',
          name: 'Double Door Fridge',
          price: 479.0,
        ),
        ServiceOptionItem(
          id: 'opt_fridge_3',
          name: 'Side-by-Side Large Fridge',
          price: 599.0,
        ),
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'app_chimney',
      sectionId: 'appliances',
      title: 'Chimney Cleaning',
      rating: 4.81,
      ratingCount: '25.3K+',
      duration: '30 mins',
      price: 379.0,
      imageUrl:
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Degreasing and stain removal of one chimney',
        'Mesh and filter deep cleaning',
        'Digital chimney cleaning is carried out only on the exterior',
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'app_utility',
      sectionId: 'appliances',
      title: 'Utility Area Cleaning',
      rating: 4.75,
      ratingCount: '1.1K+',
      duration: '1 hr',
      price: 499.0,
      imageUrl:
          'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?auto=format&fit=crop&w=500&q=80',
      description:
          'End-to-end cleaning of utility windows, appliances, and floor for a hygienic area',
    ),
    KitchenCleaningServiceItem(
      id: 'app_microwave',
      sectionId: 'appliances',
      title: 'Microwave Cleaning',
      rating: 4.72,
      ratingCount: '8.4K+',
      duration: '30 mins',
      price: 189.0,
      imageUrl:
          'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Deep cleaning of microwave exterior',
        'Wet wiping of interior to remove stains and remove odour',
        'Removing oil stain, Food stain',
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'app_stove',
      sectionId: 'appliances',
      title: 'Gas Stove Cleaning',
      rating: 4.78,
      ratingCount: '3K+',
      duration: '30 mins',
      price: 89.0,
      imageUrl:
          'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=500&q=80',
      description:
          'Removes grease, stains, and grime from stove, burners, and knobs',
    ),
    KitchenCleaningServiceItem(
      id: 'app_tiles',
      sectionId: 'appliances',
      title: 'Kitchen Tiles and Slabs Cleaning',
      rating: 4.76,
      ratingCount: '1.9K+',
      duration: '30 mins',
      price: 279.0,
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=500&q=80',
      description:
          'Degreases tiles & slabs and deep cleans grout for a fresh kitchen',
    ),
    KitchenCleaningServiceItem(
      id: 'app_cabinet',
      sectionId: 'appliances',
      title: 'Cabinet & Trolley Cleaning',
      rating: 4.76,
      ratingCount: '2.7K+',
      duration: '1 hr',
      price: 899.0,
      imageUrl:
          'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Cleaning inside of cabinets. Includes removal & placing back of items',
        'Removal of oil & grease stains from cabinets exterior',
      ],
    ),
    KitchenCleaningServiceItem(
      id: 'app_oven',
      sectionId: 'appliances',
      title: 'Oven, Toaster & Grill Cleaning',
      rating: 4.77,
      ratingCount: '474',
      duration: '15 mins',
      price: 379.0,
      imageUrl:
          'https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Deep cleaning the interiors for food crumbs & spills',
        'Cleaning of exterior & back panel for grease stains',
      ],
    ),

    // --- SECTION 3: MINI SERVICES ---
    KitchenCleaningServiceItem(
      id: 'mini_fan',
      sectionId: 'mini',
      title: 'Fan Cleaning',
      rating: 4.7,
      ratingCount: '1.2K+',
      duration: '15 mins',
      price: 89.0,
      imageUrl:
          'https://images.unsplash.com/photo-1615873968403-89e068629265?auto=format&fit=crop&w=400&q=80',
    ),
    KitchenCleaningServiceItem(
      id: 'mini_utensils',
      sectionId: 'mini',
      title: 'Utensils Removal & Replacement',
      rating: 4.8,
      ratingCount: '950+',
      duration: '30 mins',
      price: 409.0,
      imageUrl:
          'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
    ),
    KitchenCleaningServiceItem(
      id: 'mini_sink',
      sectionId: 'mini',
      title: 'Sink & Under Sink Cleaning',
      rating: 4.75,
      ratingCount: '3.4K+',
      duration: '20 mins',
      price: 79.0,
      imageUrl:
          'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=400&q=80',
    ),
    KitchenCleaningServiceItem(
      id: 'mini_window',
      sectionId: 'mini',
      title: 'Kitchen Window Cleaning',
      rating: 4.72,
      ratingCount: '890+',
      duration: '30 mins',
      price: 269.0,
      imageUrl:
          'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=400&q=80',
    ),
    KitchenCleaningServiceItem(
      id: 'mini_dining',
      sectionId: 'mini',
      title: 'Dining Table & Chairs Cleaning',
      rating: 4.79,
      ratingCount: '2.1K+',
      duration: '25 mins',
      price: 349.0,
      imageUrl:
          'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=400&q=80',
    ),
  ];
}
