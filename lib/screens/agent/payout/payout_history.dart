import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class PayoutHistory extends StatefulWidget {
  const PayoutHistory({super.key});

  @override
  State<PayoutHistory> createState() => _PayoutHistoryState();
}

class _PayoutHistoryState extends State<PayoutHistory> {
  String _selectedFilter = 'All Time';

  final List<Map<String, dynamic>> _payouts = [
    {
      'month': 'October 2024',
      'amount': 52000.00,
      'projects': 15,
      'status': 'Paid',
      'paidDate': '05 Nov 2024',
    },
    {
      'month': 'September 2024',
      'amount': 48500.00,
      'projects': 12,
      'status': 'Paid',
      'paidDate': '05 Oct 2024',
    },
    {
      'month': 'August 2024',
      'amount': 38000.00,
      'projects': 10,
      'status': 'Paid',
      'paidDate': '05 Sep 2024',
    },
    {
      'month': 'July 2024',
      'amount': 45000.00,
      'projects': 13,
      'status': 'Paid',
      'paidDate': '05 Aug 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Payout History'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadReport,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          _buildTotalEarningsCard(),
          Expanded(child: _buildPayoutList()),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All Time', 'This Year', 'Last 6 Months', 'Last 3 Months']
              .map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) =>
                        setState(() => _selectedFilter = filter),
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.agentModule.withOpacity(0.3),
                  ),
                );
              })
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTotalEarningsCard() {
    final totalAmount = _payouts.fold<double>(
      0,
      (sum, payout) => sum + (payout['amount'] as double),
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Earnings',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_payouts.length} Months',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _payouts.length,
      itemBuilder: (context, index) => _buildPayoutCard(_payouts[index]),
    );
  }

  Widget _buildPayoutCard(Map<String, dynamic> payout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.check_circle, color: Colors.green),
        ),
        title: Text(
          payout['month'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Paid on ${payout['paidDate']}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${payout['amount'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                payout['status'],
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow(
                  'Total Projects',
                  payout['projects'].toString(),
                ),
                _buildDetailRow('Commission Rate', '15%'),
                _buildDetailRow(
                  'Base Amount',
                  '₹${((payout['amount'] as double) * 1.05).toStringAsFixed(2)}',
                ),
                _buildDetailRow(
                  'Platform Fee',
                  '₹${((payout['amount'] as double) * 0.05).toStringAsFixed(2)}',
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Net Payout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${payout['amount'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.agentModule,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _downloadInvoice(payout),
                    icon: const Icon(Icons.download),
                    label: const Text('Download Invoice'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading payout report...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _downloadInvoice(Map<String, dynamic> payout) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading invoice for ${payout['month']}...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
