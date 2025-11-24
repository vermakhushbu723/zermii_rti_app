import 'package:flutter/material.dart';
import 'refund_tracking_screen.dart';

class RefundRequestScreen extends StatefulWidget {
  const RefundRequestScreen({super.key});

  @override
  State<RefundRequestScreen> createState() => _RefundRequestScreenState();
}

class _RefundRequestScreenState extends State<RefundRequestScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // State variables
  String _returnType = 'Return Product'; // Replacement or Return Product
  String _refundType = 'Wallet'; // UPI, Wallet, Bank Account, Gift Card
  String _selectedReason = 'Product quality issue';
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      // Submit
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RefundTrackingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              setState(() {
                _currentPage--;
              });
            } else {
              Navigator.pop(context);
            }
          },
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
      body: Column(
        children: [
          // Header with user icon
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
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [_buildStep1(), _buildStep2(), _buildStep3()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              _currentPage == 2 ? 'Send Request' : 'Continue',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.local_laundry_service,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Fully Automatic Front Load with In-built Heater',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$300 15% OFF',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Qty - 1', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What do you want in return?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildOptionCard(
                  'Replacement',
                  _returnType == 'Replacement',
                  () => setState(() => _returnType = 'Replacement'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildOptionCard(
                  'Return Product',
                  _returnType == 'Return Product',
                  () => setState(() => _returnType = 'Return Product'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Refund Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildRadioOption(
            'UPI',
            'Refund will be processed to your UPI within 1 day business day after pickup is completed',
          ),
          _buildRadioOption(
            'Wallet',
            'Refund will be processed to your Wallet within 1 day business day after pickup is completed',
          ),
          _buildRadioOption(
            'Bank Account',
            'Refund will be processed to your bank account within 1 day business day',
          ),
          _buildRadioOption(
            'Gift Card or Voucher',
            'Refund will be processed to your Gift Card or Voucher within 1 day business day',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Refund Amount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$300',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // ... Product details (simplified for brevity)
          const SizedBox(height: 20),
          const Text(
            'Reason for Cancellation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildReasonOption('Price for the product has decreased'),
          _buildReasonOption('I will not be available at home on delivery day'),
          _buildReasonOption('I have changed my mind'),
          _buildReasonOption('Product quality issue'),
          if (_selectedReason == 'Product quality issue')
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 8, bottom: 8),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Comment',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
            ),
          _buildReasonOption('Delivery time is very long'),
          _buildReasonOption('I have purchased the product elsewhere'),
          _buildReasonOption('I want to change my address'),
          _buildReasonOption('I want to change my phone number'),
          _buildReasonOption('Others'),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pickup Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9C4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.home, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          'Brandon Carl',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Change',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '326, Hoffman Avenue, New york\nUnited States - 10016',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Phone Number - +1 XXXXX YYYYY',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Note :',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const Text(
            '* We can only accept items for return or replacement, if they have not been used or damaged',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 16),
            if (isSelected) const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, String subtitle) {
    bool isSelected = _refundType == title;
    return GestureDetector(
      onTap: () => setState(() => _refundType = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.deepPurple : Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    bool isSelected = _selectedReason == reason;
    return GestureDetector(
      onTap: () => setState(() => _selectedReason = reason),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.deepPurple : Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(reason)),
          ],
        ),
      ),
    );
  }
}
