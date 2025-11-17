import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.adminModule,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Admin Dashboard'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.adminModule,
                        AppColors.adminModule.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Welcome, ${user?['name'] ?? 'Admin'}! 👨‍💼',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage HR & Operations',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 12),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'logout') {
                      authProvider.logout();
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Employees',
                              '156',
                              Icons.people_outline,
                            ),
                            _buildStatItem(
                              'Candidates',
                              '24',
                              Icons.person_add_outlined,
                            ),
                            _buildStatItem(
                              'Attendance',
                              '98%',
                              Icons.check_circle_outline,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Hiring Management'),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.work_outline,
                      title: 'Add New Job',
                      subtitle: 'Create job postings',
                      gradient: [Colors.blue.shade400, Colors.blue.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.addJob),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.people_outline,
                      title: 'All Candidates',
                      subtitle: 'View applicants',
                      gradient: [
                        Colors.purple.shade400,
                        Colors.purple.shade600,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.candidatesList,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.video_call_outlined,
                      title: 'Video Interview',
                      subtitle: 'Conduct interviews',
                      gradient: [Colors.green.shade400, Colors.green.shade600],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.videoInterview,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Attendance & Payroll'),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.calendar_today_outlined,
                      title: 'Attendance',
                      subtitle: 'Track employee presence',
                      gradient: [
                        Colors.orange.shade400,
                        Colors.orange.shade600,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.attendanceList,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Payroll',
                      subtitle: 'Salary management',
                      gradient: [Colors.teal.shade400, Colors.teal.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.salaryList),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.mail_outline,
                      title: 'Offer Letters',
                      subtitle: 'Send & manage offers',
                      gradient: [
                        Colors.indigo.shade400,
                        Colors.indigo.shade600,
                      ],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.offerLetters),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Reports & Documentation'),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.assessment_outlined,
                      title: 'Daily Reporting',
                      subtitle: 'Work summaries & targets',
                      gradient: [Colors.pink.shade400, Colors.pink.shade600],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.dailyWorkSummary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.verified_user_outlined,
                      title: 'Documentation',
                      subtitle: 'KYC & ID cards',
                      gradient: [Colors.cyan.shade400, Colors.cyan.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.kycPage),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.adminModule, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
