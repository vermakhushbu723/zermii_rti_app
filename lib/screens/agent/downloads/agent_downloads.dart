import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class AgentDownloads extends StatefulWidget {
  const AgentDownloads({super.key});

  @override
  State<AgentDownloads> createState() => _AgentDownloadsState();
}

class _AgentDownloadsState extends State<AgentDownloads> {
  String _selectedCategory = 'All';

  final Map<String, List<Map<String, dynamic>>> _downloads = {
    'Design': [
      {
        'title': '2D Floor Plan - Rajesh Kumar',
        'type': 'PDF',
        'size': '2.5 MB',
        'date': '15 Nov 2024',
        'icon': Icons.picture_as_pdf,
      },
      {
        'title': '3D Design - Amit Verma',
        'type': 'ZIP',
        'size': '45 MB',
        'date': '12 Nov 2024',
        'icon': Icons.folder_zip,
      },
    ],
    'Booking': [
      {
        'title': 'Land Booking Receipt - CLS-001',
        'type': 'PDF',
        'size': '500 KB',
        'date': '10 Nov 2024',
        'icon': Icons.receipt_long,
      },
      {
        'title': 'Slot Confirmation - Sneha Patel',
        'type': 'PDF',
        'size': '350 KB',
        'date': '08 Nov 2024',
        'icon': Icons.receipt,
      },
    ],
    'Furniture': [
      {
        'title': 'Furniture Quotation - Living Room',
        'type': 'PDF',
        'size': '1.2 MB',
        'date': '05 Nov 2024',
        'icon': Icons.description,
      },
      {
        'title': 'Furniture Catalog 2024',
        'type': 'PDF',
        'size': '8.5 MB',
        'date': '01 Nov 2024',
        'icon': Icons.book,
      },
    ],
    'Purchasing': [
      {
        'title': 'Purchase Order - PRJ-001',
        'type': 'PDF',
        'size': '750 KB',
        'date': '20 Oct 2024',
        'icon': Icons.shopping_cart,
      },
      {
        'title': 'Invoice - Material Supply',
        'type': 'PDF',
        'size': '600 KB',
        'date': '18 Oct 2024',
        'icon': Icons.receipt_long,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Downloads'),
        backgroundColor: AppColors.agentModule,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          _buildCategoryCards(),
          Expanded(child: _buildDownloadsList()),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All', 'Design', 'Booking', 'Furniture', 'Purchasing'].map(
            (cat) {
              final isSelected = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) =>
                      setState(() => _selectedCategory = cat),
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.agentModule.withOpacity(0.3),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryCards() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildCategoryCard(
            'Design',
            Icons.design_services,
            Colors.blue,
            _downloads['Design']!.length,
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            'Booking',
            Icons.event_available,
            Colors.green,
            _downloads['Booking']!.length,
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            'Furniture',
            Icons.chair,
            Colors.orange,
            _downloads['Furniture']!.length,
          ),
          const SizedBox(width: 12),
          _buildCategoryCard(
            'Purchasing',
            Icons.shopping_bag,
            Colors.purple,
            _downloads['Purchasing']!.length,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String label,
    IconData icon,
    Color color,
    int count,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = label),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _selectedCategory == label
                ? color.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _selectedCategory == label ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadsList() {
    List<Map<String, dynamic>> filteredDownloads = [];

    if (_selectedCategory == 'All') {
      _downloads.forEach((key, value) {
        filteredDownloads.addAll(value);
      });
    } else {
      filteredDownloads = _downloads[_selectedCategory] ?? [];
    }

    if (filteredDownloads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No downloads yet',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredDownloads.length,
      itemBuilder: (context, index) =>
          _buildDownloadCard(filteredDownloads[index]),
    );
  }

  Widget _buildDownloadCard(Map<String, dynamic> download) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.agentModule.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(download['icon'], color: AppColors.agentModule),
        ),
        title: Text(
          download['title'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(download['type']),
            const Text(' • '),
            Text(download['size']),
            const Text(' • '),
            Text(download['date']),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.download, color: AppColors.agentModule),
          onPressed: () => _handleDownload(download),
        ),
      ),
    );
  }

  void _handleDownload(Map<String, dynamic> download) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${download['title']}...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
