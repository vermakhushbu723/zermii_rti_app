import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedReason;

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
          'Cancel Order',
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
          Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Find order items here...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
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
                  productName: 'Screen Guard',
                  price: '\$599',
                  status: 'Cancelled',
                  statusColor: Colors.red,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13241',
                  productName: 'Oneplus 8',
                  price: '\$409',
                  status: 'Awaiting',
                  statusColor: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13242',
                  productName: 'iPhone 13 Pro',
                  price: '\$22,000',
                  status: 'Cancelled',
                  statusColor: Colors.red,
                ),
                const SizedBox(height: 16),
                _buildOrderCard(
                  context,
                  orderId: '#13243',
                  productName: 'Wood Marino Sofa',
                  price: '\$799',
                  status: 'Awaiting',
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
    required String productName,
    required String price,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () {
        if (status == 'Awaiting') {
          _showCancelDialog(context, orderId, productName);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
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
                    'Order ID: $orderId',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepSkyBlue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
  }

  void _showCancelDialog(
    BuildContext context,
    String orderId,
    String productName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId'),
            const SizedBox(height: 8),
            Text('Product: $productName'),
            const SizedBox(height: 16),
            const Text(
              'Select cancellation reason:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildReasonRadio('Changed my mind'),
            _buildReasonRadio('Found better price'),
            _buildReasonRadio('Ordered by mistake'),
            _buildReasonRadio('Delivery taking too long'),
            _buildReasonRadio('Other'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: selectedReason != null
                ? () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Order $orderId cancelled successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {});
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm Cancellation'),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonRadio(String reason) {
    return RadioListTile<String>(
      title: Text(reason, style: const TextStyle(fontSize: 14)),
      value: reason,
      groupValue: selectedReason,
      onChanged: (value) {
        setState(() {
          selectedReason = value;
        });
      },
      dense: true,
      contentPadding: EdgeInsets.zero,
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
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
            isActive: false,
            onTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
          ),
          _buildNavItem(
            context,
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
            isActive: true,
            onTap: () => Navigator.pushNamed(context, AppRoutes.customerOrders),
          ),
          _buildNavItem(
            context,
            icon: Icons.home_rounded,
            label: 'Home',
            isActive: false,
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
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.customerOrderTracking),
          ),
          _buildNavItem(
            context,
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
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
    required VoidCallback onTap,
    bool isCenter = false,
  }) {
    if (isCenter) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
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
          child: Icon(icon, color: Colors.white, size: 24),
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
            Icon(
              icon,
              color: isActive ? Colors.orange : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? Colors.orange : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
