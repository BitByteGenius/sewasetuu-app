import '../../models/product_model.dart';
import '../../models/product_review_model.dart';
import '../../models/product_variant_model.dart';
import '../../models/shop_category_model.dart';
import '../../models/shop_state_model.dart';

/// Centralized Mock Data Source providing authentic regional cultural products and state catalogs
class ShopMockDatasource {
  static final List<ShopStateModel> states = [
    const ShopStateModel(
      id: 'assam',
      name: 'Assam',
      slug: 'assam',
      region: 'North East',
      description:
          'Land of the Red River and Blue Hills, famous for exquisite Golden Muga Silk, aromatic CTC orthodox tea, bell metal craftsmanship, and bamboo heritage.',
      shortDescription: 'Golden Muga Silk, Organic Orthodox Tea & Bell Metal Crafts',
      image:
          'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 18,
      culturalHighlights: [
        'Muga & Eri Silk',
        'Kahi Pital (Sarthebari Bell Metal)',
        'Traditional Japi',
        'Assam Orthodox Black Tea',
        'Bodo & Karbi Weaves',
      ],
    ),
    const ShopStateModel(
      id: 'bihar',
      name: 'Bihar',
      slug: 'bihar',
      region: 'East',
      description:
          'Birthplace of ancient universities and sacred traditions, home to GI-tagged Mithila Madhubani paintings, Bhagalpuri Tussar silk, pure Makhana, and Sikki grass art.',
      shortDescription: 'Mithila Madhubani Paintings, Organic Makhana & Bhagalpuri Silk',
      image:
          'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 16,
      culturalHighlights: [
        'Madhubani Art',
        'Bhagalpur Silk',
        'Pure Phool Makhana',
        'Sikki Grass Crafts',
        'Traditional Thekua',
      ],
    ),
    const ShopStateModel(
      id: 'rajasthan',
      name: 'Rajasthan',
      slug: 'rajasthan',
      region: 'West',
      description:
          'The royal heritage of vibrant colors, Jaipur blue pottery, intricate Bandhani textiles, block-printed razai quilts, and royal puppet crafts.',
      shortDescription: 'Jaipur Blue Pottery, Bandhani Sarees & Handcrafted Quilts',
      image:
          'https://images.unsplash.com/photo-1599661046289-e31897846e41?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 22,
      culturalHighlights: [
        'Blue Pottery',
        'Bandhani Tie & Dye',
        'Jaipuri Razai',
        'Kathputli Puppets',
        'Marble Crafts',
      ],
    ),
    const ShopStateModel(
      id: 'west_bengal',
      name: 'West Bengal',
      slug: 'west-bengal',
      region: 'East',
      description:
          'Rich artistic cultural hub renowned for Baluchari and Jamdani handloom sarees, Terracotta Bankura horse sculptures, Dokra brass castings, and Darjeeling tea.',
      shortDescription: 'Bankura Terracotta, Baluchari Handloom & Darjeeling Tea',
      image:
          'https://images.unsplash.com/photo-1558431382-27e303142255?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 15,
      culturalHighlights: [
        'Bankura Terracotta',
        'Baluchari Saree',
        'Dokra Metal Casts',
        'Darjeeling Muscatel Tea',
        'Kalighat Folk Art',
      ],
    ),
    const ShopStateModel(
      id: 'meghalaya',
      name: 'Meghalaya',
      slug: 'meghalaya',
      region: 'North East',
      description:
          'The Abode of Clouds, celebrated for handwoven bamboo cane products, high-curcumin Lakadong turmeric, wild organic honey, and Khasi traditional attire.',
      shortDescription: 'Lakadong Turmeric, Khasi Bamboo Stools & Organic Wild Honey',
      image:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 12,
      culturalHighlights: [
        'Lakadong Turmeric',
        'Khasi Cane Crafts',
        'Sohra Wild Honey',
        'Eri Silk Ryndia Shawls',
      ],
    ),
    const ShopStateModel(
      id: 'kerala',
      name: 'Kerala',
      slug: 'kerala',
      region: 'South',
      description:
          'God’s Own Country, famed for metallic Aranmula Kannadi mirrors, pure Kasavu gold-zari handlooms, Tellicherry black peppercorns, and coconut wood crafts.',
      shortDescription: 'Aranmula Mirrors, Kasavu Handloom & Tellicherry Spices',
      image:
          'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?auto=format&fit=crop&w=800&q=80',
      isFeatured: false,
      productCount: 14,
      culturalHighlights: [
        'Aranmula Metal Mirror',
        'Kasavu Sarees',
        'Malabar Spices',
        'Kathakali Wood Carvings',
      ],
    ),
    const ShopStateModel(
      id: 'gujarat',
      name: 'Gujarat',
      slug: 'gujarat',
      region: 'West',
      description:
          'Vibrant heart of artisanal excellence, famous for double-ikat Patan Patola, Kutch Rogan fabric painting, mirror-work embroidery, and roasted snacks.',
      shortDescription: 'Patan Patola, Kutch Rogan Art & Hand-Embroidered Torans',
      image:
          'https://images.unsplash.com/photo-1596178065887-1198b6148b2b?auto=format&fit=crop&w=800&q=80',
      isFeatured: false,
      productCount: 17,
      culturalHighlights: [
        'Patan Patola',
        'Rogan Art',
        'Kutch Mirrorwork',
        'Sankheda Lacquered Furniture',
      ],
    ),
    const ShopStateModel(
      id: 'tamil_nadu',
      name: 'Tamil Nadu',
      slug: 'tamil-nadu',
      region: 'South',
      description:
          'Ancient Dravidian heritage with authentic gold-leaf Thanjavur paintings, heavy temple Kanchipuram silk sarees, and Swamimalai lost-wax bronze sculptures.',
      shortDescription: 'Thanjavur Gold Paintings, Kanchipuram Silk & Bronze Sculptures',
      image:
          'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=800&q=80',
      isFeatured: false,
      productCount: 16,
      culturalHighlights: [
        'Kanchipuram Silk',
        'Thanjavur Art',
        'Swamimalai Bronze',
        'Chettinad Terracotta',
      ],
    ),
    const ShopStateModel(
      id: 'punjab',
      name: 'Punjab',
      slug: 'punjab',
      region: 'North',
      description:
          'The fertile heartland known for radiant hand-embroidered Phulkari dupattas, handcrafted leather Amritsari juttis, and natural organic jaggery sweets.',
      shortDescription: 'Phulkari Hand Embroidery, Amritsari Jutti & Pure Jaggery',
      image:
          'https://images.unsplash.com/photo-1588714477688-cf28a50e94f7?auto=format&fit=crop&w=800&q=80',
      isFeatured: false,
      productCount: 11,
      culturalHighlights: [
        'Phulkari Dupattas',
        'Amritsari Leather Jutti',
        'Desi Gur / Jaggery',
        'Brass Parat Kitchenware',
      ],
    ),
    const ShopStateModel(
      id: 'jammu_kashmir',
      name: 'Jammu & Kashmir',
      slug: 'jammu-kashmir',
      region: 'North',
      description:
          'Paradise on Earth with royal Pashmina hand-spun shawls, world-renowned Pampore Kashmiri saffron, carved walnut wood creations, and traditional Kahwa tea.',
      shortDescription: 'Pure Pashmina Shawls, Pampore Saffron & Carved Walnut Wood',
      image:
          'https://images.unsplash.com/photo-1566837945700-30057527ade0?auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      productCount: 19,
      culturalHighlights: [
        'Pure Kashmiri Pashmina',
        'Pampore Grade-A Saffron',
        'Walnut Wood Carvings',
        'Paper Mache Artifacts',
        'Shahi Kashmiri Kahwa',
      ],
    ),
  ];

