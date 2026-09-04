import '../../models/destination_model.dart';
import '../../models/itinerary_day_model.dart';
import '../../models/trip_package_model.dart';
import '../../models/trip_theme_model.dart';

/// Comprehensive realistic travel mock datasource featuring authentic Indian destinations & packages
class TripsMockDatasource {
  static final List<TripThemeModel> themes = [
    const TripThemeModel(
      id: 'theme-adventure',
      name: 'Adventure & Treks',
      slug: 'adventure-treks',
      emoji: '🧗‍♂️',
      imageUrl:
          'https://images.unsplash.com/photo-1551632811-561732d1e306?auto=format&fit=crop&w=600&q=80',
      description: 'High-altitude treks, white water rafting, and mountain paragliding',
      packageCount: 14,
    ),
    const TripThemeModel(
      id: 'theme-mountains',
      name: 'Mountain Escapes',
      slug: 'mountain-escapes',
      emoji: '🏔️',
      imageUrl:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=600&q=80',
      description: 'Himalayan snow peaks, misty pine valleys, and peaceful hill stations',
      packageCount: 22,
    ),
    const TripThemeModel(
      id: 'theme-beach',
      name: 'Beaches & Coastal',
      slug: 'beaches-coastal',
      emoji: '🏖️',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80',
      description: 'Golden sunsets, coastal seafood, scuba diving, and island cruising',
      packageCount: 18,
    ),
    const TripThemeModel(
      id: 'theme-wildlife',
      name: 'Wildlife Safaris',
      slug: 'wildlife-safaris',
      emoji: '🐅',
      imageUrl:
          'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=600&q=80',
      description: 'National parks, one-horned rhinos, Royal Bengal tigers, and jungle camps',
      packageCount: 11,
    ),
    const TripThemeModel(
      id: 'theme-heritage',
      name: 'Heritage & Culture',
      slug: 'heritage-culture',
      emoji: '🏰',
      imageUrl:
          'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=600&q=80',
      description: 'Royal palaces, UNESCO living monuments, and regional cultural celebrations',
      packageCount: 19,
    ),
    const TripThemeModel(
      id: 'theme-honeymoon',
      name: 'Romantic Holidays',
      slug: 'romantic-holidays',
      emoji: '💍',
      imageUrl:
          'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=600&q=80',
      description: 'Private houseboats, scenic valley resorts, and intimate candlelight dining',
      packageCount: 15,
    ),
    const TripThemeModel(
      id: 'theme-roadtrip',
      name: 'Road Expeditions',
      slug: 'road-expeditions',
      emoji: '🚘',
      imageUrl:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      description: 'Scenic high-pass drives, offbeat trails, and rugged vehicle adventures',
      packageCount: 8,
    ),
    const TripThemeModel(
      id: 'theme-nature',
      name: 'Nature & Waterfalls',
      slug: 'nature-waterfalls',
      emoji: '🌿',
      imageUrl:
          'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=600&q=80',
      description: 'Crystal-clear rivers, living root bridges, tea slopes, and cascading falls',
      packageCount: 16,
    ),
  ];

