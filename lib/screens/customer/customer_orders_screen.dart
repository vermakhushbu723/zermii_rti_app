import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E0),
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
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
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search orders...',
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
          ),
          // Orders List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                _buildOrderCard(
                  context,
                  orderId: '#13240',
                  date: '19 Nov 2023',
                  products: [
                    OrderProduct(
                      name: 'Screen Guard',
                      price: '\$599',
                      image: '',
                    ),
                  ],
                  status: 'Order Placed',
                  statusColor: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13241',
                  date: '20 Nov 2023',
                  products: [
                    OrderProduct(name: 'Oneplus 8', price: '\$409', image: ''),
                  ],
                  status: 'Order Placed',
                  statusColor: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13242',
                  date: '21 Nov 2023',
                  products: [
                    OrderProduct(
                      name: 'iPhone 13 Pro',
                      price: '\$22,000',
                      image: '',
                    ),
                  ],
                  status: 'Order Placed',
                  statusColor: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13243',
                  date: '22 Nov 2023',
                  products: [
                    OrderProduct(
                      name: 'Wood Marino Sofa',
                      price: '\$799',
                      image: '',
                    ),
                    OrderProduct(
                      name: 'Double Bed Queen Size',
                      price: '\$1,400',
                      image: '',
                    ),
                  ],
                  status: 'Order Placed',
                  statusColor: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String date,
    required List<OrderProduct> products,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.customerOrderDetails);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: $orderId',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            // Products
            ...products.map((product) => _buildProductItem(product)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(OrderProduct product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, color: Colors.grey.shade400, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepSkyBlue,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.shopping_cart_rounded,
            label: 'Cart',
            isActive: false,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
          ),
          _buildNavItem(
            context,
            icon: Icons.receipt_long_rounded,
            label: 'Orders',
            isActive: true,
            color: AppColors.deepSkyBlue,
            onTap: () {},
          ),
          _buildNavItem(
            context,
            icon: Icons.home_rounded,
            label: 'Home',
            isActive: false,
            color: AppColors.primarySkyBlue,
            isCenter: true,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.customerDashboard,
              (route) => false,
            ),
          ),
          _buildNavItem(
            context,
            icon: Icons.location_on_outlined,
            label: 'Track',
            isActive: false,
            color: Colors.green,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.customerOrderTracking),
          ),
          _buildNavItem(
            context,
            icon: Icons.account_circle_rounded,
            label: 'Profile',
            isActive: false,
            color: Colors.grey[700]!,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.customerProfile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
    bool isCenter = false,
  }) {
    if (isCenter) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.deepSkyBlue.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? color.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isActive ? color : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: isActive ? color : Colors.grey[600],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProduct {
  final String name;
  final String price;
  final String image;

  OrderProduct({required this.name, required this.price, required this.image});
}
