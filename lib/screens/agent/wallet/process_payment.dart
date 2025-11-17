import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/custom_button.dart';

class ProcessPayment extends StatefulWidget {
  const ProcessPayment({super.key});

  @override
  State<ProcessPayment> createState() => _ProcessPaymentState();
}

class _ProcessPaymentState extends State<ProcessPayment> {
  String _selectedPaymentMethod = 'Wallet';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final total = args?['total'] ?? 0;
    final items = args?['items'] as List<Map<String, dynamic>>? ?? [];

    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppColors.agentModule,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(items, total),
            const SizedBox(height: 20),
            _buildPaymentMethods(),
            const SizedBox(height: 20),
            if (_selectedPaymentMethod == 'Wallet') _buildWalletBalance(),
          ],
        ),
      ),
      bottomNavigationBar: _buildPayButton(total),
    );
  }

  Widget _buildOrderSummary(List<Map<String, dynamic>> items, num total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item['name']} x ${item['quantity']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    '₹${(item['price'] * item['quantity'])}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.agentModule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          RadioListTile(
            value: 'Wallet',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) =>
                setState(() => _selectedPaymentMethod = value.toString()),
            title: const Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.orange),
                SizedBox(width: 12),
                Text('Wallet Balance'),
              ],
            ),
          ),
          RadioListTile(
            value: 'UPI',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) =>
                setState(() => _selectedPaymentMethod = value.toString()),
            title: const Row(
              children: [
                Icon(Icons.qr_code, color: Colors.purple),
                SizedBox(width: 12),
                Text('UPI'),
              ],
            ),
          ),
          RadioListTile(
            value: 'Card',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) =>
                setState(() => _selectedPaymentMethod = value.toString()),
            title: const Row(
              children: [
                Icon(Icons.credit_card, color: Colors.blue),
                SizedBox(width: 12),
                Text('Debit/Credit Card'),
              ],
            ),
          ),
          RadioListTile(
            value: 'Net Banking',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) =>
                setState(() => _selectedPaymentMethod = value.toString()),
            title: const Row(
              children: [
                Icon(Icons.account_balance, color: Colors.green),
                SizedBox(width: 12),
                Text('Net Banking'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletBalance() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.agentModule.withOpacity(0.1),
            Colors.orange.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.agentModule.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet, color: AppColors.agentModule),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Balance',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  '₹45,820.50',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(num total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: CustomButton(
        text: _isProcessing
            ? 'Processing...'
            : 'Pay ₹${total.toStringAsFixed(2)}',
        onPressed: _isProcessing ? null : () => _handlePayment(total),
      ),
    );
  }

  void _handlePayment(num total) {
    setState(() => _isProcessing = true);

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() => _isProcessing = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                '₹${total.toStringAsFixed(2)} paid via $_selectedPaymentMethod',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order placed successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.agentModule,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