  static final List<ShopCategoryModel> categories = [
    const ShopCategoryModel(
      id: 'clothing',
      name: 'Traditional Clothing',
      slug: 'clothing',
      image:
          'https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '👘',
      description: 'Handloom sarees, silk attires, stoles, dupattas & ethnic apparel',
    ),
    const ShopCategoryModel(
      id: 'handicrafts',
      name: 'Handicrafts & Art',
      slug: 'handicrafts',
      image:
          'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '🎨',
      description: 'Traditional paintings, brassware, terracotta, metal craft & folk sculptures',
    ),
    const ShopCategoryModel(
      id: 'food',
      name: 'Food & Local Delicacies',
      slug: 'food',
      image:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '🍲',
      description: 'Organic Makhana, orthodox teas, saffron, spices & native snacks',
    ),
    const ShopCategoryModel(
      id: 'jewellery',
      name: 'Traditional Jewellery',
      slug: 'jewellery',
      image:
          'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '💍',
      description: 'Heritage silver, meenakari, tribal beads & gold-washed filigree',
    ),
    const ShopCategoryModel(
      id: 'decor',
      name: 'Home & Living Decor',
      slug: 'decor',
      image:
          'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '🏺',
      description: 'Handcrafted bell metal, blue pottery, bamboo lamps & wooden hangings',
    ),
    const ShopCategoryModel(
      id: 'cultural',
      name: 'Cultural & Sacred Goods',
      slug: 'cultural',
      image:
          'https://images.unsplash.com/photo-1578328819058-b69f3a3b0f6b?auto=format&fit=crop&w=500&q=80',
      iconEmoji: '🪔',
      description: 'Puja brass items, japis, prayer shawls & ancestral heritage pieces',
    ),
  ];

