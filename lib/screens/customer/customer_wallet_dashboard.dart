import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'wallet/refund_request_screen.dart';
import 'wallet/refund_history_screen.dart';
import 'wallet/add_money_screen.dart';
import 'customer_profile_screen.dart';

class CustomerWalletDashboard extends StatefulWidget {
  const CustomerWalletDashboard({super.key});

  @override
  State<CustomerWalletDashboard> createState() =>
      _CustomerWalletDashboardState();
}

class _CustomerWalletDashboardState extends State<CustomerWalletDashboard> {
  int _selectedNavIndex = 0;

  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'name': 'Luigi\'s pizza',
      'date': 'Yesterday',
      'amount': -21763,
      'currency': 'sats',
      'euroAmount': -12.75,
      'icon': Icons.local_pizza,
      'color': Colors.orange,
    },
    {
      'name': 'Yum Yum Foods',
      'date': 'Yesterday',
      'amount': -128821,
      'currency': 'sats',
      'euroAmount': -75.38,
      'icon': Icons.restaurant,
      'color': Colors.green,
      'badge': 'Cancelled',
    },
    {
      'name': 'Priva Lee',
      'date': 'April 12, 2021',
      'amount': 1206958,
      'currency': 'sats',
      'euroAmount': 1808.88,
      'description': 'Web design work for ACME Inc.',
      'icon': Icons.business,
      'color': Colors.brown,
      'badge': 'Received',
    },
    {
      'name': 'Winston Park',
      'date': 'April 9, 2021',
      'amount': 73398,
      'currency': 'sats',
      'euroAmount': 43.08,
      'description': 'Reimbursement for party expenses',
      'icon': Icons.celebration,
      'color': Colors.purple,
    },
    {
      'name': 'Motor City',
      'date': 'April 8, 2021',
      'amount': -139969,
      'currency': 'sats',
      'euroAmount': -82.01,
      'icon': Icons.directions_car,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E0), // Light cream background
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Search
            _buildTopBar(),

            // Balance Card
            _buildBalanceCard(),

            const SizedBox(height: 16),

            // Activity Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activity Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Text(
                        'Activity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),

                    // Transaction List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          return _buildTransactionItem(_transactions[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back Button
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          // Search Bar
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search transactions...',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.mic_rounded,
                            color: Colors.grey.shade600,
                            size: 22,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
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
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A237E), // Deep Indigo
            const Color(0xFF3949AB), // Indigo
            AppColors.primarySkyBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '25,000 Sats',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Equivalent to',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '11.48 €',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
                        color: Colors.greenAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.greenAccent,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '+2.4%',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final bool isNegative = transaction['amount'] < 0;
    final String amountText = isNegative
        ? '${transaction['amount']}'
        : '+${transaction['amount']}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: transaction['color'].withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction['icon'],
              color: transaction['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        transaction['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (transaction['badge'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: transaction['badge'] == 'Cancelled'
                              ? Colors.grey[300]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          transaction['badge'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: transaction['badge'] == 'Cancelled'
                                ? Colors.grey[700]
                                : Colors.green[700],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['date'],
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                if (transaction['description'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    transaction['description'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountText ${transaction['currency']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isNegative ? Colors.red[600] : Colors.green[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${isNegative ? '' : '+'}${transaction['euroAmount'].toStringAsFixed(2)} €',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.currency_exchange_rounded,
                label: 'Refund\nmoney',
                index: 0,
                color: Colors.orange,
              ),
              _buildNavItem(
                icon: Icons.history_rounded,
                label: 'Refund\nhistory',
                index: 1,
                color: AppColors.deepSkyBlue,
              ),
              _buildNavItem(
                icon: Icons.home_rounded,
                label: '',
                index: 2,
                color: AppColors.primarySkyBlue,
                isCenter: true,
              ),
              _buildNavItem(
                icon: Icons.add_card_rounded,
                label: 'Add\nmoney',
                index: 3,
                color: Colors.green,
              ),
              _buildNavItem(
                icon: Icons.account_circle_rounded,
                label: 'Profile',
                index: 4,
                color: Colors.grey[800]!,
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
    required int index,
    required Color color,
    bool isCenter = false,
  }) {
    final bool isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        _handleNavigation(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCenter)
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primarySkyBlue.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            )
          else
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? color : Colors.grey[400],
                size: 26,
              ),
            ),
          if (!isCenter) ...[
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? color : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                height: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Refund money
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RefundRequestScreen()),
        );
        break;
      case 1:
        // Refund history
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RefundHistoryScreen()),
        );
        break;
      case 2:
        // Home button - center button
        Navigator.pop(context);
        break;
      case 3:
        // Add money
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
        );
        break;
      case 4:
        // Profile
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerProfileScreen(),
          ),
        );
        break;
    }
  }
}
