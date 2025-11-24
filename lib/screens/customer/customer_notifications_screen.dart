import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class CustomerNotificationsScreen extends StatelessWidget {
  const CustomerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
          _buildNotificationCard(
            icon: Icons.local_shipping_rounded,
            iconColor: AppColors.success,
            title: 'Order Delivered',
            message: 'Your order #ORD2025001 has been delivered successfully.',
            time: '2 hours ago',
            isRead: false,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            icon: Icons.local_offer_rounded,
            iconColor: AppColors.warning,
            title: 'Special Offer!',
            message: 'Get 30% off on all dining tables this weekend!',
            time: '5 hours ago',
            isRead: false,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            icon: Icons.info_outline_rounded,
            iconColor: AppColors.info,
            title: 'Order Update',
            message: 'Your order #ORD2025002 is out for delivery.',
            time: '1 day ago',
            isRead: true,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            icon: Icons.star_rounded,
            iconColor: AppColors.deepSkyBlue,
            title: 'Rate Your Purchase',
            message: 'How was your experience with the Modern Sofa Set?',
            time: '2 days ago',
            isRead: true,
          ),
          const SizedBox(height: 12),
          _buildNotificationCard(
            icon: Icons.payment_rounded,
            iconColor: AppColors.success,
            title: 'Payment Successful',
            message: 'Payment of ₹43,998 received for order #ORD2025001.',
            time: '3 days ago',
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isRead,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySkyBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isRead
            ? null
            : Border.all(
                color: AppColors.primarySkyBlue.withOpacity(0.3),
                width: 2,
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isRead
                                ? FontWeight.w500
                                : FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.deepSkyBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
