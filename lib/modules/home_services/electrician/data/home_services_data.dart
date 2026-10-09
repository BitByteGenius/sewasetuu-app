import 'package:flutter/material.dart';
import '../../home_cleaning/models/kitchen_cleaning_model.dart';
import '../models/home_service_model.dart';

/// Central data repository providing production-ready mock data for Electrician, Plumbing, and Carpentry modules.
/// Structured for effortless 1-click backend/REST API integration with exact Image-based category cards.
class HomeServicesData {
  // ---------------------------------------------------------------------------
  // ELECTRICIAN DATA
  // ---------------------------------------------------------------------------

  static final List<HomeServiceCategory> electricianCategories = [
    const HomeServiceCategory(
      id: 'elec_geyser',
      name: 'Geyser & Appliances',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      icon: Icons.water_drop_rounded,
      isPopular: true,
      sortOrder: 1,
    ),
    const HomeServiceCategory(
      id: 'elec_light',
      name: 'Lights & Fans',
      imageUrl: 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?auto=format&fit=crop&w=400&q=80',
      icon: Icons.lightbulb_outline_rounded,
      isPopular: true,
      sortOrder: 2,
    ),
    const HomeServiceCategory(
      id: 'elec_festive_light',
      name: 'Festive Light',
      imageUrl: 'https://images.unsplash.com/photo-1512389142860-9c449e58a543?auto=format&fit=crop&w=400&q=80',
      icon: Icons.auto_awesome_rounded,
      sortOrder: 3,
    ),
    const HomeServiceCategory(
      id: 'elec_book',
      name: 'Book Electrician',
      imageUrl: 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=400&q=80',
      icon: Icons.engineering_rounded,
      isPopular: true,
      sortOrder: 4,
    ),
    const HomeServiceCategory(
      id: 'elec_switch',
      name: 'Switch & Socket',
      imageUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=400&q=80',
      icon: Icons.power_rounded,
      isPopular: true,
      sortOrder: 5,
    ),
    const HomeServiceCategory(
      id: 'elec_mcb',
      name: 'MCB & Wiring',
      imageUrl: 'https://images.unsplash.com/photo-1544725121-be3bf52e2dc8?auto=format&fit=crop&w=400&q=80',
      icon: Icons.flash_on_rounded,
      sortOrder: 6,
    ),
  ];

  static final List<KitchenCleaningNavCategory> electricianNavCategories = [
    const KitchenCleaningNavCategory(
      id: 'geyser_heavy',
      title: 'Geyser &\nAppliances',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.water_drop_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'light_fan',
      title: 'Lights &\nFans',
      imageUrl: 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.lightbulb_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'mcb_wiring',
      title: 'MCB &\nSwitches',
      imageUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.flash_on_rounded,
    ),
  ];

  static final List<KitchenCleaningOfferBanner> electricianBanners = [
    const KitchenCleaningOfferBanner(
      id: 'banner_elec_1',
      tagText: 'SAFETY FIRST',
      headline: 'Flat 15% OFF on Electrical Inspections',
      promoCode: 'ELEC15',
    ),
    const KitchenCleaningOfferBanner(
      id: 'banner_elec_2',
      tagText: 'SEASON SPECIAL',
      headline: 'Geyser Servicing Starting at ₹299',
      promoCode: 'GEYSER299',
    ),
  ];

