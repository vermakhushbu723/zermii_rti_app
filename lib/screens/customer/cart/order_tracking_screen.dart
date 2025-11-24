import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E0),
      appBar: AppBar(
        title: const Text(
          'Track Orders',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderCard(
            context,
            orderId: '#98905',
            productName: 'Khel Fruit',
            price: '\$6.95',
            rating: 5,
            trackingSteps: [
              TrackingStep(
                title: 'Order Placed',
                subtitle: '',
                icon: Icons.receipt_long,
                isCompleted: true,
                color: Colors.orange,
              ),
              TrackingStep(
                title: 'Order Confirmed',
                subtitle: 'Order has been confirmed\n19 Nov 2024, 12:30 PM',
                icon: Icons.check_circle,
                isCompleted: true,
                color: Colors.orange,
              ),
              TrackingStep(
                title: 'Order Processed',
                subtitle: 'We are processing your order',
                icon: Icons.shopping_bag,
                isCompleted: true,
                color: Colors.green,
              ),
              TrackingStep(
                title: 'Out for Delivery',
                subtitle: '',
                icon: Icons.local_shipping,
                isCompleted: false,
                color: Colors.grey,
              ),
              TrackingStep(
                title: 'Delivered',
                subtitle: '',
                icon: Icons.home,
                isCompleted: false,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String productName,
    required String price,
    required int rating,
    required List<TrackingStep> trackingSteps,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Product Info
          Padding(
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
                  child: Icon(
                    Icons.image,
                    color: Colors.grey.shade400,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: $orderId',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.deepSkyBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    rating,
                    (index) =>
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          // Track Order Section
          ExpansionTile(
            title: const Text(
              'Track Order',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _buildTrackingTimeline(trackingSteps),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline(List<TrackingStep> steps) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: step.isCompleted
                        ? step.color.withOpacity(0.15)
                        : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(color: step.color, width: 2),
                  ),
                  child: Icon(step.icon, color: step.color, size: 20),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: step.isCompleted
                        ? step.color.withOpacity(0.5)
                        : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: step.isCompleted ? Colors.black87 : Colors.grey,
                      ),
                    ),
                    if (step.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        step.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      }),
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
            isActive: false,
            color: AppColors.deepSkyBlue,
            onTap: () => Navigator.pushNamed(context, AppRoutes.customerOrders),
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
            isActive: true,
            color: Colors.green,
            onTap: () {},
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive ? color.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isActive ? color : Colors.grey[400],
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? color : Colors.grey[600],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isCompleted;
  final Color color;

  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isCompleted,
    required this.color,
  });
}
