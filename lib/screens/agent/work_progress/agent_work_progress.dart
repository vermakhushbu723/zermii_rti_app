import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class AgentWorkProgress extends StatefulWidget {
  const AgentWorkProgress({super.key});

  @override
  State<AgentWorkProgress> createState() => _AgentWorkProgressState();
}

class _AgentWorkProgressState extends State<AgentWorkProgress> {
  String _selectedTab = 'All';

  final List<Map<String, dynamic>> _projects = [
    {
      'id': 'PRJ-001',
      'customerName': 'Rajesh Kumar',
      'projectType': 'Interior Design',
      'status': 'In Progress',
      'progress': 65,
      'designer': 'Priya Sharma',
      'startDate': '15 Oct 2024',
      'deadline': '15 Dec 2024',
    },
    {
      'id': 'PRJ-002',
      'customerName': 'Amit Verma',
      'projectType': '3D Design',
      'status': 'Pending',
      'progress': 30,
      'designer': 'Rohan Gupta',
      'startDate': '20 Oct 2024',
      'deadline': '20 Nov 2024',
    },
    {
      'id': 'PRJ-003',
      'customerName': 'Sneha Patel',
      'projectType': 'Architecture',
      'status': 'Completed',
      'progress': 100,
      'designer': 'Arjun Singh',
      'startDate': '01 Sep 2024',
      'deadline': '15 Oct 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Work Progress'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          _buildStatsCards(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _projects.length,
              itemBuilder: (context, index) =>
                  _buildProjectCard(_projects[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All', 'In Progress', 'Pending', 'Completed'].map((tab) {
            final isSelected = _selectedTab == tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(tab),
                selected: isSelected,
                onSelected: (selected) => setState(() => _selectedTab = tab),
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
          _buildStatCard('Total', '18', Icons.folder_outlined, Colors.blue),
          const SizedBox(width: 12),
          _buildStatCard('Active', '12', Icons.pending_actions, Colors.orange),
          const SizedBox(width: 12),
          _buildStatCard('Done', '6', Icons.check_circle, Colors.green),
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

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['customerName'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${project['id']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(project['status']),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.work_outline, 'Type', project['projectType']),
            _buildDetailRow(
              Icons.person_outline,
              'Designer',
              project['designer'],
            ),
            _buildDetailRow(
              Icons.calendar_today,
              'Started',
              project['startDate'],
            ),
            _buildDetailRow(Icons.event, 'Deadline', project['deadline']),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Progress',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${project['progress']}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.agentModule,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: project['progress'] / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      project['progress'] == 100
                          ? Colors.green
                          : AppColors.agentModule,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: const Text('Chat'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.agentModule,
                  ),
                  icon: const Icon(
                    Icons.visibility,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'View Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label: ', style: TextStyle(color: Colors.grey[700])),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'In Progress':
        color = Colors.blue;
        break;
      case 'Pending':
        color = Colors.orange;
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
}
