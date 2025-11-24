import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class RefundTrackingScreen extends StatelessWidget {
  const RefundTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.account_balance_wallet, color: Colors.brown),
            SizedBox(width: 10),
            Icon(Icons.shopping_cart, color: Colors.brown),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFFFF4E0),
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Return',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/box_return.png', // Placeholder
                    height: 80,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.inventory_2,
                      size: 80,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Order Return ID - 1258786951586',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Back to my orders',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Track Your Refund Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTimelineItem(
                    title: 'Return Requested',
                    subtitle: 'Fri, 29th Apr 22, 05:30 PM',
                    isCompleted: true,
                    isLast: false,
                    icon: Icons.assignment_return,
                  ),
                  _buildTimelineItem(
                    title: 'Return Approved',
                    subtitle: 'Sat, 30th Apr 22, 07:15 PM',
                    isCompleted: true,
                    isLast: false,
                    icon: Icons.check_circle,
                  ),
                  _buildTimelineItem(
                    title: 'Product Picked Up',
                    subtitle: 'Tue, 3 May 22, 10:04 AM',
                    isCompleted: true,
                    isLast: false,
                    icon: Icons.local_shipping,
                  ),
                  _buildTimelineItem(
                    title: 'Refund Processed',
                    subtitle: 'Expected Mon, 4th May 22, 10:00 AM',
                    isCompleted: false, // Example: not yet processed
                    isLast: true,
                    icon: Icons.currency_exchange,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All Tracking Details',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.deepPurple : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 16),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted ? Colors.deepPurple : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        Icon(
          icon,
          color: isCompleted ? Colors.deepPurple : Colors.grey,
          size: 24,
        ),
      ],
    );
  }
}
