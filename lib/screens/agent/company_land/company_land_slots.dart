import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';

class CompanyLandSlots extends StatefulWidget {
  const CompanyLandSlots({super.key});

  @override
  State<CompanyLandSlots> createState() => _CompanyLandSlotsState();
}

class _CompanyLandSlotsState extends State<CompanyLandSlots> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _landSlots = [
    {
      'id': 'CLS-001',
      'title': 'Premium Residential Plot',
      'location': 'Sector 62, Noida',
      'area': '1500 sq ft',
      'price': '₹35,00,000',
      'status': 'Available',
      'slots': 5,
      'image': Icons.home_work,
    },
    {
      'id': 'CLS-002',
      'title': 'Commercial Space',
      'location': 'Greater Noida West',
      'area': '2000 sq ft',
      'price': '₹50,00,000',
      'status': 'Limited',
      'slots': 2,
      'image': Icons.business,
    },
    {
      'id': 'CLS-003',
      'title': 'Luxury Villa Plot',
      'location': 'Sector 15, Noida',
      'area': '3000 sq ft',
      'price': '₹75,00,000',
      'status': 'Booked',
      'slots': 0,
      'image': Icons.villa,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Company Land Slots'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          _buildStatsCards(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _landSlots.length,
              itemBuilder: (context, index) =>
                  _buildLandSlotCard(_landSlots[index]),
            ),
          ),
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
          children: ['All', 'Available', 'Limited', 'Booked'].map((filter) {
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
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatCard('Total Slots', '12', Icons.grid_view, Colors.blue),
          const SizedBox(width: 12),
          _buildStatCard('Available', '7', Icons.check_circle, Colors.green),
          const SizedBox(width: 12),
          _buildStatCard('Booked', '5', Icons.bookmark, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandSlotCard(Map<String, dynamic> slot) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.slotBookingDetails,
            arguments: slot,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.agentModule.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      slot['image'],
                      color: AppColors.agentModule,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                slot['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _buildStatusBadge(slot['status']),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${slot['id']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      slot['location'],
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.square_foot_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(slot['area'], style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.event_available,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${slot['slots']} slots available',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    slot['price'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.agentModule,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: slot['status'] == 'Booked'
                        ? null
                        : () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.slotBookingDetails,
                              arguments: slot,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.agentModule,
                    ),
                    icon: const Icon(
                      Icons.event,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Book Slot',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Available':
        color = Colors.green;
        break;
      case 'Limited':
        color = Colors.orange;
        break;
      case 'Booked':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Filter By'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('All'),
              value: 'All',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() => _selectedFilter = value.toString());
                Navigator.pop(ctx);
              },
            ),
            RadioListTile(
              title: const Text('Available'),
              value: 'Available',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() => _selectedFilter = value.toString());
                Navigator.pop(ctx);
              },
            ),
            RadioListTile(
              title: const Text('Limited'),
              value: 'Limited',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() => _selectedFilter = value.toString());
                Navigator.pop(ctx);
              },
            ),
            RadioListTile(
              title: const Text('Booked'),
              value: 'Booked',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() => _selectedFilter = value.toString());
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
