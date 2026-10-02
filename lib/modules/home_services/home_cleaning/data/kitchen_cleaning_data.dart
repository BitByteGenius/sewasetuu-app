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
      startsAtText: 'Starts at ₹379',
      imageUrl:
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=500&q=80',
      bulletPoints: [
        'Degreasing and stain removal of one chimney',
        'Mesh and filter deep cleaning',
        'Digital chimney cleaning is carried out only on the exterior',
      ],
      options: [
        ServiceOptionItem(
          id: 'opt_chimney_1',
          name: 'Standard Mesh Chimney',
          price: 379.0,
        ),
        ServiceOptionItem(
          id: 'opt_chimney_2',
          name: 'Baffle Filter Heavy Degrease',
          price: 499.0,
        ),
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

  /// Detail comparison data feed for Occupied & Empty Kitchen Cleaning modal screens
  static KitchenServiceDetailData getDetailData(String serviceIdOrTitle) {
    final isEmpty = serviceIdOrTitle.toLowerCase().contains('empty') ||
        serviceIdOrTitle == 'emp_essential';

    if (isEmpty) {
      return emptyKitchenDetailData;
    }
    return occupiedKitchenDetailData;
  }

  /// Returns dynamic single service detail data for appliances & mini services matching reference mockup
  static KitchenSingleServiceDetailData getSingleServiceDetailData(
      KitchenCleaningServiceItem item) {
    if (item.id.contains('fridge') || item.title.toLowerCase().contains('fridge')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_fridge_1',
            name: 'Single door',
            duration: '30 mins',
            price: 379.0,
          ),
          KitchenServiceVariant(
            id: 'opt_fridge_2',
            name: 'Double door',
            duration: '1 hr',
            price: 499.0,
          ),
          KitchenServiceVariant(
            id: 'opt_fridge_3',
            name: 'Side by side',
            duration: '1 hr',
            price: 749.0,
          ),
        ],
        includes: const [
          'Removing and placing back food items',
          'Cleaning shelves and trays',
          'Wiping interior and exterior surfaces',
          'Removal of stains, crumbs, and odors',
          'Drying and reassembling the fridge',
        ],
        excludes: const [
          'Defrosting of freezer',
          'Internal technical/repair work',
          'Gas refill or cooling-related issues',
          'Removal of dents, scratches, or rust',
          'Polishing surfaces',
        ],
      );
    }

    if (item.id.contains('chimney') || item.title.toLowerCase().contains('chimney')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: [
          KitchenServiceVariant(
            id: '${item.id}_std',
            name: 'Standard Mesh Chimney',
            duration: '30 mins',
            price: item.price,
          ),
          KitchenServiceVariant(
            id: '${item.id}_baffle',
            name: 'Baffle Filter Heavy Degrease',
            duration: '45 mins',
            price: item.price + 120.0,
          ),
        ],
        includes: const [
          'Degreasing and stain removal of chimney filters & mesh',
          'Outer body wiping and motor cover dusting',
          'Removal of oil sludge and carbon deposits',
          'Post-cleaning functionality check',
        ],
        excludes: const [
          'Duct pipe internal cleaning',
          'Electrical motor repair or spare replacement',
          'Wall ducting modifications',
        ],
      );
    }

    if (item.id.contains('fan') || item.title.toLowerCase().contains('fan')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_fan_1',
            name: 'Exhaust / Ceiling Fan',
            duration: '15 mins',
            price: 89.0,
          ),
          KitchenServiceVariant(
            id: 'opt_fan_2',
            name: 'Multiple Fans (Up to 3)',
            duration: '30 mins',
            price: 199.0,
          ),
        ],
        includes: const [
          'Dust and grease removal from fan blades and motor housing',
          'Wet wiping with specialized degreasing solution',
          'Cleaning fan mesh grill, blades & outer casing',
          'Post-cleaning functionality & noise check',
        ],
        excludes: const [
          'Motor rewinding or electrical repairs',
          'Replacement of damaged fan blades or capacitor',
        ],
      );
    }

    if (item.id.contains('utensils') || item.title.toLowerCase().contains('utensil')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_utensil_1',
            name: 'Standard Kitchen Utensils',
            duration: '30 mins',
            price: 409.0,
          ),
          KitchenServiceVariant(
            id: 'opt_utensil_2',
            name: 'Heavy Crockery & Glassware',
            duration: '45 mins',
            price: 599.0,
          ),
        ],
        includes: const [
          'Careful removal of utensils from cabinets before deep clean',
          'Wiping cabinet shelves clean before replacing items',
          'Organized rearrangement of utensils back in designated shelves',
          'Safe handling of fragile cookware and glassware',
        ],
        excludes: const [
          'Washing or scrubbing dirty dishes & sink dishwashing',
          'Repairing pre-damaged or cracked cookware',
        ],
      );
    }

    if (item.id.contains('sink') || item.title.toLowerCase().contains('sink')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_sink_1',
            name: 'Standard Single Sink',
            duration: '20 mins',
            price: 79.0,
          ),
          KitchenServiceVariant(
            id: 'opt_sink_2',
            name: 'Double Sink & Heavy Scrub',
            duration: '30 mins',
            price: 129.0,
          ),
        ],
        includes: const [
          'Hard water stain & limescale removal from sink basin & tap',
          'Deep sanitization of sink drain strainer & overflow rim',
          'Degreasing and wiping under-sink cabinet floor & pipe exterior',
          'Elimination of foul odours from sink drain trap',
        ],
        excludes: const [
          'Plumbing pipe leak repair or unblocking clogged drain pipes',
          'Replacing damaged faucet washers or cartridges',
        ],
      );
    }

    if (item.id.contains('window') || item.title.toLowerCase().contains('window')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_window_1',
            name: 'Standard Window (up to 2 panes)',
            duration: '30 mins',
            price: 269.0,
          ),
          KitchenServiceVariant(
            id: 'opt_window_2',
            name: 'Large Mesh & Glass Window',
            duration: '45 mins',
            price: 349.0,
          ),
        ],
        includes: const [
          'Degreasing window glass panes, aluminum frames, and sliding tracks',
          'Washing and scrubbing removable wire mesh screens',
          'Wiping window sills, latches & safety grilles clean',
        ],
        excludes: const [
          'External high-rise window rope access or scaffolding',
          'Replacing broken glass panes or rusted window latches',
        ],
      );
    }

    if (item.id.contains('dining') || item.title.toLowerCase().contains('dining')) {
      return KitchenSingleServiceDetailData(
        serviceId: item.id,
        title: item.title,
        rating: item.rating,
        ratingCount: item.ratingCount,
        variants: const [
          KitchenServiceVariant(
            id: 'opt_dining_1',
            name: '4-Seater Table & Chairs',
            duration: '25 mins',
            price: 349.0,
          ),
          KitchenServiceVariant(
            id: 'opt_dining_2',
            name: '6-Seater Table & Chairs',
            duration: '40 mins',
            price: 499.0,
          ),
        ],
        includes: const [
          'Surface wipe down and food stain removal from dining table top',
          'Cleaning chair legs, seat frames, and backrests',
          'Wood or glass polishing wipe for a shiny hygienic finish',
        ],
        excludes: const [
          'Deep foam shampooing of fabric chair upholstery',
          'Wood re-varnishing or scratch repair',
        ],
      );
    }

    // Default dynamic generator for any other appliance or mini service
    final variantsList = item.options.isNotEmpty
        ? item.options
            .map((o) => KitchenServiceVariant(
                  id: o.id,
                  name: o.name,
                  duration: item.duration,
                  price: o.price,
                ))
            .toList()
        : [
            KitchenServiceVariant(
              id: '${item.id}_default',
              name: item.title,
              duration: item.duration,
              price: item.price,
            ),
          ];

    return KitchenSingleServiceDetailData(
      serviceId: item.id,
      title: item.title,
      rating: item.rating,
      ratingCount: item.ratingCount,
      variants: variantsList,
      includes: item.bulletPoints.isNotEmpty
          ? item.bulletPoints
          : const [
              'Deep sanitization of surface & fixtures',
              'Removal of tough grease stains and dust',
              'Use of food-safe non-corrosive chemicals',
              'Post-service quality check and wipe down',
            ],
      excludes: const [
        'Major structural or electrical repairs',
        'Replacement of damaged hardware or parts',
        'Chemical bleaching of corroded metals',
      ],
    );
  }

  static const KitchenServiceDetailData occupiedKitchenDetailData =
      KitchenServiceDetailData(
    serviceId: 'occupied',
    title: 'Occupied Kitchen Cleaning',
    badgeText: 'Essential',
    bannerImageUrl:
        'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=1000&q=80',
    bookingStatsText: '15k bookings near you | ★ 4.74',
    packages: [
      KitchenPackageColumn(
        id: 'essential',
        title: 'Essential',
        price: 1459.0,
        originalPrice: 2114.0,
        icon: Icons.star_border_rounded,
      ),
      KitchenPackageColumn(
        id: 'power_steam',
        title: 'Power\nSteam',
        badgeTag: 'Popular',
        isPopular: true,
        price: 1959.0,
        originalPrice: 2699.0,
        icon: Icons.workspace_premium_rounded,
      ),
      KitchenPackageColumn(
        id: 'eco_smart',
        title: 'Eco-\nSmart',
        price: 2009.0,
        originalPrice: 2899.0,
        icon: Icons.workspace_premium_rounded,
      ),
    ],
    comparisonGroups: [
      KitchenComparisonGroup(
        groupTitle: 'Kitchen Cleaning',
        iconName: 'kitchen',
        features: [
          KitchenFeatureRow(
            id: 'steam_cleaning',
            featureName: 'Steam cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'chimney_cleaning',
            featureName: 'Chimney cleaning (if selected)',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'utensil_rearrangement',
            featureName: 'Utensil re-arrangement',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'tiles_slabs_windows',
            featureName: 'Cleaning of tiles, slabs and windows',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'appliances_cleaning',
            featureName:
                'Appliances exterior + interior cleaning (if added separately)',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'cabinet_exterior',
            featureName: "Cabinet's cleaning (Exterior)",
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'cabinet_interior',
            featureName: "Cabinet's cleaning (Interior)",
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'oil_stain_removal',
            featureName: 'Oil stain removal',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'gas_stove_hob',
            featureName: 'Gas stove & hob cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'sink_under_sink',
            featureName: 'Sink and under the sink cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'odourless_cleaning',
            featureName: 'Odourless cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(false),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'eco_friendly',
            featureName: 'Eco-Friendly',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(false),
              'eco_smart': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'residue_after_cleaning',
            featureName: 'Residue after cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.text('LOW'),
              'power_steam': KitchenFeatureValue.text('LOW'),
              'eco_smart': KitchenFeatureValue.text('ZERO'),
            },
          ),
        ],
      ),
    ],
    faqItems: faqItemsDetailList,
  );

  static const KitchenServiceDetailData emptyKitchenDetailData =
      KitchenServiceDetailData(
    serviceId: 'empty',
    title: 'Empty Kitchen Cleaning',
    badgeText: 'Power Steam',
    bannerImageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80',
    bookingStatsText: '12k bookings near you | ★ 4.75',
    packages: [
      KitchenPackageColumn(
        id: 'essential',
        title: 'Essential',
        price: 849.0,
        originalPrice: 1299.0,
        icon: Icons.star_border_rounded,
      ),
      KitchenPackageColumn(
        id: 'power_steam',
        title: 'Power\nSteam',
        badgeTag: 'Popular',
        isPopular: true,
        price: 949.0,
        originalPrice: 2209.0,
        icon: Icons.workspace_premium_rounded,
      ),
    ],
    comparisonGroups: [
      KitchenComparisonGroup(
        groupTitle: 'Kitchen Cleaning',
        iconName: 'kitchen',
        features: [
          KitchenFeatureRow(
            id: 'steam_cleaning',
            featureName: 'Steam cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'chimney_cleaning',
            featureName: 'Chimney cleaning (if selected)',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'utensil_rearrangement',
            featureName: 'Utensil re-arrangement',
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(false),
            },
          ),
          KitchenFeatureRow(
            id: 'tiles_slabs_windows',
            featureName: 'Cleaning of tiles, slabs and windows',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'appliances_cleaning',
            featureName:
                'Appliances exterior + interior cleaning (if added separately)',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'cabinet_exterior',
            featureName: "Cabinet's cleaning (Exterior)",
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'cabinet_interior',
            featureName: "Cabinet's cleaning (Interior)",
            columnValues: {
              'essential': KitchenFeatureValue.bool(false),
              'power_steam': KitchenFeatureValue.bool(false),
            },
          ),
          KitchenFeatureRow(
            id: 'oil_stain_removal',
            featureName: 'Oil stain removal',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'gas_stove_hob',
            featureName: 'Gas stove & hob cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
          KitchenFeatureRow(
            id: 'sink_under_sink',
            featureName: 'Sink and under the sink cleaning',
            columnValues: {
              'essential': KitchenFeatureValue.bool(true),
              'power_steam': KitchenFeatureValue.bool(true),
            },
          ),
        ],
      ),
    ],
    faqItems: faqItemsDetailList,
  );

  static const List<KitchenFaqItem> faqItemsDetailList = [
    KitchenFaqItem(
      id: 'faq_det_1',
      question: 'Do I need to provide any cleaning supplies or equipment?',
      answer:
          'No, our professionals carry all required specialized cleaning agents, micro-fiber cloths, and steam machines.',
    ),
    KitchenFaqItem(
      id: 'faq_det_2',
      question: 'Can I reschedule or cancel my cleaning service?',
      answer:
          'Yes! You can easily reschedule or cancel your slot up to 4 hours prior to the appointment through the app.',
    ),
    KitchenFaqItem(
      id: 'faq_det_3',
      question: 'Will the cleaners move furniture while cleaning?',
      answer:
          'Our team will move light appliances and standard furniture. Heavy fixed structures will be cleaned around.',
    ),
    KitchenFaqItem(
      id: 'faq_det_4',
      question: 'What happens if I am not satisfied with the cleaning?',
      answer:
          'We offer a 100% satisfaction guarantee. If any area is missed, we will re-clean it free of charge within 7 days.',
    ),
    KitchenFaqItem(
      id: 'faq_det_5',
      question: 'What is included in a deep cleaning service?',
      answer:
          'It includes tile degreasing, slab & sink sanitization, exterior & interior cabinet wipe down, exhaust fan & window cleaning.',
    ),
    KitchenFaqItem(
      id: 'faq_det_6',
      question: 'How often should I book a deep cleaning service?',
      answer:
          'We recommend booking a deep kitchen cleaning every 2 to 3 months to maintain hygiene and prevent oil accumulation.',
    ),
    KitchenFaqItem(
      id: 'faq_det_7',
      question: 'Will my bathroom be sanitized after cleaning?',
      answer:
          'Bathroom cleaning is available as a separate service or combined home package.',
    ),
    KitchenFaqItem(
      id: 'faq_det_8',
      question: 'Are your cleaning agents eco-friendly?',
      answer:
          'Yes, especially under our Eco-Smart package, all cleaning solutions are non-toxic, eco-certified, and safe for kids & pets.',
    ),
    KitchenFaqItem(
      id: 'faq_det_9',
      question: 'Is the service safe for pets and kids?',
      answer:
          'Absolutely. We use non-corrosive, food-safe and fume-free cleaning solutions.',
    ),
    KitchenFaqItem(
      id: 'faq_det_10',
      question: 'Do I need to be home during the cleaning service?',
      answer:
          'It is recommended to be present at the start and end of service for inspection, though not mandatory during cleaning.',
    ),
  ];
}