  static final List<KitchenCleaningServiceItem> electricianServices = [
    // --- SECTION 1: Geyser & Heavy Appliances ---
    const KitchenCleaningServiceItem(
      id: 'elec_s1',
      sectionId: 'geyser_heavy',
      title: 'Geyser Servicing & Repair',
      badgeText: 'Bestseller',
      rating: 4.82,
      ratingCount: '18.4K',
      price: 349,
      originalPrice: 499,
      duration: '45 mins',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Complete element inspection and de-scaling',
        'Thermostat & wiring safety check',
        'Water leakage testing and valve tightening',
      ],
      description: 'Comprehensive geyser service including heating element cleaning and electrical safety testing by certified technicians.',
      options: [
        ServiceOptionItem(id: 'opt_g1', name: 'Up to 15L Geyser', price: 349),
        ServiceOptionItem(id: 'opt_g2', name: '25L+ Heavy Geyser', price: 449),
      ],
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s2',
      sectionId: 'geyser_heavy',
      title: 'Geyser Installation / Uninstallation',
      badgeText: 'Essential ★',
      rating: 4.79,
      ratingCount: '12.1K',
      price: 499,
      originalPrice: 599,
      duration: '60 mins',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Safe wall mounting with heavy anchor bolts',
        'Inlet/outlet connection with sealing tape',
        'Full operational test run post-installation',
      ],
      description: 'Professional wall mounting and pipe connection setup for instant and storage water heaters.',
      options: [
        ServiceOptionItem(id: 'opt_gi1', name: 'New Installation', price: 499),
        ServiceOptionItem(id: 'opt_gi2', name: 'Uninstallation Only', price: 299),
      ],
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s10',
      sectionId: 'geyser_heavy',
      title: 'Inverter & Battery Servicing / Setup',
      rating: 4.83,
      ratingCount: '11.7K',
      price: 599,
      originalPrice: 799,
      duration: '60 mins',
      imageUrl: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Pure sine wave inverter connection & load mapping',
        'Distilled water top-up & terminal grease cleaning',
        'Automatic changeover switch testing',
      ],
      description: 'Expert installation and battery maintenance for uninterrupted home power backup.',
    ),

    // --- SECTION 2: Lights & Fans ---
    const KitchenCleaningServiceItem(
      id: 'elec_s3',
      sectionId: 'light_fan',
      title: 'Light Fitting & Installation',
      rating: 4.85,
      ratingCount: '34.2K',
      price: 149,
      originalPrice: 199,
      duration: '25 mins',
      imageUrl: 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Ceiling LED, strip light & tube light fitting',
        'Drilling and secure wall mounting',
        'Wiring hookup & voltage testing',
      ],
      description: 'Quick and secure light fixture installation for indoor and outdoor spaces.',
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s4',
      sectionId: 'light_fan',
      title: 'Festive & Decorative String Light Setup',
      badgeText: 'Trending',
      rating: 4.88,
      ratingCount: '9.6K',
      price: 499,
      originalPrice: 699,
      duration: '60 mins',
      imageUrl: 'https://images.unsplash.com/photo-1512389142860-9c449e58a543?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Balcony, terrace & facade fairy light hanging',
        'Weatherproof wire extension & socket fitting',
        'Post-event dismantling service available',
      ],
      description: 'Hassle-free decorative lighting setup for festivals, parties, and special occasions.',
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s7',
      sectionId: 'light_fan',
      title: 'Ceiling & Exhaust Fan Repair / Installation',
      rating: 4.84,
      ratingCount: '28.9K',
      price: 249,
      originalPrice: 349,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1527632919775-5ad38824e8b4?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Capacitor replacement and speed regulator fix',
        'Balancing blades & rod hook assembly',
        'Exhaust fan wall fitting & motor servicing',
      ],
      description: 'Complete fan servicing, capacitor replacement, and new fan installation.',
    ),

    // --- SECTION 3: MCB & Wiring ---
    const KitchenCleaningServiceItem(
      id: 'elec_s5',
      sectionId: 'mcb_wiring',
      title: 'Book an Electrician (Inspection & Minor Repair)',
      badgeText: 'Essential ★',
      rating: 4.86,
      ratingCount: '65.8K',
      price: 199,
      originalPrice: 249,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Dedicated 30-min doorstep inspection visit',
        'Diagnosis of short circuits, sparkings & trips',
        'Adjustable visiting fee against final repair cost',
      ],
      description: 'Expert electrician visit for diagnosing electrical issues and performing quick repairs.',
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s6',
      sectionId: 'mcb_wiring',
      title: 'Switch & Socket Repair or Replacement',
      rating: 4.81,
      ratingCount: '41.3K',
      price: 129,
      originalPrice: 179,
      duration: '20 mins',
      imageUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Replacement of broken switch/socket board',
        'Modular switchboard wiring & earthing check',
        'High load 16A socket replacement for AC/Geyser',
      ],
      description: 'Safe installation and repair of switches, sockets, and power distribution boards.',
    ),
    const KitchenCleaningServiceItem(
      id: 'elec_s9',
      sectionId: 'mcb_wiring',
      title: 'MCB & Main Fuse Replacement',
      rating: 4.87,
      ratingCount: '15.2K',
      price: 299,
      originalPrice: 399,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1544725121-be3bf52e2dc8?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Single & double pole MCB tripping fix',
        'Distribution box (DB) busbar tightening',
        'RCCB / ELCB shock prevention testing',
      ],
      description: 'Protection against power surges and circuit overloads by replacing faulty MCBs.',
    ),

    // --- SECTION 4: MINI SERVICES ---
    const KitchenCleaningServiceItem(
      id: 'mini_elec_1',
      sectionId: 'mini',
      title: 'Switch / Socket Fitting',
      rating: 4.75,
      ratingCount: '3.1K+',
      duration: '15 mins',
      price: 79.0,
      imageUrl: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_elec_2',
      sectionId: 'mini',
      title: 'Bulb / Holder Replacement',
      rating: 4.8,
      ratingCount: '4.2K+',
      duration: '15 mins',
      price: 69.0,
      imageUrl: 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_elec_3',
      sectionId: 'mini',
      title: 'Doorbell Installation',
      rating: 4.72,
      ratingCount: '1.8K+',
      duration: '20 mins',
      price: 119.0,
      imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_elec_4',
      sectionId: 'mini',
      title: 'Fan Capacitor Fix',
      rating: 4.82,
      ratingCount: '5.4K+',
      duration: '20 mins',
      price: 99.0,
      imageUrl: 'https://images.unsplash.com/photo-1527632919775-5ad38824e8b4?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  // ---------------------------------------------------------------------------
  // PLUMBING DATA
  // ---------------------------------------------------------------------------

  static final List<HomeServiceCategory> plumbingCategories = [
    const HomeServiceCategory(
      id: 'plumb_toilet',
      name: 'Toilet & Leakage',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      icon: Icons.wc_rounded,
      isPopular: true,
      sortOrder: 1,
    ),
    const HomeServiceCategory(
      id: 'plumb_tap',
      name: 'Taps & Mixers',
      imageUrl: 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=400&q=80',
      icon: Icons.water_rounded,
      isPopular: true,
      sortOrder: 2,
    ),
    const HomeServiceCategory(
      id: 'plumb_basin',
      name: 'Basin & Sink',
      imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=400&q=80',
      icon: Icons.countertops_rounded,
      isPopular: true,
      sortOrder: 3,
    ),
    const HomeServiceCategory(
      id: 'plumb_drainage',
      name: 'Drainage Pipe',
      imageUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?auto=format&fit=crop&w=400&q=80',
      icon: Icons.grain_rounded,
      sortOrder: 4,
    ),
    const HomeServiceCategory(
      id: 'plumb_pipe',
      name: 'Water Pipe & Tank',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=400&q=80',
      icon: Icons.polyline_rounded,
      isPopular: true,
      sortOrder: 5,
    ),
  ];

  static final List<KitchenCleaningNavCategory> plumbingNavCategories = [
    const KitchenCleaningNavCategory(
      id: 'plumb_sec_toilet',
      title: 'Toilet &\nLeakage',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.wc_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'plumb_sec_tap',
      title: 'Taps &\nBasins',
      imageUrl: 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.water_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'plumb_sec_pipe',
      title: 'Pipes &\nWater Tank',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.plumbing_rounded,
    ),
  ];

  static final List<KitchenCleaningOfferBanner> plumbingBanners = [
    const KitchenCleaningOfferBanner(
      id: 'banner_plumb_1',
      tagText: 'LEAKAGE SOLUTION',
      headline: 'Flush Tank & Tap Repair at Flat ₹199',
      promoCode: 'LEAKFREE',
    ),
    const KitchenCleaningOfferBanner(
      id: 'banner_plumb_2',
      tagText: 'TANK CLEANING',
      headline: 'Overhead Tank Deep Clean Offer',
      promoCode: 'CLEANTANK',
    ),
  ];

  static final List<KitchenCleaningServiceItem> plumbingServices = [
    // --- SECTION 1: Toilet & Leakage Repair ---
    const KitchenCleaningServiceItem(
      id: 'plumb_s1',
      sectionId: 'plumb_sec_toilet',
      title: 'Flush Tank Leakage Repair',
      badgeText: 'Bestseller',
      rating: 4.81,
      ratingCount: '16.5K',
      price: 249,
      originalPrice: 349,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Syphon kit & ball valve replacement',
        'Continuous overflow water stopping',
        'Push button mechanism adjustment',
      ],
      description: 'Fix internal flush tank leakages and restore smooth water filling in western toilets.',
    ),
    const KitchenCleaningServiceItem(
      id: 'plumb_s2',
      sectionId: 'plumb_sec_toilet',
      title: 'Jet Spray Repair & Installation',
      rating: 4.86,
      ratingCount: '23.1K',
      price: 149,
      originalPrice: 199,
      duration: '20 mins',
      imageUrl: 'https://images.unsplash.com/photo-1620626011761-996317b8d101?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Health faucet hose & nozzle fitting',
        'Angle valve connection sealing',
        'High water pressure adjustment',
      ],
      description: 'Replacement of clogged or leaking jet spray hoses and hand showers.',
    ),
    const KitchenCleaningServiceItem(
      id: 'plumb_s8',
      sectionId: 'plumb_sec_toilet',
      title: 'Book a Plumber (Doorstep Inspection)',
      badgeText: 'Popular',
      rating: 4.89,
      ratingCount: '58.2K',
      price: 199,
      originalPrice: 249,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Thorough inspection of dampness & leaks',
        'Detailed estimate before work begins',
        'Fee deductible from overall work total',
      ],
      description: 'General plumbing diagnosis visit by expert plumbers equipped with specialized tools.',
    ),

    // --- SECTION 2: Taps & Basins ---
    const KitchenCleaningServiceItem(
      id: 'plumb_s3',
      sectionId: 'plumb_sec_tap',
      title: 'Tap & Wall Mixer Repair / Replacement',
      badgeText: 'Essential ★',
      rating: 4.83,
      ratingCount: '42.8K',
      price: 199,
      originalPrice: 299,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Dripping faucet washer replacement',
        'Hot & cold water diverter valve cartridge fix',
        'Teflon tape Threadlock anti-leak sealing',
      ],
      description: 'Fix leaky taps, wall mixers, and sink faucets for kitchens and bathrooms.',
    ),
    const KitchenCleaningServiceItem(
      id: 'plumb_s4',
      sectionId: 'plumb_sec_tap',
      title: 'Basin & Kitchen Sink Unclogging / Pipe Repair',
      rating: 4.84,
      ratingCount: '31.2K',
      price: 299,
      originalPrice: 399,
      duration: '40 mins',
      imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Bottle trap cleaning & waste pipe replacement',
        'Slow draining sink hair/grease blockage removal',
        'Silicone caulking around basin rim',
      ],
      description: 'Complete blockage clearance and drain pipe replacement for wash basins and kitchen sinks.',
    ),
    const KitchenCleaningServiceItem(
      id: 'plumb_s5',
      sectionId: 'plumb_sec_tap',
      title: 'Drainage Pipe Blockage Clearance',
      badgeText: 'High Demand',
      rating: 4.88,
      ratingCount: '21.7K',
      price: 349,
      originalPrice: 499,
      duration: '45 mins',
      imageUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Drain snake wire tool blockage clearing',
        'Floor trap (nahani trap) deep cleaning',
        'Foul odor neutralizer treatment',
      ],
      description: 'Clears tough sewage and floor drain blockages to prevent water overflow and bad odors.',
    ),

    // --- SECTION 3: Pipes & Water Tank ---
    const KitchenCleaningServiceItem(
      id: 'plumb_s6',
      sectionId: 'plumb_sec_pipe',
      title: 'CPVC / GI Water Pipe Connection Repair',
      rating: 4.8,
      ratingCount: '17.4K',
      price: 399,
      originalPrice: 549,
      duration: '50 mins',
      imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Concealed pipe leak tracing & solvent welding',
        'Main line valve replacement',
        'Pressure pump connection fitting',
      ],
      description: 'Durable pipe line repair and new water inlet connections using high grade CPVC fittings.',
    ),
    const KitchenCleaningServiceItem(
      id: 'plumb_s9',
      sectionId: 'plumb_sec_pipe',
      title: 'Overhead Water Tank Deep Cleaning',
      rating: 4.91,
      ratingCount: '9.3K',
      price: 799,
      originalPrice: 1099,
      duration: '90 mins',
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'High pressure jet wash & sludge de-watering',
        'Antibacterial UV / Chlorine disinfectant spray',
        'Automatic float valve safety inspection',
      ],
      description: 'Hygienic 5-stage cleaning for 500L to 2000L plastic and concrete overhead water tanks.',
    ),

    // --- SECTION 4: MINI SERVICES ---
    const KitchenCleaningServiceItem(
      id: 'mini_plumb_1',
      sectionId: 'mini',
      title: 'Jet Spray Hose Replace',
      rating: 4.78,
      ratingCount: '2.9K+',
      duration: '15 mins',
      price: 99.0,
      imageUrl: 'https://images.unsplash.com/photo-1620626011761-996317b8d101?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_plumb_2',
      sectionId: 'mini',
      title: 'Tap Washer / Spindle Fix',
      rating: 4.82,
      ratingCount: '4.1K+',
      duration: '15 mins',
      price: 79.0,
      imageUrl: 'https://images.unsplash.com/photo-1542013936693-884638332954?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_plumb_3',
      sectionId: 'mini',
      title: 'Waste Pipe Replacement',
      rating: 4.74,
      ratingCount: '1.9K+',
      duration: '20 mins',
      price: 129.0,
      imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_plumb_4',
      sectionId: 'mini',
      title: 'Shower Filter Clean',
      rating: 4.85,
      ratingCount: '3.6K+',
      duration: '15 mins',
      price: 89.0,
      imageUrl: 'https://images.unsplash.com/photo-1595853035070-59a39fe84de3?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  // ---------------------------------------------------------------------------
  // CARPENTRY DATA
  // ---------------------------------------------------------------------------

  static final List<HomeServiceCategory> carpentryCategories = [
    const HomeServiceCategory(
      id: 'carp_door',
      name: 'Door & Lock',
      imageUrl: 'https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?auto=format&fit=crop&w=400&q=80',
      icon: Icons.door_front_door_rounded,
      isPopular: true,
      sortOrder: 1,
    ),
    const HomeServiceCategory(
      id: 'carp_drill',
      name: 'Drill & Hang',
      imageUrl: 'https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?auto=format&fit=crop&w=400&q=80',
      icon: Icons.build_circle_rounded,
      isPopular: true,
      sortOrder: 2,
    ),
    const HomeServiceCategory(
      id: 'carp_assembly',
      name: 'Furniture Assembly',
      imageUrl: 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=400&q=80',
      icon: Icons.chair_rounded,
      isPopular: true,
      sortOrder: 3,
    ),
    const HomeServiceCategory(
      id: 'carp_cupboard',
      name: 'Cupboard & Drawer',
      imageUrl: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?auto=format&fit=crop&w=400&q=80',
      icon: Icons.kitchen_rounded,
      sortOrder: 4,
    ),
  ];

  static final List<KitchenCleaningNavCategory> carpentryNavCategories = [
    const KitchenCleaningNavCategory(
      id: 'carp_sec_door',
      title: 'Door &\nLock Repair',
      imageUrl: 'https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.door_front_door_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'carp_sec_drill',
      title: 'Drilling &\nMounting',
      imageUrl: 'https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.build_rounded,
    ),
    const KitchenCleaningNavCategory(
      id: 'carp_sec_assembly',
      title: 'Furniture &\nAssembly',
      imageUrl: 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=400&q=80',
      fallbackIcon: Icons.chair_rounded,
    ),
  ];

  static final List<KitchenCleaningOfferBanner> carpentryBanners = [
    const KitchenCleaningOfferBanner(
      id: 'banner_carp_1',
      tagText: 'HOME UPGRADE',
      headline: 'Furniture Assembly & Mounting at 10% OFF',
      promoCode: 'WOOD10',
    ),
    const KitchenCleaningOfferBanner(
      id: 'banner_carp_2',
      tagText: 'QUICK FIX',
      headline: 'Drill & Hang Package starting at ₹149',
      promoCode: 'DRILL149',
    ),
  ];

  static final List<KitchenCleaningServiceItem> carpentryServices = [
    // --- SECTION 1: Door & Lock Repair ---
    const KitchenCleaningServiceItem(
      id: 'carp_s1',
      sectionId: 'carp_sec_door',
      title: 'Door Repair & Hinge Adjustment',
      badgeText: 'Bestseller',
      rating: 4.82,
      ratingCount: '19.4K',
      price: 249,
      originalPrice: 349,
      duration: '35 mins',
      imageUrl: 'https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Creaking & sticking door planers adjustment',
        'Rust-free hinge replacement & lubrication',
        'Door stopper & buffer pad installation',
      ],
      description: 'Fix alignment issues, jamming doors, and squeaky hinges for wooden and flush doors.',
    ),
    const KitchenCleaningServiceItem(
      id: 'carp_s2',
      sectionId: 'carp_sec_door',
      title: 'Door Lock / Handle Replacement & Repair',
      rating: 4.86,
      ratingCount: '27.8K',
      price: 199,
      originalPrice: 299,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Mortise lock, cylindrical knob & latch fitting',
        'Keyhole plate alignment and wood chiseling',
        'Smart digital door lock mounting assistance',
      ],
      description: 'Secure door lock installation and handle replacement for main doors and bedrooms.',
    ),

    // --- SECTION 2: Drilling & Wall Mounting ---
    const KitchenCleaningServiceItem(
      id: 'carp_s3',
      sectionId: 'carp_sec_drill',
      title: 'Drill & Hang (Wall Shelves, TV, Frames)',
      badgeText: 'Essential ★',
      rating: 4.89,
      ratingCount: '49.2K',
      price: 149,
      originalPrice: 199,
      duration: '20 mins',
      imageUrl: 'https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Precision heavy-duty wall drilling',
        'Hanging paintings, mirrors, clocks & shelves',
        'Includes wall plugs and anchor screws',
      ],
      description: 'Neat and secure wall drilling for wall decor, floating shelves, mirrors, and frames.',
    ),
    const KitchenCleaningServiceItem(
      id: 'carp_s5',
      sectionId: 'carp_sec_drill',
      title: 'Window Latch & Curtain Rod Installation',
      rating: 4.81,
      ratingCount: '16.9K',
      price: 249,
      originalPrice: 349,
      duration: '30 mins',
      imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Single & double curtain bracket mounting',
        'Wooden & aluminum window latch replacement',
        'Blind brackets & track fitting',
      ],
      description: 'Sturdy curtain rod and blind bracket fitting along with window latch maintenance.',
    ),

    // --- SECTION 3: Furniture & Assembly ---
    const KitchenCleaningServiceItem(
      id: 'carp_s4',
      sectionId: 'carp_sec_assembly',
      title: 'Cupboard & Drawer Channel Repair',
      rating: 4.78,
      ratingCount: '14.1K',
      price: 299,
      originalPrice: 399,
      duration: '40 mins',
      imageUrl: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Telescopic channel & soft-close runner replacement',
        'Loose drawer bottom panel reinforcement',
        'Handle & magnetic catch fitting',
      ],
      description: 'Restore smooth sliding to kitchen cupboards and bedroom drawers.',
    ),
    const KitchenCleaningServiceItem(
      id: 'carp_s7',
      sectionId: 'carp_sec_assembly',
      title: 'Flat-Pack Furniture Assembly (IKEA / Custom)',
      badgeText: 'Popular',
      rating: 4.88,
      ratingCount: '22.3K',
      price: 499,
      originalPrice: 699,
      duration: '60 mins',
      imageUrl: 'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?auto=format&fit=crop&w=400&q=80',
      bulletPoints: [
        'Complete assembly for tables, chairs & bookshelves',
        'Minifix, cam lock & dowel joining expert alignment',
        'Post-assembly stability testing',
      ],
      description: 'Fast and error-free assembly of packaged flat-pack furniture from IKEA, Pepperfry, Urban Ladder, etc.',
    ),

    // --- SECTION 4: MINI SERVICES ---
    const KitchenCleaningServiceItem(
      id: 'mini_carp_1',
      sectionId: 'mini',
      title: 'Door Stopper Fitting',
      rating: 4.82,
      ratingCount: '2.5K+',
      duration: '15 mins',
      price: 69.0,
      imageUrl: 'https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_carp_2',
      sectionId: 'mini',
      title: 'Hinge Lubrication & Fix',
      rating: 4.79,
      ratingCount: '3.8K+',
      duration: '15 mins',
      price: 89.0,
      imageUrl: 'https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_carp_3',
      sectionId: 'mini',
      title: 'Curtain Bracket Tightening',
      rating: 4.85,
      ratingCount: '1.9K+',
      duration: '20 mins',
      price: 99.0,
      imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=400&q=80',
    ),
    const KitchenCleaningServiceItem(
      id: 'mini_carp_4',
      sectionId: 'mini',
      title: 'Handle Replacement',
      rating: 4.76,
      ratingCount: '2.7K+',
      duration: '15 mins',
      price: 79.0,
      imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  // Common FAQ items for Home Services
  static final List<KitchenFaqItem> defaultFaqs = [
    const KitchenFaqItem(
      id: 'faq_1',
      question: 'Are SewaSetu technicians background verified?',
      answer: 'Yes, 100% of our professionals undergo strict police background verification and skill certification tests before onboarding.',
    ),
    const KitchenFaqItem(
      id: 'faq_2',
      question: 'Is there any warranty on repair services?',
      answer: 'All our electrician, plumbing, and carpentry services come with a 30-day SewaSetu Service Protection Guarantee.',
    ),
    const KitchenFaqItem(
      id: 'faq_3',
      question: 'What if spare parts are required during the repair?',
      answer: 'Our professional will provide a transparent rate card for genuine spare parts, or you can purchase parts independently.',
    ),
  ];

  // Common Why Us Features
  static final List<String> defaultWhyUsFeatures = [
    '30-Day Service Guarantee',
    'Certified & Background-Verified Experts',
    'Upfront & Transparent Pricing',
    'Post-Service Cleanliness Assured',
  ];

  // Common Rating Breakdown
  static const ratingBreakdown = RatingBreakdownModel(
    avgRating: 4.82,
    totalCount: 142850,
    starCounts: {
      5: 118450,
      4: 16200,
      3: 5100,
      2: 1900,
      1: 1200,
    },
  );
}
