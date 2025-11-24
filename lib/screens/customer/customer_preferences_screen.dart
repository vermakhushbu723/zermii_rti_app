import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class CustomerPreferencesScreen extends StatefulWidget {
  const CustomerPreferencesScreen({super.key});

  @override
  State<CustomerPreferencesScreen> createState() =>
      _CustomerPreferencesScreenState();
}

class _CustomerPreferencesScreenState extends State<CustomerPreferencesScreen> {
  String _selectedCategory = 'All Categories';
  String _selectedPriceRange = 'All Prices';
  String _selectedStyle = 'Any Style';
  bool _showDiscountedOnly = false;
  bool _showNewArrivals = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text(
          'Preferences',
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
          _buildSectionHeader('Shopping Preferences'),
          _buildPreferenceCard([
            _buildDropdownTile(
              icon: Icons.category_rounded,
              title: 'Preferred Category',
              value: _selectedCategory,
              items: [
                'All Categories',
                'Living Room',
                'Bedroom',
                'Dining Room',
                'Office',
                'Outdoor',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            _buildDivider(),
            _buildDropdownTile(
              icon: Icons.attach_money_rounded,
              title: 'Price Range',
              value: _selectedPriceRange,
              items: [
                'All Prices',
                'Under ₹10,000',
                '₹10,000 - ₹25,000',
                '₹25,000 - ₹50,000',
                'Above ₹50,000',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPriceRange = value!;
                });
              },
            ),
            _buildDivider(),
            _buildDropdownTile(
              icon: Icons.style_rounded,
              title: 'Furniture Style',
              value: _selectedStyle,
              items: [
                'Any Style',
                'Modern',
                'Classic',
                'Minimalist',
                'Rustic',
                'Contemporary',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStyle = value!;
                });
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader('Display Preferences'),
          _buildPreferenceCard([
            _buildSwitchTile(
              icon: Icons.local_offer_rounded,
              title: 'Show Discounted Items Only',
              value: _showDiscountedOnly,
              onChanged: (value) {
                setState(() {
                  _showDiscountedOnly = value;
                });
              },
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.new_releases_rounded,
              title: 'Highlight New Arrivals',
              value: _showNewArrivals,
              onChanged: (value) {
                setState(() {
                  _showNewArrivals = value;
                });
              },
            ),
          ]),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Preferences saved successfully!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepSkyBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySkyBlue.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.deepSkyBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.deepSkyBlue, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.deepSkyBlue),
                    ),
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.deepSkyBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.deepSkyBlue, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.deepSkyBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey.shade200, indent: 68);
  }
}
