import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = '';

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'PayPal',
      'icon': 'assets/icons/paypal.png',
      'iconData': Icons.account_balance_wallet,
    },
    {
      'name': 'RazorPay',
      'icon': 'assets/icons/razorpay.png',
      'iconData': Icons.credit_card,
    },
    {
      'name': 'Paystack',
      'icon': 'assets/icons/paystack.png',
      'iconData': Icons.payment,
    },
    {
      'name': 'Flutterwave',
      'icon': 'assets/icons/flutterwave.png',
      'iconData': Icons.waves,
    },
    {
      'name': 'Stripe',
      'icon': 'assets/icons/stripe.png',
      'iconData': Icons.credit_score,
    },
    {
      'name': 'Paytm',
      'icon': 'assets/icons/paytm.png',
      'iconData': Icons.wallet,
    },
    {
      'name': 'Direct Bank Transfer',
      'icon': 'assets/icons/bank.png',
      'iconData': Icons.account_balance,
    },
    {
      'name': 'MobiTrans',
      'icon': 'assets/icons/mobitrans.png',
      'iconData': Icons.mobile_friendly,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Use Wallet Balance
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primarySkyBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primarySkyBlue),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: 'wallet',
                  groupValue: _selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value ?? '';
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Use Wallet Balance',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Available: \$1,845.20',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.deepSkyBlue,
                  size: 32,
                ),
              ],
            ),
          ),

          // Payment Methods List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                return _buildPaymentMethodItem(method);
              },
            ),
          ),

          // Continue Button
          Container(
            padding: const EdgeInsets.all(16),
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
            child: ElevatedButton(
              onPressed: _selectedMethod.isEmpty
                  ? null
                  : () {
                      Navigator.pop(context, _selectedMethod);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                disabledBackgroundColor: Colors.grey[300],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'CONFIRM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    final isSelected = _selectedMethod == method['name'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.deepSkyBlue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RadioListTile<String>(
        value: method['name'],
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value ?? '';
          });
        },
        title: Text(
          method['name'],
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primarySkyBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            method['iconData'],
            color: AppColors.deepSkyBlue,
            size: 24,
          ),
        ),
        activeColor: AppColors.deepSkyBlue,
      ),
    );
  }
}