  static final List<ProductModel> products = [
    // ASSAM PRODUCTS
    const ProductModel(
      id: 'prod-as-1',
      name: 'Handwoven Pure Muga Silk Mekhela Sador with Gold Zari',
      slug: 'pure-muga-silk-mekhela-sador',
      description:
          'Crafted from natural golden Muga silk exclusively native to Assam, this timeless Mekhela Sador is hand-woven on traditional looms in Sualkuchi. Features intricate red and green Kingkhap motifs with pure zari finishing. Known to outlive generations while increasing its golden luster with each wash.',
      shortDescription: 'Authentic GI-Tagged Sualkuchi Golden Silk with Traditional Kingkhap Weave',
      stateId: 'assam',
      stateName: 'Assam',
      categoryId: 'clothing',
      categoryName: 'Traditional Clothing',
      images: [
        'https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?auto=format&fit=crop&w=800&q=80',
      ],
      price: 18500.0,
      originalPrice: 22000.0,
      discountPercentage: 15,
      rating: 4.9,
      reviewCount: 48,
      stock: 5,
      isFeatured: true,
      isPopular: true,
      culturalSignificance:
          'Muga silk is culturally sacred in Assam, worn during Rongali Bihu and weddings. It holds the geographical indication (GI) tag as the pride of Northeast India.',
      material: '100% Pure Assam Muga Silk',
      origin: 'Sualkuchi, Assam',
      sellerName: 'Sualkuchi Handloom Weavers Cooperative',
      tags: ['Muga Silk', 'Assam Silk', 'Mekhela Sador', 'Handloom', 'Wedding'],
    ),
    const ProductModel(
      id: 'prod-as-2',
      name: 'Sarthebari Handcrafted Bell Metal (Kahi Pital) Dinner Thali Set',
      slug: 'sarthebari-bell-metal-kahi-pital-set',
      description:
          'Artisanal 5-piece bell metal dining set handcrafted in the historic artisan village of Sarthebari. Includes one large Kahi (plate), Maihang bowl, Bati (curry bowl), and traditional drinking glass. Bell metal is revered in Ayurveda for purifying food and enhancing digestion.',
      shortDescription: 'Traditional 5-Piece Hand-beaten Bronze Bell Metal Dining Set',
      stateId: 'assam',
      stateName: 'Assam',
      categoryId: 'decor',
      categoryName: 'Home & Living Decor',
      images: [
        'https://images.unsplash.com/photo-1615865417491-9941019fbc00?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?auto=format&fit=crop&w=800&q=80',
      ],
      price: 4800.0,
      originalPrice: 5500.0,
      discountPercentage: 12,
      rating: 4.85,
      reviewCount: 34,
      stock: 12,
      isFeatured: true,
      isPopular: true,
      culturalSignificance:
          'Kahi Pital is the hallmark of Assamese hospitality. In every traditional feast, guests of honor are served on Sarthebari bell metalware.',
      material: 'Traditional Bell Metal (78% Copper, 22% Tin)',
      origin: 'Sarthebari, Barpeta, Assam',
      sellerName: 'Sarthebari Kansari Samabai Samiti',
      tags: ['Kahi Pital', 'Bell Metal', 'Sarthebari', 'Bronze', 'Ayurveda'],
    ),
    const ProductModel(
      id: 'prod-as-3',
      name: 'Assam Golden Tippy Orthodox Black Tea (Whole Leaf)',
      slug: 'assam-golden-tippy-orthodox-tea',
      description:
          'Single-estate Second Flush orthodox black tea grown in the Upper Assam Brahmaputra valley. Abundant in velvety golden tips, producing a rich malty brew with amber brightness and naturally sweet undertones.',
      shortDescription: 'Single Estate Second Flush Tea with Rich Malty Character',
      stateId: 'assam',
      stateName: 'Assam',
      categoryId: 'food',
      categoryName: 'Food & Local Delicacies',
      images: [
        'https://images.unsplash.com/photo-1576092768241-dec231879fc3?auto=format&fit=crop&w=800&q=80',
      ],
      price: 650.0,
      originalPrice: 800.0,
      discountPercentage: 18,
      rating: 4.95,
      reviewCount: 112,
      stock: 45,
      isFeatured: false,
      isPopular: true,
      variants: [
        ProductVariantModel(id: 'tea-250', name: '250g Tin Caddy', type: 'Weight', value: '250g', priceDelta: 0.0),
        ProductVariantModel(id: 'tea-500', name: '500g Value Pack', type: 'Weight', value: '500g', priceDelta: 550.0),
        ProductVariantModel(id: 'tea-1kg', name: '1 Kg Estate Master Pack', type: 'Weight', value: '1kg', priceDelta: 1600.0),
      ],
      culturalSignificance:
          'Assam produces over half of India’s tea. The golden orthodox harvest is recognized worldwide as the benchmark for morning teas.',
      material: '100% Organically Grown Orthodox Tea Leaves',
      origin: 'Dibrugarh, Upper Assam',
      sellerName: 'Dikom Heritage Tea Estate',
      tags: ['Assam Tea', 'Orthodox Tea', 'Golden Tips', 'Beverage'],
    ),
    const ProductModel(
      id: 'prod-as-4',
      name: 'Decorative Handmade Traditional Assamese Japi (Medium)',
      slug: 'traditional-assamese-japi',
      description:
          'Conical headgear woven by rural artisans using tightly bound Tokou pat (palm leaves) and fine bamboo strips, adorned with red and green velvet cloth and woolen tassels. Symbolizes dignity, respect, and cordial Assamese welcome.',
      shortDescription: 'Iconic Palm Leaf & Bamboo Folk Art Piece for Wall Decor',
      stateId: 'assam',
      stateName: 'Assam',
      categoryId: 'cultural',
      categoryName: 'Cultural & Sacred Goods',
      images: [
        'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=800&q=80',
      ],
      price: 1250.0,
      originalPrice: 1500.0,
      discountPercentage: 16,
      rating: 4.7,
      reviewCount: 29,
      stock: 20,
      isFeatured: false,
      isPopular: false,
      culturalSignificance:
          'Presented to esteemed guests along with a Phulam Gamosa, the Japi is the grand emblem of Assamese cultural identity.',
      material: 'Bamboo, Tokou Palm Leaves, Velvet and Tassels',
      origin: 'Nalbari, Assam',
      sellerName: 'Pragjyotish Art & Cane Workshop',
      tags: ['Japi', 'Bamboo', 'Assamese Heritage', 'Wall Decor'],
    ),

    // BIHAR PRODUCTS
    const ProductModel(
      id: 'prod-bh-1',
      name: 'Authentic Handpainted Madhubani Mithila Peacock Painting on Handmade Paper',
      slug: 'authentic-handpainted-madhubani-painting',
      description:
          'Original Kohbar & Mayur (Peacock) Madhubani artwork hand-painted by master artisans of Ranti village, Madhubani. Painted using natural dyes extracted from turmeric, indigo, kusum flowers, and soot, applying fine bamboo nibs and twigs on handmade cotton paper. Signed by the master artist with certificate of authenticity.',
      shortDescription: 'Certified Original Mithila Folk Art with Natural Organic Dyes',
      stateId: 'bihar',
      stateName: 'Bihar',
      categoryId: 'handicrafts',
      categoryName: 'Handicrafts & Art',
      images: [
        'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?auto=format&fit=crop&w=800&q=80',
      ],
      price: 3400.0,
      originalPrice: 4200.0,
      discountPercentage: 19,
      rating: 4.95,
      reviewCount: 62,
      stock: 8,
      isFeatured: true,
      isPopular: true,
      variants: [
        ProductVariantModel(id: 'mb-med', name: '15 x 22 inches', type: 'Size', value: 'Medium', priceDelta: 0.0),
        ProductVariantModel(id: 'mb-lrg', name: '22 x 30 inches Framed', type: 'Size', value: 'Large', priceDelta: 2200.0),
      ],
      culturalSignificance:
          'Originating from the Kingdom of Janaka in the Ramayana, Madhubani art is practiced by generations of Maithil women to celebrate weddings and festivals.',
      material: 'Handmade Acid-free Paper, Natural Herbal & Mineral Pigments',
      origin: 'Madhubani District, Bihar',
      sellerName: 'Mithila Kalakriti Mahila Kendra',
      tags: ['Madhubani', 'Mithila Painting', 'Folk Art', 'Bihar', 'Handmade'],
    ),
    const ProductModel(
      id: 'prod-bh-2',
      name: 'Mithila Pure Jumbo Phool Makhana (Organic Roasted Fox Nuts)',
      slug: 'mithila-pure-jumbo-makhana',
      description:
          'GI-tagged Mithila Phool Makhana harvested from the freshwater wetlands of Darbhanga and Madhubani. Extra-large jumbo flakes hand-graded and naturally sun-dried. Rich in protein, magnesium, and antioxidants with zero cholesterol.',
      shortDescription: 'GI-Tagged Premium Wetland Fox Nuts (Direct from Farmers)',
      stateId: 'bihar',
      stateName: 'Bihar',
      categoryId: 'food',
      categoryName: 'Food & Local Delicacies',
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
      ],
      price: 499.0,
      originalPrice: 650.0,
      discountPercentage: 23,
      rating: 4.9,
      reviewCount: 154,
      stock: 60,
      isFeatured: true,
      isPopular: true,
      variants: [
        ProductVariantModel(id: 'mak-250', name: '250g Pouch', type: 'Weight', value: '250g', priceDelta: 0.0),
        ProductVariantModel(id: 'mak-500', name: '500g Jar', type: 'Weight', value: '500g', priceDelta: 420.0),
        ProductVariantModel(id: 'mak-1000', name: '1kg Family Pack', type: 'Weight', value: '1kg', priceDelta: 1100.0),
      ],
      culturalSignificance:
          'Bihar produces over 90% of the world’s makhana. It is considered an auspicious food offering during Chhath Puja and Kojagiri Lakshmi Puja.',
      material: '100% Organic Water Lily Seeds',
      origin: 'Darbhanga, Bihar',
      sellerName: 'Mithila Agro Farmers Producer Co.',
      tags: ['Makhana', 'Fox Nuts', 'Healthy Snack', 'Organic', 'Bihar'],
    ),
    const ProductModel(
      id: 'prod-bh-3',
      name: 'Bhagalpuri Handwoven Tussar Silk Saree with Temple Border',
      slug: 'bhagalpuri-handwoven-tussar-silk-saree',
      description:
          'Known as the "Silk City", Bhagalpur weavers create this pure, breathable Tussar silk saree with a natural gold-beige textured body and contrast hand-block printed temple motifs. Drapes gracefully with earthy elegance.',
      shortDescription: 'Pure Handloom Tussar Saree with Natural Silk Sheen',
      stateId: 'bihar',
      stateName: 'Bihar',
      categoryId: 'clothing',
      categoryName: 'Traditional Clothing',
      images: [
        'https://images.unsplash.com/photo-1610030469983-98e550d6193c?auto=format&fit=crop&w=800&q=80',
      ],
      price: 5800.0,
      originalPrice: 7200.0,
      discountPercentage: 19,
      rating: 4.8,
      reviewCount: 38,
      stock: 7,
      isFeatured: false,
      isPopular: true,
      culturalSignificance:
          'Bhagalpuri silk weaving dates back centuries, distinguished by wild forest silkworms producing uniquely textured and durable threads.',
      material: '100% Pure Bhagalpuri Tussar Silk',
      origin: 'Bhagalpur, Bihar',
      sellerName: 'Champanagar Weavers Guild',
      tags: ['Bhagalpur Silk', 'Tussar Silk', 'Handloom Saree', 'Ethnic'],
    ),
    const ProductModel(
      id: 'prod-bh-4',
      name: 'Traditional Chhath Special Handmade Pure Ghee Thekua (500g)',
      slug: 'traditional-pure-ghee-thekua',
      description:
          'Authentic Bihar confection prepared in Desi Cow Ghee with whole wheat flour, jaggery, cardamom, saunf (fennel seeds), and grated dry coconut. Crispy on the outside with a melt-in-the-mouth center.',
      shortDescription: 'Traditional Crispy Jaggery & Ghee Festive Cookies',
      stateId: 'bihar',
      stateName: 'Bihar',
      categoryId: 'food',
      categoryName: 'Food & Local Delicacies',
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
      ],
      price: 380.0,
      originalPrice: 450.0,
      discountPercentage: 15,
      rating: 4.88,
      reviewCount: 92,
      stock: 35,
      isFeatured: false,
      isPopular: false,
      culturalSignificance:
          'Thekua is the revered Maha-Prasad of Chhath Puja, embodying centuries-old culinary folklore across eastern Uttar Pradesh and Bihar.',
      material: 'Whole Wheat, Desi Ghee, Pure Gur (Jaggery), Cardamom',
      origin: 'Patna, Bihar',
      sellerName: 'Bihari Swad Rasoi',
      tags: ['Thekua', 'Sweets', 'Chhath Puja', 'Desi Ghee', 'Traditional Food'],
    ),

    // RAJASTHAN PRODUCTS
    const ProductModel(
      id: 'prod-rj-1',
      name: 'Jaipur Handcrafted Blue Pottery Floral Decorative Vase (10 inch)',
      slug: 'jaipur-handcrafted-blue-pottery-vase',
      description:
          'Quintessential Jaipur blue pottery handcrafted using Egyptian paste and quartz powder without clay. Painted with Persian cobalt blue pigments and hand-glazed floral vines. Fired only once in traditional kilns.',
      shortDescription: 'Iconic GI-Tagged Quartz Ceramic Art Vase with Cobalt Glaze',
      stateId: 'rajasthan',
      stateName: 'Rajasthan',
      categoryId: 'decor',
      categoryName: 'Home & Living Decor',
      images: [
        'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
      ],
      price: 1850.0,
      originalPrice: 2400.0,
      discountPercentage: 22,
      rating: 4.82,
      reviewCount: 41,
      stock: 15,
      isFeatured: true,
      isPopular: true,
      culturalSignificance:
          'Patronized by Maharaja Sawai Ram Singh II in the 19th century, Blue Pottery is one of Jaipur’s most famous artistic heritages.',
      material: 'Ground Quartz, Glass, Natural Gum, Multani Mitti',
      origin: 'Kot Jeweler, Jaipur, Rajasthan',
      sellerName: 'Kripal Blue Pottery Heritage',
      tags: ['Blue Pottery', 'Jaipur', 'Vase', 'Home Decor', 'Ceramic'],
    ),
    const ProductModel(
      id: 'prod-rj-2',
      name: 'Jaipuri Hand-Quilted Mulmul Cotton Razai (Super Soft Double Bed)',
      slug: 'jaipuri-mulmul-cotton-razai',
      description:
          'Famous Jaipuri featherweight quilt crafted with double-layered 100% pure mulmul cotton casing and carded cotton batting. Hand-block printed with Sanganeri floral buta designs.',
      shortDescription: 'Feather-light Carded Cotton Quilt in Hand-block Mulmul',
      stateId: 'rajasthan',
      stateName: 'Rajasthan',
      categoryId: 'clothing',
      categoryName: 'Traditional Clothing',
      images: [
        'https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?auto=format&fit=crop&w=800&q=80',
      ],
      price: 2600.0,
      originalPrice: 3200.0,
      discountPercentage: 18,
      rating: 4.9,
      reviewCount: 76,
      stock: 18,
      isFeatured: false,
      isPopular: true,
      culturalSignificance:
          'Renowned for providing warmth while weighing less than 1 kilogram, Jaipuri Razai is a testament to the master carders (dhuniyas) of the Pink City.',
      material: '100% Mulmul Cotton, Organic Cotton Batting',
      origin: 'Sanganer, Jaipur, Rajasthan',
      sellerName: 'Gulabchand Handprints',
      tags: ['Jaipuri Razai', 'Quilt', 'Cotton', 'Sanganeri Print'],
    ),

    // JAMMU & KASHMIR PRODUCTS
    const ProductModel(
      id: 'prod-jk-1',
      name: 'Pure Hand-Embroidered Kashmiri Pashmina Sozni Shawl',
      slug: 'pure-kashmiri-pashmina-sozni-shawl',
      description:
          'Spun from pure Changthangi mountain goat cashmere wool and needle-embroidered by Kashmiri master artisans with delicate Sozni floral jaal embroidery. Featherlight yet extraordinarily insulating, passing through a ring smoothly.',
      shortDescription: '100% Certified Changthangi Cashmere with Needle Sozni Work',
      stateId: 'jammu_kashmir',
      stateName: 'Jammu & Kashmir',
      categoryId: 'clothing',
      categoryName: 'Traditional Clothing',
      images: [
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?auto=format&fit=crop&w=800&q=80',
      ],
      price: 24500.0,
      originalPrice: 29000.0,
      discountPercentage: 15,
      rating: 4.98,
      reviewCount: 39,
      stock: 4,
      isFeatured: true,
      isPopular: true,
      culturalSignificance:
          'Kashmiri Pashmina has been prized by royal dynasties across Persia, France, and the Mughal empire for over five centuries.',
      material: '100% Pure Ladakhi Pashmina / Cashmere',
      origin: 'Downtown Srinagar, Kashmir',
      sellerName: 'Zaffron & Silk Artisans Guild',
      tags: ['Pashmina', 'Kashmir', 'Sozni', 'Cashmere Shawl', 'Luxury'],
    ),
    const ProductModel(
      id: 'prod-jk-2',
      name: 'Organic Pampore Kashmiri Mongra Saffron (Grade A1 - 2g Glass Vial)',
      slug: 'pampore-kashmiri-mongra-saffron',
      description:
          'Pure, all-red Mongra stigmas hand-plucked from the saffron fields of Pampore. Unadulterated, deep crimson strands with intensely sweet floral aroma, high crocin color yield, and safranal content.',
      shortDescription: 'Pure All-Red Mongra Saffron (Lab Certified Grade A1)',
      stateId: 'jammu_kashmir',
      stateName: 'Jammu & Kashmir',
      categoryId: 'food',
      categoryName: 'Food & Local Delicacies',
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
      ],
      price: 850.0,
      originalPrice: 1050.0,
      discountPercentage: 19,
      rating: 4.96,
      reviewCount: 184,
      stock: 50,
      isFeatured: true,
      isPopular: true,
      variants: [
        ProductVariantModel(id: 'sfr-1g', name: '1 Gram Vial', type: 'Weight', value: '1g', priceDelta: 0.0),
        ProductVariantModel(id: 'sfr-2g', name: '2 Gram Pack', type: 'Weight', value: '2g', priceDelta: 750.0),
        ProductVariantModel(id: 'sfr-5g', name: '5 Gram Luxury Gift Box', type: 'Weight', value: '5g', priceDelta: 2800.0),
      ],
      culturalSignificance:
          'Pampore Saffron is world-renowned for its antioxidant strength and is considered the purest saffron cultivated on earth.',
      material: '100% Natural Crocus Sativus Stigmas',
      origin: 'Pampore, Pulwama, Kashmir',
      sellerName: 'Pampore Kesar Growers Society',
      tags: ['Saffron', 'Kesar', 'Pampore', 'Organic', 'Spices'],
    ),

    // WEST BENGAL PRODUCTS
    const ProductModel(
      id: 'prod-wb-1',
      name: 'Handcrafted Terracotta Bankura Horse Figurine (12 inch)',
      slug: 'handcrafted-terracotta-bankura-horse',
      description:
          'Symbolic terracotta horse sculpture hand-molded on the potter’s wheel in Panchmura, Bankura. Features characteristic elongated erect neck, pointed ears, and symmetrical rhythmic body ridges.',
      shortDescription: 'Famous GI-Tagged Panchmura Terracotta Folk Sculpture',
      stateId: 'west_bengal',
      stateName: 'West Bengal',
      categoryId: 'handicrafts',
      categoryName: 'Handicrafts & Art',
      images: [
        'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?auto=format&fit=crop&w=800&q=80',
      ],
      price: 1450.0,
      originalPrice: 1800.0,
      discountPercentage: 19,
      rating: 4.78,
      reviewCount: 31,
      stock: 14,
      isFeatured: false,
      isPopular: true,
      culturalSignificance:
          'The Bankura Horse is the national emblem of Indian handicrafts, representing courage, fertility, and divine folk devotion.',
      material: 'Baked River Alluvial Clay',
      origin: 'Panchmura, Bankura, West Bengal',
      sellerName: 'Bankura Mrittika Shilpa Kendra',
      tags: ['Bankura Horse', 'Terracotta', 'Bengal Art', 'Sculpture'],
    ),

    // MEGHALAYA PRODUCTS
    const ProductModel(
      id: 'prod-mg-1',
      name: 'Pure Organic Lakadong Turmeric Powder (7%+ High Curcumin - 500g)',
      slug: 'pure-organic-lakadong-turmeric',
      description:
          'Certified natural turmeric organically cultivated in the mineral-rich Jaintia Hills of Meghalaya. Boasts an extraordinarily high curcumin content of 7.5% (compared to 2-3% in standard commercial turmeric), renowned for immune defense.',
      shortDescription: 'World’s Highest Curcumin Natural Mountain Turmeric',
      stateId: 'meghalaya',
      stateName: 'Meghalaya',
      categoryId: 'food',
      categoryName: 'Food & Local Delicacies',
      images: [
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
      ],
      price: 490.0,
      originalPrice: 600.0,
      discountPercentage: 18,
      rating: 4.93,
      reviewCount: 140,
      stock: 40,
      isFeatured: true,
      isPopular: true,
      culturalSignificance:
          'Indigenous to Jaintia tribal farmers, Lakadong turmeric is celebrated worldwide as a superfood and natural Ayurvedic remedy.',
      material: '100% Pure Ground Lakadong Turmeric Root',
      origin: 'Jaintia Hills, Meghalaya',
      sellerName: 'Meghalaya Indigenous Farmers Collective',
      tags: ['Lakadong', 'Turmeric', 'Curcumin', 'Organic', 'Spices'],
    ),
  ];

  static List<ProductReviewModel> getReviewsForProduct(String productId) {
    return const [
      ProductReviewModel(
        id: 'rev-1',
        userName: 'Priyanka Das',
        userAvatar:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
        rating: 5.0,
        dateText: '1 week ago',
        comment:
            'Absolutely genuine quality! You can feel the authenticity of the material. Delivery was prompt and safely packaged.',
      ),
      ProductReviewModel(
        id: 'rev-2',
        userName: 'Arunav Sharma',
        userAvatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
        rating: 5.0,
        dateText: '3 weeks ago',
        comment:
            'So happy to find real regional Indian products on SewaSetu. The packaging came with the artisan details and history card!',
      ),
      ProductReviewModel(
        id: 'rev-3',
        userName: 'Meenakshi Iyer',
        userAvatar:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
        rating: 4.5,
        dateText: '1 month ago',
        comment:
            'Impressed by the craftsmanship. Highly recommended for anyone looking for authentic cultural goods.',
      ),
    ];
  }
}