  static final List<DestinationModel> destinations = [
    const DestinationModel(
      id: 'dest-shillong',
      name: 'Shillong & Meghalaya',
      slug: 'shillong-meghalaya',
      state: 'Meghalaya',
      country: 'India',
      shortDescription: 'The Abode of Clouds, crystal-clear rivers, and Living Root Bridges',
      description:
          'Known affectionately as the "Scotland of the East," Shillong and the Meghalaya plateau offer pristine pine forests, mist-veiled gorges, cascading Nohkalikai and Elephant Falls, the legendary Umngot crystal river at Dawki, and centuries-old bio-engineered living root bridges.',
      heroImage:
          'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 342,
      popularMonths: ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'],
      bestTimeToVisit: 'October to April',
      tags: ['Clouds', 'Waterfalls', 'Caves', 'Living Root Bridges', 'Cleanest Village'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 6,
      startingPrice: 13999,
    ),
    const DestinationModel(
      id: 'dest-manali',
      name: 'Manali & Solang Valley',
      slug: 'manali-himachal',
      state: 'Himachal Pradesh',
      country: 'India',
      shortDescription: 'Snow-capped Himalayan peaks, roaring Beas river, and cedar forests',
      description:
          'Nestled on the northern end of the Kullu Valley, Manali is a year-round paradise offering thrilling snow adventures in Solang Valley, trans-Himalayan drives through the Atal Tunnel, apple orchards, soothing Vashisht hot springs, and historic Old Manali cafes.',
      heroImage:
          'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.8,
      reviewCount: 512,
      popularMonths: ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'May', 'Jun'],
      bestTimeToVisit: 'October to June',
      tags: ['Snow', 'Paragliding', 'Atal Tunnel', 'Rohtang', 'River Rafting'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 8,
      startingPrice: 11499,
    ),
    const DestinationModel(
      id: 'dest-goa',
      name: 'Goa Coastal Getaway',
      slug: 'goa-coastal',
      state: 'Goa',
      country: 'India',
      shortDescription: 'Sun-drenched beaches, Portuguese heritage, and vibrant coastal life',
      description:
          'From the lively shores of Calangute and Baga to the tranquil sands of Palolem and Agonda, Goa blends golden tropical coastlines, Portuguese colonial villas in Fontainhas, spice plantations, dolphin spotting, and thrilling water sports.',
      heroImage:
          'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.8,
      reviewCount: 680,
      popularMonths: ['Nov', 'Dec', 'Jan', 'Feb', 'Mar'],
      bestTimeToVisit: 'November to February',
      tags: ['Beaches', 'Water Sports', 'Cruises', 'Heritage', 'Nightlife'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 9,
      startingPrice: 9999,
    ),
    const DestinationModel(
      id: 'dest-kashmir',
      name: 'Kashmir & Gulmarg',
      slug: 'kashmir-gulmarg',
      state: 'Jammu & Kashmir',
      country: 'India',
      shortDescription: 'Paradise on Earth with Dal Lake houseboats and snow-clad gondolas',
      description:
          'Experience the ethereal beauty of Srinagar’s Dal Lake at sunset, sleep in traditional hand-carved cedar houseboats, ride the world’s second-highest cable car at Gulmarg, and walk through the saffron fields and walnut groves of Pahalgam.',
      heroImage:
          'https://images.unsplash.com/photo-1595815771614-ade9d652a65d?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1595815771614-ade9d652a65d?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 420,
      popularMonths: ['Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'],
      bestTimeToVisit: 'December to May',
      tags: ['Houseboat', 'Shikara', 'Gondola', 'Snow', 'Tulip Garden'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 7,
      startingPrice: 17999,
    ),
    const DestinationModel(
      id: 'dest-kerala',
      name: 'Kerala Backwaters & Munnar',
      slug: 'kerala-munnar',
      state: 'Kerala',
      country: 'India',
      shortDescription: 'God’s Own Country with emerald tea gardens and tranquil canals',
      description:
          'Drift along the serene palm-fringed backwaters of Alleppey in a private luxury Kettuvallam, wake up to rolling mist across the tea estates of Munnar, spot wild elephants in Periyar Sanctuary, and enjoy rejuvenating Ayurvedic wellness.',
      heroImage:
          'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 560,
      popularMonths: ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'],
      bestTimeToVisit: 'September to March',
      tags: ['Backwaters', 'Houseboat', 'Tea Estates', 'Ayurveda', 'Spice Hills'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 8,
      startingPrice: 14500,
    ),
    const DestinationModel(
      id: 'dest-ladakh',
      name: 'Leh Ladakh High Pass',
      slug: 'leh-ladakh',
      state: 'Ladakh',
      country: 'India',
      shortDescription: 'The Land of High Passes, cobalt Pangong lake, and ancient monasteries',
      description:
          'Cross the world’s highest motorable passes including Khardung La, witness the surreal changing hues of Pangong Tso, ride double-humped Bactrian camels in the sand dunes of Nubra Valley, and experience ancient Buddhist cliff monasteries.',
      heroImage:
          'https://images.unsplash.com/photo-1581793745862-99fde7fa73d2?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1581793745862-99fde7fa73d2?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 310,
      popularMonths: ['May', 'Jun', 'Jul', 'Aug', 'Sep'],
      bestTimeToVisit: 'May to September',
      tags: ['Pangong Lake', 'Nubra Valley', 'Khardung La', 'Monasteries', 'Stargazing'],
      isFeatured: true,
      isPopular: false,
      totalPackages: 5,
      startingPrice: 22999,
    ),
    const DestinationModel(
      id: 'dest-assam',
      name: 'Kaziranga & Assam Valley',
      slug: 'kaziranga-assam',
      state: 'Assam',
      country: 'India',
      shortDescription: 'Home of the Great One-Horned Rhinoceros and mighty Brahmaputra',
      description:
          'Embark on elephant and jeep safaris in UNESCO World Heritage Kaziranga, explore the lush heritage tea plantations of Upper Assam, cruise the expansive waters of the Brahmaputra at sunset, and visit Majuli, the world’s largest river island.',
      heroImage:
          'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.8,
      reviewCount: 220,
      popularMonths: ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'],
      bestTimeToVisit: 'November to April',
      tags: ['Rhino Safari', 'Brahmaputra Cruise', 'Tea Estates', 'Majuli Island'],
      isFeatured: false,
      isPopular: true,
      totalPackages: 4,
      startingPrice: 12500,
    ),
    const DestinationModel(
      id: 'dest-rajasthan',
      name: 'Rajasthan Royal Heritage',
      slug: 'rajasthan-royal',
      state: 'Rajasthan',
      country: 'India',
      shortDescription: 'Golden forts, romantic palace lakes, and desert dune camps',
      description:
          'Walk through the sandstone ramparts of Jaipur’s Amber Fort, cruise Lake Pichola beneath the white marble palaces of Udaipur, explore the blue lanes of Jodhpur, and sleep under desert starlight in Jaisalmer’s Thar Desert.',
      heroImage:
          'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.8,
      reviewCount: 480,
      popularMonths: ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'],
      bestTimeToVisit: 'October to March',
      tags: ['Palaces', 'Forts', 'Desert Camp', 'Folk Music', 'Royal Heritage'],
      isFeatured: true,
      isPopular: true,
      totalPackages: 7,
      startingPrice: 15999,
    ),
    const DestinationModel(
      id: 'dest-sikkim',
      name: 'Sikkim & Kanchenjunga',
      slug: 'sikkim-kanchenjunga',
      state: 'Sikkim',
      country: 'India',
      shortDescription: 'Sacred lakes, alpine valleys, and breathtaking Kanchenjunga panoramas',
      description:
          'Journey through the Buddhist monasteries of Gangtok, visit the high-altitude glacial waters of Tsomgo Lake near Nathula Pass, walk across Pelling’s transparent skywalk, and watch morning sunrise illuminate Mt. Kanchenjunga.',
      heroImage:
          'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 290,
      popularMonths: ['Mar', 'Apr', 'May', 'Oct', 'Nov', 'Dec'],
      bestTimeToVisit: 'March to May & October to December',
      tags: ['Kanchenjunga', 'Tsomgo Lake', 'Nathula Pass', 'Monasteries'],
      isFeatured: false,
      isPopular: true,
      totalPackages: 5,
      startingPrice: 16500,
    ),
    const DestinationModel(
      id: 'dest-andaman',
      name: 'Andaman & Nicobar Islands',
      slug: 'andaman-islands',
      state: 'Andaman and Nicobar',
      country: 'India',
      shortDescription: 'Turquoise waters, coral reef diving, and Radhanagar Beach sunsets',
      description:
          'Escape to the remote Bay of Bengal islands, dive with sea turtles in Havelock Island’s colorful reefs, walk on Asia’s finest Radhanagar Beach, experience bioluminescence night kayaking, and visit the historic Cellular Jail.',
      heroImage:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
      images: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
      ],
      rating: 4.9,
      reviewCount: 380,
      popularMonths: ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'],
      bestTimeToVisit: 'October to May',
      tags: ['Scuba Diving', 'Radhanagar Beach', 'Coral Reefs', 'Island Cruise'],
      isFeatured: true,
      isPopular: false,
      totalPackages: 6,
      startingPrice: 24999,
    ),
  ];

  static final List<TripPackageModel> packages = [
    // 1. Meghalaya Cascades & Cloud Trail
    TripPackageModel(
      id: 'pkg-meghalaya-cloud-trail',
      title: 'Meghalaya Cascades & Living Roots Cloud Trail',
      slug: 'meghalaya-cascades-cloud-trail',
      destinationId: 'dest-shillong',
      destinationName: 'Shillong & Meghalaya',
      destinationState: 'Meghalaya',
      shortDescription:
          'Walk across living root bridges, cruise the crystal Dawki river, and stand above misty Cherrapunjee waterfalls.',
      description:
          'Immerse yourself in the magic of Northeast India. This all-inclusive 5-day journey takes you from the pine-scented colonial streets of Shillong to the dramatic limestone gorges of Cherrapunjee. Stand beside the mighty Nohkalikai Falls, explore Mawsmai and Arwah prehistoric caves, trek through ancient jungle paths to the Double Decker Living Root Bridge, and glide across the glass-like waters of Umngot River in Dawki on the Indo-Bangladesh border.',
      coverImage:
          'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 5,
      durationNights: 4,
      basePrice: 14999,
      originalPrice: 19999,
      discountPercentage: 25,
      rating: 4.9,
      reviewCount: 148,
      minTravelers: 1,
      maxTravelers: 12,
      themeIds: ['theme-nature', 'theme-adventure'],
      themeNames: ['Nature & Waterfalls', 'Adventure & Treks'],
      highlights: [
        'Cherrapunjee (Sohra) Cascades & Nohkalikai Falls',
        'Iconic Double Decker Living Root Bridge trek in Nongriat',
        'Boating on crystal transparent Umngot River at Dawki',
        'Visit to Mawlynnong, officially Asia’s cleanest village',
        'Umiam Lake sunset viewpoints & Shillong Peak',
      ],
      includedItems: [
        '4 Nights premium boutique hotel & eco-resort stays',
        'Daily buffet breakfast & authentic regional Khasi dinners',
        'Private sanitized AC SUV for all transfers and sightseeing',
        'Experienced local Khasi guide & certified trek leader',
        'All permits, toll taxes, parking fees, and entry passes',
        'Dawki boating charges included',
      ],
      excludedItems: [
        'Airfare or train tickets to/from Guwahati',
        'Personal camera permits and adventure gear rentals',
        'Lunch meals and personal snacking/beverages',
        'Travel insurance and medical expenses',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Arrival in Guwahati & Scenic Drive to Shillong',
          description:
              'Arrive at Guwahati Airport/Railway Station. Meet your local tour director and begin the scenic 3-hour hillside drive to Shillong. En route, pause at the breathtaking Umiam Lake (Barapani) for photos and waterside refreshments. Check-in to your Shillong boutique hotel and enjoy an evening stroll around Police Bazar and Ward’s Lake.',
          activities: [
            'Guwahati airport pickup',
            'Umiam Lake viewpoint stop',
            'Hotel check-in and briefing',
            'Evening Police Bazar cultural walk',
          ],
          meals: ['Dinner'],
          stayLocation: 'Pine Valley Boutique Hotel, Shillong',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Shillong Highlights & Transfer to Cherrapunjee (Sohra)',
          description:
              'After breakfast, visit the Elephant Falls and Shillong Peak. Continue towards Cherrapunjee through deep limestone canyons. Explore the illuminated chambers of Mawsmai Cave and stand in awe before the 1,115-foot drop of Nohkalikai Falls, India’s tallest plunge waterfall.',
          activities: [
            'Elephant Falls guided walk',
            'Mawsmai limestone cave exploration',
            'Nohkalikai Falls panorama viewpoint',
            'Eco-park gorge rim visit',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Polo Orchid Resort / Cherrapunjee Holiday Resort',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'The Legendary Double Decker Living Root Bridge Trek',
          description:
              'Embark on the iconic trek starting from Tyrna village descending down 3,500 stone stairs into the rainforest valley of Nongriat. Cross thrilling wire hanging bridges to reach the 200-year-old Double Decker Living Root Bridge. Swim in the turquoise natural spring pools before ascending back.',
          activities: [
            'Guided Nongriat rainforest descent',
            'Double Decker Living Root Bridge inspection',
            'Natural rock pool bathing session',
            'Trek ascent & evening relax at resort',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Cherrapunjee Eco Resort',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Crystal Waters of Dawki & Mawlynnong Cleanest Village',
          description:
              'Drive to the border town of Dawki where the Umngot River flows so clear that wooden boats appear to float on glass air. Enjoy a tranquil 45-minute river boat ride. Proceed to Mawlynnong village, famous for its spotless bamboo pathways, pitcher plants, and single living root bridge in Riwai.',
          activities: [
            'Umngot River wooden boat cruise',
            'Indo-Bangladesh border visit',
            'Mawlynnong village cultural heritage walk',
            'Riwai Single Root Bridge visit',
            'Return drive to Shillong for final night',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Pine Valley Boutique Hotel, Shillong',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Don Bosco Museum & Departure to Guwahati',
          description:
              'Visit the world-renowned Don Bosco Centre for Indigenous Cultures in Shillong to discover the heritage of all seven sister states. Proceed along the national highway back to Guwahati Airport for your onward journey home with unforgettable memories.',
          activities: [
            'Don Bosco Indigenous Museum tour',
            'Local handicraft and organic tea shopping',
            'Guwahati Airport drop-off',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 7)),
        DateTime.now().add(const Duration(days: 14)),
        DateTime.now().add(const Duration(days: 21)),
        DateTime.now().add(const Duration(days: 28)),
      ],
      isFeatured: true,
      isPopular: true,
    ),

    // 2. Manali & Solang Snow Adventure
    TripPackageModel(
      id: 'pkg-manali-snow-peaks',
      title: 'Himalayan Snow Peaks & Solang Valley Adventure',
      slug: 'himalayan-snow-peaks-solang-adventure',
      destinationId: 'dest-manali',
      destinationName: 'Manali & Solang Valley',
      destinationState: 'Himachal Pradesh',
      shortDescription:
          'Snow adventures in Solang, trans-Himalayan Atal Tunnel drive, ancient Hadimba temple, and Beas riverside camping.',
      description:
          'Experience the ultimate Himachal alpine holiday. Spend 5 days amidst cedar forests and towering snow peaks. Soar above Solang Valley with tandem paragliding, drive through the engineering marvel of Atal Tunnel to the barren high plateau of Sissu and Lahaul, explore historic wooden pagoda temples, and relax by riverside cafes in Old Manali.',
      coverImage:
          'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1605649487212-47bdab064df8?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 5,
      durationNights: 4,
      basePrice: 12499,
      originalPrice: 16999,
      discountPercentage: 26,
      rating: 4.8,
      reviewCount: 230,
      minTravelers: 1,
      maxTravelers: 15,
      themeIds: ['theme-mountains', 'theme-adventure'],
      themeNames: ['Mountain Escapes', 'Adventure & Treks'],
      highlights: [
        'Solang Valley adventure hub (Snow scooter, Zorbing, Cable car)',
        'Drive through 9.02 km Atal Tunnel to Sissu waterfall (Lahaul)',
        'Historic 16th-century Hadimba Devi cedar temple',
        'Jogini Waterfalls nature hike from Vashisht village',
        'Riverside bonfire night with Himachali folk music',
      ],
      includedItems: [
        '4 Nights premium 3-star mountain view resort stays',
        'Breakfast & dinner daily at hotel restaurant',
        'Private heated vehicle for all tours & Atal Tunnel excursion',
        'Solang Valley entry and cable car ticket',
        'Toll, parking, green tax, and driver allowances',
      ],
      excludedItems: [
        'Paragliding, skiing, and snow scooter direct activity fees',
        'Rohtang Pass NGT national permit fee (if opted)',
        'Lunch meals and personal expenses',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Arrival in Manali & Local Acclimatization',
          description:
              'Arrive in Manali. Check-in to your scenic valley resort with apple orchard views. After freshening up, visit the historic Hadimba Devi Temple built in 1553, explore the Tibetan Monastery, and spend the evening shopping for warm woolens along the vibrant Mall Road.',
          activities: [
            'Hotel check-in & welcome drink',
            'Hadimba Devi Temple visit',
            'Club House & Van Vihar nature walk',
            'Mall Road leisure shopping',
          ],
          meals: ['Dinner'],
          stayLocation: 'Himalayan Heights Resort, Manali',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Solang Valley Thrills & Snow Activities',
          description:
              'Head out early to Solang Valley, India’s premier adventure sports destination. Ride the ropeway cable car to Mt. Phatru for panoramic snow views. Indulge in paragliding, quad biking, and zorbing. Return to Manali for an evening bonfire by the resort.',
          activities: [
            'Solang Valley excursion',
            'Ropeway ride to mountain view deck',
            'Optional snow sports & paragliding',
            'Resort bonfire & music session',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Himalayan Heights Resort, Manali',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Atal Tunnel Crossing & Sissu Waterfall, Lahaul',
          description:
              'Drive through the world-famous Atal Tunnel under the Rohtang Ridge, emerging into the stark, breathtaking trans-Himalayan landscape of Lahaul Valley. Visit Sissu lake and the towering Sissu waterfall cascading down rugged cliff faces.',
          activities: [
            'Atal Tunnel 9.02 km engineering drive',
            'Sissu Village & waterfall trek',
            'Chandra River photo stops',
            'Lahauli cultural lunch stop (self-paid)',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Himalayan Heights Resort, Manali',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Jogini Waterfall Hike & Old Manali Cafes',
          description:
              'Cross the Beas River to Vashisht village, renowned for natural sulfur hot springs. Embark on an easy 45-minute pine trail hike to the cascading Jogini Waterfalls. In the afternoon, explore the bohemian cafes and handicraft shops of Old Manali.',
          activities: [
            'Vashisht Temple & hot spring bath',
            'Jogini Waterfalls pine forest hike',
            'Old Manali artistic cafe culture tour',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Himalayan Heights Resort, Manali',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Naggar Castle & Departure',
          description:
              'On your departure drive, stop at the medieval wood-and-stone Naggar Castle overlooking the Kullu Valley and the Nicholas Roerich Art Gallery before proceeding to your onward departure point.',
          activities: [
            'Naggar Castle heritage visit',
            'Nicholas Roerich Gallery tour',
            'Kullu shawl factory outlet stop',
            'Drop-off at bus station / airport',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 5)),
        DateTime.now().add(const Duration(days: 12)),
        DateTime.now().add(const Duration(days: 19)),
      ],
      isFeatured: true,
      isPopular: true,
    ),

    // 3. Goa Coastal Sun & Island Cruise
    TripPackageModel(
      id: 'pkg-goa-sun-cruise',
      title: 'Goa Coastal Sun, Island Cruise & Scuba Experience',
      slug: 'goa-coastal-sun-island-cruise',
      destinationId: 'dest-goa',
      destinationName: 'Goa Coastal Getaway',
      destinationState: 'Goa',
      shortDescription:
          'Catamaran cruises, Grand Island scuba diving, Latin Quarter Fontainhas heritage, and sunset beach shacks.',
      description:
          'Indulge in 4 days of pure coastal bliss. Explore both North and South Goa in comfort. Dive into the Arabian Sea with certified scuba instructors at Grand Island, visit historic Portuguese churches in Old Goa, stroll through the vibrant pastel streets of Fontainhas, and watch golden sunsets from private catamaran cruises.',
      coverImage:
          'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 4,
      durationNights: 3,
      basePrice: 11999,
      originalPrice: 15499,
      discountPercentage: 22,
      rating: 4.8,
      reviewCount: 310,
      minTravelers: 1,
      maxTravelers: 16,
      themeIds: ['theme-beach', 'theme-honeymoon'],
      themeNames: ['Beaches & Coastal', 'Romantic Holidays'],
      highlights: [
        'Grand Island boat trip with introductory scuba dive & underwater video',
        'Fontainhas Latin Quarter heritage architectural walking tour',
        'Dudhsagar Waterfalls jeep safari (optional add-on)',
        'Sunset Mandovi River luxury cruise with cultural dances',
        'North Goa beach shacks & water sports in Calangute',
      ],
      includedItems: [
        '3 Nights stay at 4-star beachside resort with pool',
        'Daily breakfast buffet at resort',
        'Grand Island boat cruise with light snacks and BBQ lunch',
        'Scuba diving session with certified PADI dive master',
        'Private AC vehicle for all airport & sightseeing transfers',
      ],
      excludedItems: [
        'Water sports like parasailing / jet ski (available at discounted spot rates)',
        'Dinners and personal drinks',
        'Monument entry tickets',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Arrival in Goa & North Beach Exploration',
          description:
              'Arrive at Goa Airport / Thivim station. Private transfer to your luxury beach resort. Unwind by the pool or take a refreshing stroll on Calangute Beach. In the evening, visit Fort Aguada lighthouse overlooking Sinquerim beach.',
          activities: [
            'Airport pickup in private cab',
            'Resort check-in & welcome drink',
            'Fort Aguada sunset viewpoint',
            'Beachside shack evening dinner',
          ],
          meals: [],
          stayLocation: 'The Golden Palms Resort, Calangute',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Grand Island Boat Trip, Dolphin Spotting & Scuba Diving',
          description:
              'Head out early for a coastal boat cruise to Grand Island. Spot wild dolphins playing in the open sea. Undergo a guided scuba diving session with equipment and underwater video recording. Enjoy a barbecue lunch on the secluded island beach.',
          activities: [
            'Grand Island scenic boat expedition',
            'Dolphin spotting in Arabian Sea',
            'PADI-guided scuba diving session',
            'Island buffet lunch & snorkeling',
          ],
          meals: ['Breakfast', 'Lunch'],
          stayLocation: 'The Golden Palms Resort, Calangute',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Fontainhas Latin Quarter & Mandovi River Sunset Cruise',
          description:
              'Discover the cultural soul of Goa in Panaji. Walk along the vibrant Portuguese villas, blue ceramic tiles, and quaint art cafes of Fontainhas. In the evening, board a double-deck catamaran for a 1-hour sunset cruise on the Mandovi River with Goan folk performances.',
          activities: [
            'Fontainhas heritage walking tour',
            'Basilica of Bom Jesus, Old Goa',
            'Mandovi River sunset cruise with Goan folk dance',
          ],
          meals: ['Breakfast'],
          stayLocation: 'The Golden Palms Resort, Calangute',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Leisure Morning & Departure',
          description:
              'Enjoy a relaxed tropical breakfast by the pool. Pick up local cashew nuts, feni, and spices from Mapusa market before your private airport drop-off.',
          activities: [
            'Poolside morning relaxation',
            'Local market souvenir shopping',
            'Airport drop-off',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 4)),
        DateTime.now().add(const Duration(days: 10)),
        DateTime.now().add(const Duration(days: 18)),
      ],
      isFeatured: true,
      isPopular: true,
    ),

    // 4. Kerala Backwaters & Munnar Hills
    TripPackageModel(
      id: 'pkg-kerala-backwaters-munnar',
      title: 'Kerala Emerald Hills & Alleppey Houseboat Odyssey',
      slug: 'kerala-emerald-hills-alleppey-houseboat',
      destinationId: 'dest-kerala',
      destinationName: 'Kerala Backwaters & Munnar',
      destinationState: 'Kerala',
      shortDescription:
          'Misty tea plantations in Munnar, spice hills of Thekkady, and a private luxury houseboat cruise on Alleppey backwaters.',
      description:
          'Experience the purest serenity in God’s Own Country. Spend 5 nights traveling across the Western Ghats down to the Arabian Sea backwaters. Gaze across endless emerald carpets of tea estates in Munnar, encounter wild elephants in Periyar Wildlife Reserve, and drift through silent village canals aboard your private air-conditioned thatched houseboat with a personal chef.',
      coverImage:
          'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 6,
      durationNights: 5,
      basePrice: 18999,
      originalPrice: 24999,
      discountPercentage: 24,
      rating: 4.9,
      reviewCount: 280,
      minTravelers: 2,
      maxTravelers: 10,
      themeIds: ['theme-honeymoon', 'theme-nature'],
      themeNames: ['Romantic Holidays', 'Nature & Waterfalls'],
      highlights: [
        'Overnight stay on a private deluxe Alleppey houseboat with all meals',
        'Scenic drive through Cheeyappara & Valara Waterfalls',
        'Tea museum and Kolukkumalai sunrise viewpoint in Munnar',
        'Periyar National Park jungle boat safari in Thekkady',
        'Traditional Kathakali and Kalaripayattu martial arts show',
      ],
      includedItems: [
        '4 Nights 4-star hotel stays + 1 Night private deluxe Houseboat',
        'All meals on houseboat (Lunch, High Tea, Dinner, Breakfast)',
        'Daily breakfast at hotels in Munnar & Thekkady',
        'Private chauffeur-driven AC sedan for the entire itinerary',
        'Spice plantation tour with botanical guide',
      ],
      excludedItems: [
        'Flight tickets to Cochin (COK)',
        'Periyar boat safari ticket & Kathakali show tickets',
        'Personal Ayurvedic massage treatments',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Cochin Arrival & Scenic Mountain Ascent to Munnar',
          description:
              'Arrive at Cochin International Airport. Meet your private chauffeur and begin the breathtaking ascent to Munnar. Stop by Cheeyappara and Valara waterfalls flowing along lush mountain ledges. Check-in to your hillside tea plantation resort.',
          activities: [
            'Cochin airport greeting & pickup',
            'Cheeyappara & Valara Waterfalls photo stop',
            'Tea garden valley drive',
            'Check-in to Munnar resort',
          ],
          meals: ['Dinner'],
          stayLocation: 'Amber Dale Tea Valley Resort, Munnar',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Munnar Tea Estates, Eravikulam & Mattupetty',
          description:
              'Visit Eravikulam National Park, sanctuary of the endangered Nilgiri Tahr mountain goat. Explore the KDHP Tea Museum to see orthodox tea manufacturing. In the afternoon, enjoy boating on Mattupetty Dam reservoir and Echo Point.',
          activities: [
            'Eravikulam National Park safari bus ride',
            'Tata Tea Museum heritage tour',
            'Mattupetty Dam boat ride & Echo Point',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Amber Dale Tea Valley Resort, Munnar',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Munnar to Thekkady & Spice Plantation Walk',
          description:
              'Drive through the cardamom hills to Thekkady (Periyar). In the afternoon, take a guided walking tour through aromatic spice plantations learning about cardamom, black pepper, cinnamon, and vanilla. Attend an evening Kalaripayattu martial arts demonstration.',
          activities: [
            'Scenic Cardamom Hills drive',
            'Guided Spice Garden exploration',
            'Kalaripayattu ancient martial arts show',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Elephant Court Resort, Thekkady',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Boarding the Private Alleppey Backwater Houseboat',
          description:
              'Drive down towards the palm-fringed Venice of the East, Alleppey. At noon, board your private traditional wooden houseboat (Kettuvallam). Enjoy a welcome tender coconut drink followed by an authentic Kerala Sadhya lunch with Karimeen fish fry. Cruise through tranquil canals lined with paddy fields.',
          activities: [
            'Houseboat embarkation at Alleppey jetty',
            'Authentic Kerala traditional lunch on board',
            'Slow cruising through Vembanad backwaters',
            'Village walk & sunset on the river deck',
          ],
          meals: ['Breakfast', 'Lunch', 'Dinner'],
          stayLocation: 'Private Deluxe AC Houseboat, Alleppey',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Marari Beach Relaxation & Heritage Fort Kochi',
          description:
              'After a sunrise breakfast on the water deck, disembark from the houseboat and transfer to historic Fort Kochi. Marvel at the Chinese Fishing Nets, visit St. Francis Church and the Jewish Synagogue in Mattancherry.',
          activities: [
            'Morning houseboat cruise & disembarkation',
            'Chinese Fishing Nets demonstration',
            'Jew Town antique shopping & Synagogue',
          ],
          meals: ['Breakfast'],
          stayLocation: 'Brunton Boatyard / Heritage Hotel, Fort Kochi',
        ),
        const ItineraryDayModel(
          dayNumber: 6,
          title: 'Departure from Cochin',
          description:
              'Enjoy a relaxed South Indian breakfast before your private airport transfer to Cochin International Airport for your return flight.',
          activities: [
            'Breakfast at hotel',
            'Cochin Airport drop-off',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 6)),
        DateTime.now().add(const Duration(days: 15)),
        DateTime.now().add(const Duration(days: 25)),
      ],
      isFeatured: true,
      isPopular: true,
    ),

    // 5. Kashmir Paradise & Shikara Magic
    TripPackageModel(
      id: 'pkg-kashmir-paradise-shikara',
      title: 'Kashmir Paradise: Dal Lake Houseboat & Gulmarg Gondola',
      slug: 'kashmir-paradise-dal-lake-gulmarg',
      destinationId: 'dest-kashmir',
      destinationName: 'Kashmir & Gulmarg',
      destinationState: 'Jammu & Kashmir',
      shortDescription:
          'Carved cedar houseboats on Dal Lake, Gulmarg high gondola snow rides, and scenic Betaab Valley in Pahalgam.',
      description:
          'Discover why Kashmir has been hailed as Heaven on Earth for centuries. Stay aboard hand-carved heritage houseboats floating serenely on Dal Lake, glide through floating flower markets on traditional Shikaras, ride the world-renowned Gulmarg Gondola to Kongdoori and Apharwat peak, and walk through the pine meadows of Pahalgam.',
      coverImage:
          'https://images.unsplash.com/photo-1595815771614-ade9d652a65d?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1595815771614-ade9d652a65d?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 6,
      durationNights: 5,
      basePrice: 19499,
      originalPrice: 25999,
      discountPercentage: 25,
      rating: 4.9,
      reviewCount: 195,
      minTravelers: 1,
      maxTravelers: 12,
      themeIds: ['theme-mountains', 'theme-honeymoon'],
      themeNames: ['Mountain Escapes', 'Romantic Holidays'],
      highlights: [
        '1 Night stay in a carved luxury houseboat on Dal Lake',
        'Sunset Shikara ride across the floating lotus gardens',
        'Gulmarg Gondola Phase 1 snow excursion',
        'Pahalgam valley tour including Betaab Valley & Aru Valley',
        'Mughal Gardens: Shalimar Bagh & Nishat Bagh in Srinagar',
      ],
      includedItems: [
        '4 Nights 4-star hotel stay in Srinagar/Pahalgam + 1 Night Houseboat',
        'Daily breakfast and four-course Kashmiri dinners (Wazwan options)',
        'Private heated vehicle for all tours & transfers',
        '1-hour Dal Lake Shikara ride included',
        'Toll taxes, driver allowances, and airport transfers',
      ],
      excludedItems: [
        'Gulmarg Gondola ticket (can be pre-booked online)',
        'Pony / horse rides in Pahalgam or Gulmarg',
        'Airfare to/from Srinagar (SXR)',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Arrival in Srinagar & Dal Lake Sunset Shikara',
          description:
              'Arrive at Srinagar Airport. Transfer to your hand-carved heritage houseboat on Dal Lake. Enjoy a warm cup of authentic Kashmiri Kahwa with saffron and crushed almonds. In the evening, embark on a magical 1-hour Shikara ride watching golden reflections ripple across the water.',
          activities: [
            'Srinagar airport pickup & Kahwa welcome',
            'Houseboat check-in on Dal Lake',
            'Sunset Shikara ride through floating markets',
            'Traditional Kashmiri dinner on houseboat',
          ],
          meals: ['Dinner'],
          stayLocation: 'Royal Heritage Cedar Houseboat, Dal Lake',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Srinagar Mughal Gardens & Old City Charms',
          description:
              'Explore the royal Mughal heritage of Srinagar. Visit Nishat Bagh (Garden of Pleasure) and Shalimar Bagh (Abode of Love) built by Emperor Jahangir. Visit the ancient Shankaracharya Temple perched on a hilltop with 360-degree views of the entire Srinagar valley.',
          activities: [
            'Nishat & Shalimar Mughal Gardens',
            'Shankaracharya Hilltop Temple visit',
            'Kashmiri Pashmina & walnut woodcraft shopping',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'The Grand Mamta / RK Sarovar Portico, Srinagar',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Excursion to Gulmarg & Gondola Snow Ride',
          description:
              'Drive through weeping willows and snow-sprinkled slopes to Gulmarg, the Meadow of Flowers. Board the famous Gulmarg Gondola rising up to Kongdoori station. Enjoy walking on crisp Himalayan snow, sledging, or sipping hot tea at high altitude.',
          activities: [
            'Scenic drive through Tangmarg pine curves',
            'Gulmarg Gondola Phase 1 cable car ride',
            'Snow photography & winter activities',
            'Return to Srinagar in the evening',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'The Grand Mamta, Srinagar',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Srinagar to Pahalgam Valley of Shepherds',
          description:
              'Drive to Pahalgam along the Lidder River. En route, stop at the fragrant saffron fields of Pampore and the ancient ruins of Avantipur Temple. Check-in to your riverside resort in Pahalgam and enjoy the sound of roaring glacial waters.',
          activities: [
            'Pampore saffron fields visit',
            'Avantipur 9th-century temple ruins stop',
            'Lidder riverside scenic drive',
            'Check-in to Pahalgam mountain resort',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Pahalgam Pine & River Retreat',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Betaab Valley, Aru & Chandanwari Exploration',
          description:
              'Spend the day exploring the cinematic valleys of Pahalgam: Betaab Valley named after the famous Bollywood movie, the pristine pastures of Aru Valley, and Chandanwari, the starting point of the Amarnath Yatra.',
          activities: [
            'Betaab Valley nature photography',
            'Aru Valley alpine village walk',
            'Evening stroll along Lidder River market',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Pahalgam Pine & River Retreat',
        ),
        const ItineraryDayModel(
          dayNumber: 6,
          title: 'Departure from Srinagar Airport',
          description:
              'After breakfast, take the picturesque 2-hour drive back to Srinagar Airport for your return flight home, taking with you memories of paradise.',
          activities: [
            'Breakfast at Pahalgam resort',
            'Drive to Srinagar International Airport',
            'Departure with memories of Kashmir',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 8)),
        DateTime.now().add(const Duration(days: 16)),
        DateTime.now().add(const Duration(days: 24)),
      ],
      isFeatured: true,
      isPopular: true,
    ),

    // 6. Kaziranga Rhino Safari & Assam Tea Trails
    TripPackageModel(
      id: 'pkg-kaziranga-rhino-safari',
      title: 'Kaziranga Rhino Wildlife Safari & Brahmaputra Tea Trails',
      slug: 'kaziranga-rhino-safari-assam-tea',
      destinationId: 'dest-assam',
      destinationName: 'Kaziranga & Assam Valley',
      destinationState: 'Assam',
      shortDescription:
          'Jeep & elephant safaris in Kaziranga National Park, organic tea estate tours, and Brahmaputra sunset cruises.',
      description:
          'Step into the wild heart of Assam. Explore the UNESCO World Heritage grasslands of Kaziranga National Park, sanctuary to two-thirds of the world’s Great One-Horned Rhinoceroses. Spot wild water buffalo, swamp deer, and royal Bengal tigers on thrilling open-top 4x4 jeep safaris, stay in an eco-lodge surrounded by tea bushes, and cruise the golden waters of the mighty Brahmaputra.',
      coverImage:
          'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 4,
      durationNights: 3,
      basePrice: 13500,
      originalPrice: 17500,
      discountPercentage: 22,
      rating: 4.8,
      reviewCount: 92,
      minTravelers: 2,
      maxTravelers: 8,
      themeIds: ['theme-wildlife', 'theme-nature'],
      themeNames: ['Wildlife Safaris', 'Nature & Waterfalls'],
      highlights: [
        'Two open-top 4x4 Jeep Safaris across Central & Western ranges',
        'Close encounters with the Great One-Horned Rhinoceros',
        'Tour of a historic 100-year-old organic British tea estate',
        'Brahmaputra sunset cruise with Assamese Bihu dance performance',
        'Visit to Kaziranga National Orchid and Biodiversity Park',
      ],
      includedItems: [
        '3 Nights stay in premium jungle eco-resort',
        '2 Scheduled 4x4 Jeep Safaris with forest guards & park permits',
        'All meals (Breakfast, Lunch, and Dinner with Assamese delicacies)',
        'Private AC vehicle for Guwahati-Kaziranga transfers',
        'Orchid Park and cultural show entry passes',
      ],
      excludedItems: [
        'Camera and video equipment fees inside the national park',
        'Elephant safari (optional morning slot subject to forest availability)',
        'Guwahati flights',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Guwahati to Kaziranga National Park',
          description:
              'Pickup from Guwahati Airport. Scenic 4.5-hour drive along Highway 715 through verdant paddy fields and tea gardens to Kaziranga. Check-in to your forest lodge, relax by the greenery, and attend an evening Assamese folk dance show at the Orchid Park.',
          activities: [
            'Guwahati Airport pickup',
            'Highway drive with highway tea stop',
            'Check-in at Kaziranga Jungle Lodge',
            'Kaziranga Orchid Park & Bihu dance show',
          ],
          meals: ['Dinner'],
          stayLocation: 'Iora The Retreat / Diphlu River Lodge, Kaziranga',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Central & Western Range Wildlife Safaris',
          description:
              'Start early with an open-top Jeep Safari through the Central (Kohora) Range, home to the highest density of one-horned rhinos and wild elephants. After lunch at the resort, take an afternoon safari into the Western (Bagori) Range for birdwatching and wetland wildlife.',
          activities: [
            'Morning 4x4 Jeep Safari in Kohora range',
            'Rhino and wild buffalo photography',
            'Lunch at resort restaurant',
            'Afternoon Jeep Safari in Bagori range',
          ],
          meals: ['Breakfast', 'Lunch', 'Dinner'],
          stayLocation: 'Iora The Retreat, Kaziranga',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Heritage Tea Estate Walk & River Dolphin Spotting',
          description:
              'Walk through a surrounding organic tea estate with a master planter, learning how orthodox Assam CTC tea is plucked and processed. Drive to the banks of the Brahmaputra at Silghat for a private country boat ride to spot rare endangered Gangetic River Dolphins.',
          activities: [
            'Guided Tea Estate plucking & tasting tour',
            'Silghat Brahmaputra riverbank drive',
            'Country boat dolphin spotting excursion',
            'Evening campfire under starlit sky',
          ],
          meals: ['Breakfast', 'Lunch', 'Dinner'],
          stayLocation: 'Iora The Retreat, Kaziranga',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Return to Guwahati & Kamakhya Temple',
          description:
              'Drive back towards Guwahati. Visit the sacred hilltop Kamakhya Temple overlooking the Brahmaputra before your scheduled drop-off at Guwahati Airport for departure.',
          activities: [
            'Morning drive from Kaziranga to Guwahati',
            'Nilachal Hill Kamakhya Temple visit',
            'Airport drop-off for flight',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 9)),
        DateTime.now().add(const Duration(days: 17)),
        DateTime.now().add(const Duration(days: 27)),
      ],
      isFeatured: false,
      isPopular: true,
    ),

    // 7. Rajasthan Royal Palaces & Desert Safari
    TripPackageModel(
      id: 'pkg-rajasthan-royal-heritage',
      title: 'Royal Rajasthan: Jaipur Forts & Udaipur Lake Palaces',
      slug: 'royal-rajasthan-jaipur-udaipur-palaces',
      destinationId: 'dest-rajasthan',
      destinationName: 'Rajasthan Royal Heritage',
      destinationState: 'Rajasthan',
      shortDescription:
          'Amber Fort ramparts, Lake Pichola sunset boat ride, City Palace grandeur, and royal Rajasthani hospitality.',
      description:
          'Experience the regal splendors of Rajputana royalty. In Jaipur, marvel at the ornate façade of Hawa Mahal, the astronomy marvel of Jantar Mantar, and the monumental hilltop ramparts of Amber Fort. Journey onward to the Venice of the East, Udaipur, where white marble palaces float on the calm blue waters of Lake Pichola.',
      coverImage:
          'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 5,
      durationNights: 4,
      basePrice: 16999,
      originalPrice: 21999,
      discountPercentage: 23,
      rating: 4.8,
      reviewCount: 260,
      minTravelers: 2,
      maxTravelers: 14,
      themeIds: ['theme-heritage', 'theme-honeymoon'],
      themeNames: ['Heritage & Culture', 'Romantic Holidays'],
      highlights: [
        'Amber Fort elephant / jeep ride to the royal courtyard',
        'Private sunset boat cruise on Lake Pichola in Udaipur',
        'Guided tour of City Palace Jaipur & City Palace Udaipur',
        'Traditional Rajasthani Thali dinner at Chokhi Dhani',
        'Visit to Hawa Mahal, Jal Mahal, and Saheliyon Ki Bari',
      ],
      includedItems: [
        '4 Nights accommodation in 4-star heritage Haveli hotels',
        'Daily royal buffet breakfast at hotels',
        'Private air-conditioned sedan with professional chauffeur',
        'Lake Pichola boat cruise tickets included',
        'All highway tolls, state taxes, and parking fees',
      ],
      excludedItems: [
        'Monument entry tickets and guide fees',
        'Lunches and personal shopping',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Welcome to the Pink City Jaipur',
          description:
              'Arrive at Jaipur Airport/Station. Check-in to your heritage Haveli hotel. Visit the iconic honeycomb façade of Hawa Mahal and the sprawling City Palace. In the evening, immerse in Rajasthani folk dance, camel rides, and a traditional dinner feast at Chokhi Dhani village.',
          activities: [
            'Jaipur arrival & traditional garland welcome',
            'Hawa Mahal & City Palace museum',
            'Chokhi Dhani cultural village evening',
          ],
          meals: ['Dinner'],
          stayLocation: 'Alsisar Haveli / Mandawa Haveli, Jaipur',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Amber Fort, Nahargarh & Jal Mahal',
          description:
              'Ascend the magnificent ramparts of Amber Fort overlooking Maota Lake. See the Sheesh Mahal (Mirror Palace). On the return, stop by Jal Mahal floating in the middle of Man Sagar Lake and catch sunset over the Pink City from Nahargarh Fort.',
          activities: [
            'Amber Fort royal courtyard tour',
            'Sheesh Mahal mirror architecture',
            'Jal Mahal lake photo stop',
            'Sunset over Jaipur from Nahargarh',
          ],
          meals: ['Breakfast'],
          stayLocation: 'Alsisar Haveli, Jaipur',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Scenic Drive to the City of Lakes: Udaipur',
          description:
              'Drive from Jaipur to Udaipur through the Aravali mountain passes. Check-in to your lakeside palace hotel in Udaipur. In the evening, take a leisurely stroll around the Gangaur Ghat and enjoy the Bagore Ki Haveli folk dance show.',
          activities: [
            'Highway drive Jaipur to Udaipur',
            'Lakeside hotel check-in',
            'Bagore Ki Haveli evening cultural show',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Fateh Garh Heritage Palace, Udaipur',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Udaipur City Palace & Sunset Cruise on Lake Pichola',
          description:
              'Explore Udaipur’s monumental City Palace complex, the largest in Rajasthan. Walk through the fountains of Saheliyon Ki Bari. At sunset, board a royal boat for a cruise on Lake Pichola, gliding past Jag Mandir and the Lake Palace.',
          activities: [
            'City Palace Udaipur museum tour',
            'Saheliyon Ki Bari royal gardens',
            'Lake Pichola sunset boat cruise',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Fateh Garh Heritage Palace, Udaipur',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Departure from Udaipur',
          description:
              'Enjoy breakfast overlooking Lake Pichola. Visit Jagdish Temple before your transfer to Maharana Pratap Airport (UDR) for your onward flight.',
          activities: [
            'Breakfast with lake view',
            'Jagdish Temple visit',
            'Udaipur Airport drop-off',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 7)),
        DateTime.now().add(const Duration(days: 14)),
        DateTime.now().add(const Duration(days: 21)),
      ],
      isFeatured: false,
      isPopular: true,
    ),

    // 8. Leh Ladakh Pangong Expedition
    TripPackageModel(
      id: 'pkg-ladakh-pangong-expedition',
      title: 'Leh Ladakh Ultimate Odyssey: Pangong Tso & Nubra Dunes',
      slug: 'leh-ladakh-pangong-nubra-expedition',
      destinationId: 'dest-dest-ladakh',
      destinationName: 'Leh Ladakh High Pass',
      destinationState: 'Ladakh',
      shortDescription:
          'Drive over Khardung La, ride Bactrian camels in Nubra Valley sand dunes, and camp by the electric blue Pangong Tso.',
      description:
          'The road trip of a lifetime. Stand upon the roof of the world in Ladakh. Cross Khardung La at 17,982 feet, descend into the white sand dunes of Hunder in Nubra Valley, spot ancient Buddhist frescoes in Diskit Monastery, camp under the Milky Way at Pangong Tso, and marvel at Magnetic Hill.',
      coverImage:
          'https://images.unsplash.com/photo-1581793745862-99fde7fa73d2?auto=format&fit=crop&w=800&q=80',
      images: [
        'https://images.unsplash.com/photo-1581793745862-99fde7fa73d2?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      ],
      durationDays: 6,
      durationNights: 5,
      basePrice: 23999,
      originalPrice: 31999,
      discountPercentage: 25,
      rating: 4.9,
      reviewCount: 165,
      minTravelers: 2,
      maxTravelers: 10,
      themeIds: ['theme-adventure', 'theme-roadtrip'],
      themeNames: ['Adventure & Treks', 'Road Expeditions'],
      highlights: [
        'Cross Khardung La, one of the world’s highest motorable passes',
        'Overnight luxury tent camping beside the electric blue Pangong Lake',
        'Double-humped camel safari in Hunder Sand Dunes, Nubra',
        'Giant Maitreya Buddha statue at Diskit Monastery',
        'Magnetic Hill, Pathar Sahib Gurudwara & Indus-Zanskar Sangam',
      ],
      includedItems: [
        '5 Nights stay (3N Leh hotel + 1N Nubra deluxe camp + 1N Pangong lake camp)',
        'Daily breakfast and hot dinner',
        'Private 4x4 Scorpio / Innova vehicle with experienced mountain driver',
        'Inner Line Permits and Ladakh environmental fees included',
        'Oxygen cylinder backup in vehicle for high-altitude safety',
      ],
      excludedItems: [
        'Flights to/from Leh Kushok Bakula Rimpochee Airport (IXL)',
        'Camel ride and ATV bike charges in Nubra',
        'Lunches and beverages',
      ],
      itinerary: [
        const ItineraryDayModel(
          dayNumber: 1,
          title: 'Arrival in Leh & Crucial High-Altitude Rest',
          description:
              'Arrive at Leh Airport (11,500 ft). Transfer to your hotel. Complete rest is mandatory today to acclimatize to high altitude and thin air. Sip warm water and ginger-lemon tea. In the late evening, take an easy gentle walk around Leh Main Bazar.',
          activities: [
            'Leh Airport pickup',
            'Full day acclimatization rest',
            'Evening gentle walk in Leh Bazar',
          ],
          meals: ['Dinner'],
          stayLocation: 'The Grand Dragon / Singge Palace, Leh',
        ),
        const ItineraryDayModel(
          dayNumber: 2,
          title: 'Magnetic Hill, Sangam & Hall of Fame',
          description:
              'Take a gentle excursion along the Indus River. Test gravity at the famous Magnetic Hill, visit Gurudwara Pathar Sahib, witness the striking confluence of the muddy Zanskar and blue Indus rivers at Sangam, and honor heroes at the Hall of Fame war museum.',
          activities: [
            'Indus & Zanskar Sangam confluence view',
            'Magnetic Hill anti-gravity demonstration',
            'Hall of Fame museum tour',
            'Shanti Stupa sunset panorama',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'The Grand Dragon, Leh',
        ),
        const ItineraryDayModel(
          dayNumber: 3,
          title: 'Drive over Khardung La to Nubra Valley',
          description:
              'Ascend the mighty Khardung La Pass at 17,982 feet. Capture photos with the iconic summit sign board before descending into the dramatic Nubra Valley. Visit Diskit Monastery with its towering 106-foot golden Buddha and ride double-humped camels in Hunder dunes.',
          activities: [
            'Khardung La high-pass crossing',
            'Diskit Monastery & giant Buddha statue',
            'Hunder Sand Dunes & Bactrian camel ride',
            'Overnight luxury tent camping',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Mystic Meadows Deluxe Camps, Nubra',
        ),
        const ItineraryDayModel(
          dayNumber: 4,
          title: 'Nubra Valley to Pangong Tso via Shyok River',
          description:
              'Drive along the wild, scenic banks of the Shyok River directly to the world-renowned Pangong Tso (14,270 ft). Behold the lake as it changes colors from turquoise to deep cobalt. Spend the evening camping by the lake beneath a dazzling canopy of stars.',
          activities: [
            'Scenic Shyok River off-road drive',
            'First glimpse of Pangong Tso lake',
            'Lakeside photography & 3 Idiots point',
            'Unmatched stargazing & Milky Way photography',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'Pangong Lake Luxury Cottage Camp',
        ),
        const ItineraryDayModel(
          dayNumber: 5,
          title: 'Pangong Sunrise & Return to Leh via Chang La',
          description:
              'Wake early for a magical sunrise over Pangong Lake. Journey back towards Leh crossing Chang La Pass at 17,590 ft. En route, visit the historic Thiksey Monastery, resembling Tibet’s Potala Palace. Enjoy your farewell dinner in Leh.',
          activities: [
            'Pangong Tso sunrise experience',
            'Chang La Pass crossing',
            'Thiksey Monastery architecture tour',
            'Celebratory farewell dinner in Leh',
          ],
          meals: ['Breakfast', 'Dinner'],
          stayLocation: 'The Grand Dragon, Leh',
        ),
        const ItineraryDayModel(
          dayNumber: 6,
          title: 'Departure from Leh',
          description:
              'Early morning transfer to Leh Airport for your scenic mountain flight over the snow-capped Himalayan ranges.',
          activities: [
            'Breakfast at hotel',
            'Leh Airport transfer',
          ],
          meals: ['Breakfast'],
          stayLocation: null,
        ),
      ],
      availableDates: [
        DateTime.now().add(const Duration(days: 10)),
        DateTime.now().add(const Duration(days: 20)),
        DateTime.now().add(const Duration(days: 30)),
      ],
      isFeatured: true,
      isPopular: false,
    ),
  ];
}
