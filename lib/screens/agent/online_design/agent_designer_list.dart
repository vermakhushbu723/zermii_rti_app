import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';

class AgentDesignerList extends StatefulWidget {
  const AgentDesignerList({super.key});

  @override
  State<AgentDesignerList> createState() => _AgentDesignerListState();
}

class _AgentDesignerListState extends State<AgentDesignerList> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _designers = [
    {
      'name': 'Rajesh Kumar',
      'specialization': 'Interior Design',
      'rating': 4.8,
      'distance': '2.5 km',
      'experience': '8 years',
      'projects': 125,
      'image': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Priya Sharma',
      'specialization': '3D Design',
      'rating': 4.9,
      'distance': '3.2 km',
      'experience': '6 years',
      'projects': 98,
      'image': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Amit Verma',
      'specialization': 'Architecture',
      'rating': 4.7,
      'distance': '5.1 km',
      'experience': '10 years',
      'projects': 156,
      'image': 'https://via.placeholder.com/100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Designer List'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(child: _buildDesignerList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search designers...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All'),
          _buildFilterChip('Nearby'),
          _buildFilterChip('Top Rated'),
          _buildFilterChip('Experienced'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = label);
        },
        backgroundColor: Colors.white,
        selectedColor: AppColors.agentModule.withOpacity(0.3),
        checkmarkColor: AppColors.agentModule,
      ),
    );
  }

  Widget _buildDesignerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _designers.length,
      itemBuilder: (context, index) {
        final designer = _designers[index];
        return _buildDesignerCard(designer);
      },
    );
  }

  Widget _buildDesignerCard(Map<String, dynamic> designer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.agentDesignerDetails,
          arguments: designer,
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.agentModule.withOpacity(0.2),
                child: const Icon(Icons.person, size: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      designer['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      designer['specialization'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${designer['rating']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(designer['distance']),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${designer['experience']} • ${designer['projects']} projects',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.agentModule),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Designers'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sort by Rating'),
              leading: Radio(value: 1, groupValue: 0, onChanged: (v) {}),
            ),
            ListTile(
              title: const Text('Sort by Distance'),
              leading: Radio(value: 2, groupValue: 0, onChanged: (v) {}),
            ),
            ListTile(
              title: const Text('Sort by Experience'),
              leading: Radio(value: 3, groupValue: 0, onChanged: (v) {}),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
