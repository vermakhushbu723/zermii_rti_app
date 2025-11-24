import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  PageController? _bannerPageController;
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();

    _initializeBannerController();
  }

  void _initializeBannerController() {
    _bannerPageController = PageController(viewportFraction: 0.85);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        _startBannerAutoScroll();
      });
    });
  }

  void _startBannerAutoScroll() {
    if (!mounted || _bannerPageController == null) return;

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted &&
          _bannerPageController != null &&
          _bannerPageController!.hasClients) {
        int nextPage = (_currentBannerPage + 1) % 3;
        _bannerPageController!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _currentBannerPage = nextPage;
        _startBannerAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bannerPageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.currentUser?['name'] ?? 'Guest';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, userName),

            /// FIX: Full scrollable ListView (No overflow)
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildBannerSection(),
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 24),
                    _buildServicesGrid(context),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String userName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.location_on_rounded,
              color: Colors.brown,
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.nearbyDealer);
            },
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.brown,
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.customerWallet);
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.brown,
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cartScreen);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    final banners = [
      {
        'title': 'Creative Design',
        'subtitle': 'Modern & Exclusive Furniture',
        'icon': Icons.chair_rounded,
        'colors': [
          AppColors.primarySkyBlue.withOpacity(0.3),
          AppColors.lightSkyBlue.withOpacity(0.5),
        ],
      },
      {
        'title': 'Interior Design',
        'subtitle': 'Professional Consultation',
        'icon': Icons.design_services_rounded,
        'colors': [
          AppColors.deepSkyBlue.withOpacity(0.3),
          AppColors.accentSkyBlue.withOpacity(0.5),
        ],
      },
      {
        'title': 'Custom Furniture',
        'subtitle': 'Tailored to Your Taste',
        'icon': Icons.weekend_rounded,
        'colors': [
          const Color(0xFF87CEEB).withOpacity(0.3),
          const Color(0xFF00BFFF).withOpacity(0.5),
        ],
      },
    ];

    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _bannerPageController!,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: banner['colors'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        banner['title'] as String,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepSkyBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner['subtitle'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.onlineDesignHome,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepSkyBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Icon(
                    banner['icon'] as IconData,
                    color: Colors.white.withOpacity(0.6),
                    size: 80,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                color: AppColors.deepSkyBlue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// GRIDVIEW FIXED (NO OVERFLOW NOW)
  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'image':
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        'title': 'Modern Sofa Set',
        'description': 'Premium 3-seater sofa with cushions',
        'price': '₹24,999',
        'originalPrice': '₹34,999',
        'discount': '29% OFF',
        'rating': '4.5',
        'reviews': '234',
        'route': AppRoutes.onlineDesignHome,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1538688525198-9b88f6f53126?w=400',
        'title': 'Dining Table Set',
        'description': '6-seater wooden dining table',
        'price': '₹18,999',
        'originalPrice': '₹25,999',
        'discount': '27% OFF',
        'rating': '4.8',
        'reviews': '567',
        'route': AppRoutes.nearbyDealer,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
        'title': 'Queen Size Bed',
        'description': 'Luxury king bed with storage',
        'price': '₹29,499',
        'originalPrice': '₹39,999',
        'discount': '26% OFF',
        'rating': '4.6',
        'reviews': '189',
        'route': AppRoutes.slotBooking,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=400',
        'title': 'Office Chair',
        'description': 'Ergonomic executive office chair',
        'price': '₹8,999',
        'originalPrice': '₹12,999',
        'discount': '31% OFF',
        'rating': '4.7',
        'reviews': '423',
        'route': AppRoutes.workProgress,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Correct
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final s = services[index];
          return _buildServiceCard(
            context,
            imageUrl: s['image'] as String,
            title: s['title'] as String,
            description: s['description'] as String,
            price: s['price'] as String,
            originalPrice: s['originalPrice'] as String,
            discount: s['discount'] as String,
            rating: s['rating'] as String,
            reviews: s['reviews'] as String,
            route: s['route'] as String,
          );
        },
      ),
    );
  }

  /// ⭐ REDESIGNED CARD - NO OVERFLOW
  Widget _buildServiceCard(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required String description,
    required String price,
    required String originalPrice,
    required String discount,
    required String rating,
    required String reviews,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE AREA (Fixed 110px)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 110,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Discount Badge
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Favorite Icon
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),

            /// DETAILS SECTION - Expanded for remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        height: 1.2,
                      ),
                    ),

                    const Spacer(),

                    // Price Row
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            originalPrice,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, route),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.deepSkyBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.draw_rounded,
                label: 'Design',
                color: Colors.orange,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.onlineDesignHome),
              ),
              _buildNavItem(
                icon: Icons.event_rounded,
                label: 'Booking',
                color: AppColors.deepSkyBlue,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.slotBooking),
              ),
              _buildNavItem(
                icon: Icons.home_rounded,
                label: '',
                color: AppColors.primarySkyBlue,
                isCenter: true,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.customerDashboard),
              ),
              _buildNavItem(
                icon: Icons.download_rounded,
                label: 'Download',
                color: Colors.green,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.customerDownloads),
              ),
              _buildNavItem(
                icon: Icons.account_circle_rounded,
                label: 'Profile',
                color: Colors.grey[800]!,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.customerProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isCenter = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: color),
            if (!isCenter)
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
