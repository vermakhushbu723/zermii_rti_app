import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/custom_button.dart';

class SlotBookingDetails extends StatefulWidget {
  const SlotBookingDetails({super.key});

  @override
  State<SlotBookingDetails> createState() => _SlotBookingDetailsState();
}

class _SlotBookingDetailsState extends State<SlotBookingDetails> {
  int _selectedSlotNumber = 1;
  String _selectedPaymentMode = 'Full Payment';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final slot =
        args ??
        {
          'title': 'Premium Residential Plot',
          'location': 'Sector 62, Noida',
          'area': '1500 sq ft',
          'price': '₹35,00,000',
          'slots': 5,
          'id': 'CLS-001',
        };

    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Slot Booking'),
        backgroundColor: AppColors.agentModule,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyImage(),
            _buildPropertyDetails(slot),
            _buildSlotSelection(slot),
            _buildPaymentModeSelection(),
            _buildPriceBreakdown(slot),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBookingButton(slot),
    );
  }

  Widget _buildPropertyImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.agentModule.withOpacity(0.1)),
      child: Icon(Icons.home_work, size: 80, color: AppColors.agentModule),
    );
  }

  Widget _buildPropertyDetails(Map<String, dynamic> slot) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slot['title'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'ID: ${slot['id']}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.location_on_outlined,
            'Location',
            slot['location'],
          ),
          _buildDetailRow(Icons.square_foot_outlined, 'Area', slot['area']),
          _buildDetailRow(
            Icons.event_available,
            'Available Slots',
            '${slot['slots']} slots',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.agentModule.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.currency_rupee, color: AppColors.agentModule),
                const SizedBox(width: 8),
                Text(
                  slot['price'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.agentModule,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotSelection(Map<String, dynamic> slot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Slot Number',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(slot['slots'] as int, (index) {
              final slotNum = index + 1;
              final isSelected = _selectedSlotNumber == slotNum;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlotNumber = slotNum),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.agentModule
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.agentModule
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      slotNum.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentModeSelection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Mode',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          RadioListTile(
            title: const Text('Full Payment'),
            subtitle: const Text('Pay complete amount now'),
            value: 'Full Payment',
            groupValue: _selectedPaymentMode,
            onChanged: (value) =>
                setState(() => _selectedPaymentMode = value.toString()),
          ),
          RadioListTile(
            title: const Text('EMI'),
            subtitle: const Text('Pay in installments'),
            value: 'EMI',
            groupValue: _selectedPaymentMode,
            onChanged: (value) =>
                setState(() => _selectedPaymentMode = value.toString()),
          ),
          RadioListTile(
            title: const Text('Token Amount'),
            subtitle: const Text('Pay 20% now, rest later'),
            value: 'Token Amount',
            groupValue: _selectedPaymentMode,
            onChanged: (value) =>
                setState(() => _selectedPaymentMode = value.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(Map<String, dynamic> slot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Breakdown',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPriceRow('Base Price', slot['price']),
          _buildPriceRow('GST (5%)', '₹1,75,000'),
          _buildPriceRow('Registration', '₹50,000'),
          const Divider(),
          _buildPriceRow(
            'Total Amount',
            '₹38,25,000',
            isBold: true,
            color: AppColors.agentModule,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButton(Map<String, dynamic> slot) {
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
        text: 'Proceed to Payment',
        onPressed: () => _handleBooking(),
      ),
    );
  }

  void _handleBooking() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
          'Slot $_selectedSlotNumber will be booked with $_selectedPaymentMode.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking confirmed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.agentModule,
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
