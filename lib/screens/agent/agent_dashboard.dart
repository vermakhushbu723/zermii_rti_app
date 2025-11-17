import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../providers/auth_provider.dart';

class AgentDashboard extends StatefulWidget {
  const AgentDashboard({super.key});

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard>
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
              backgroundColor: AppColors.agentModule,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Agent Dashboard'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.agentModule,
                        AppColors.agentModule.withOpacity(0.8),
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
                            'Welcome Back, ${user?['name'] ?? 'Agent'}! 👋',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage your real estate business',
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
                      value: 'profile',
                      child: Row(
                        children: [
                          Icon(Icons.person_outline),
                          SizedBox(width: 12),
                          Text('Profile'),
                        ],
                      ),
                    ),
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
                    _buildQuickStats(),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Main Services'),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.design_services_outlined,
                      title: 'Online Design',
                      subtitle: 'Connect with designers',
                      gradient: [
                        AppColors.primarySkyBlue,
                        AppColors.accentSkyBlue,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.agentDesignerList,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.upload_file_outlined,
                      title: 'Upload Land',
                      subtitle: 'Add property listings',
                      gradient: [Colors.green.shade400, Colors.green.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.uploadLand),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.business_outlined,
                      title: 'Company Land Booking',
                      subtitle: 'View available slots',
                      gradient: [
                        Colors.orange.shade400,
                        Colors.orange.shade600,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.companyLandSlots,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Business Management'),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.trending_up_outlined,
                      title: 'Work Progress',
                      subtitle: 'Track ongoing projects',
                      gradient: [
                        Colors.purple.shade400,
                        Colors.purple.shade600,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.agentWorkProgress,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Wallet & Payout',
                      subtitle: 'Manage earnings',
                      gradient: [Colors.teal.shade400, Colors.teal.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.agentWallet),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.shopping_cart_outlined,
                      title: 'My Cart & Orders',
                      subtitle: 'View purchases',
                      gradient: [Colors.pink.shade400, Colors.pink.shade600],
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.agentCart),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureCard(
                      context,
                      icon: Icons.download_outlined,
                      title: 'Downloads',
                      subtitle: 'Documents & files',
                      gradient: [
                        Colors.indigo.shade400,
                        Colors.indigo.shade600,
                      ],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.agentDownloads,
                      ),
                    ),

                    const SizedBox(height: 24),
                    _buildHelpCard(context),
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

  Widget _buildQuickStats() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Active Leads', '8', Icons.people_outline),
            _buildStatItem('Properties', '15', Icons.home_outlined),
            _buildStatItem('Earnings', '₹45K', Icons.currency_rupee),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.agentModule, size: 28),
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

  Widget _buildHelpCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.help_outline, color: AppColors.primarySkyBlue, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need Help?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Contact support for assistance',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySkyBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Support'),
            ),
          ],
        ),
      ),
    );
  }
}
