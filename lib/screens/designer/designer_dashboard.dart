import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_routes.dart';
import '../../config/app_colors.dart';
import '../../providers/auth_provider.dart';

class DesignerDashboard extends StatefulWidget {
  const DesignerDashboard({super.key});

  @override
  State<DesignerDashboard> createState() => _DesignerDashboardState();
}

class _DesignerDashboardState extends State<DesignerDashboard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final userName = user?['name'] ?? 'ER Monalisha Singha';
    final userId = user?['userId'] ?? 'ZERM0049';
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundSkyBlue,
      drawer: !isDesktop ? _buildDrawer(context, userName, authProvider) : null,
      body: SafeArea(
        child: _fadeAnimation != null
            ? FadeTransition(
                opacity: _fadeAnimation!,
                child: isDesktop
                    ? Row(
                        children: [
                          // Desktop Sidebar
                          _buildSidebar(context, userName, authProvider),
                          // Main Content
                          Expanded(
                            child: _buildMainContent(
                              context,
                              userName,
                              userId,
                              isDesktop,
                            ),
                          ),
                        ],
                      )
                    : _buildMainContent(context, userName, userId, isDesktop),
              )
            : isDesktop
            ? Row(
                children: [
                  _buildSidebar(context, userName, authProvider),
                  Expanded(
                    child: _buildMainContent(
                      context,
                      userName,
                      userId,
                      isDesktop,
                    ),
                  ),
                ],
              )
            : _buildMainContent(context, userName, userId, isDesktop),
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    String userName,
    String userId,
    bool isDesktop,
  ) {
    return Column(
      children: [
        // Top Header
        _buildHeader(context, userName, userId, isDesktop),

        // Content Area
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            child: Column(
              children: [
                if (isDesktop)
                  // Desktop Layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildVideoCallSection(isDesktop),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildAppointmentStats(),
                            const SizedBox(height: 16),
                            _buildTeamMembersSection(),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  // Mobile Layout
                  Column(
                    children: [
                      _buildAppointmentStats(),
                      const SizedBox(height: 16),
                      _buildVideoCallSection(isDesktop),
                      const SizedBox(height: 16),
                      _buildTeamMembersSection(),
                    ],
                  ),
                const SizedBox(height: 24),
                _buildActionButtons(context, isDesktop),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(
    BuildContext context,
    String userName,
    AuthProvider authProvider,
  ) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.lightSkyBlue.withOpacity(0.3),
            AppColors.backgroundSkyBlue,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),

          // Profile Section
          Hero(
            tag: 'designer_profile',
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.designerModule.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.designerModule,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.designerModule.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Designer',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Menu Items
          _buildMenuItem(
            icon: Icons.dashboard,
            label: 'DASHBOARD',
            isActive: true,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.event,
            label: 'APPOINTMENT',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.designerRequests),
          ),
          _buildMenuItem(
            icon: Icons.person,
            label: 'PROFILE',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.designerProfile),
          ),
          _buildMenuItem(
            icon: Icons.payment,
            label: 'PAYOUT',
            onTap: () => Navigator.pushNamed(context, AppRoutes.designerPayout),
          ),
          _buildMenuItem(
            icon: Icons.brush,
            label: 'DESIGN',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.designerWorkUpload),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            label: 'SETTING',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.designerSettings),
          ),

          const Spacer(),

          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                authProvider.logout();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: isActive ? AppColors.designerModule : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        elevation: isActive ? 4 : 0,
        shadowColor: isActive
            ? AppColors.designerModule.withOpacity(0.4)
            : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.primarySkyBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isActive ? Colors.white : AppColors.designerModule,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textPrimary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String userName,
    String userId,
    bool isDesktop,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 24 : 12,
        vertical: isDesktop ? 16 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // First Row: Menu, Search, Profile
          Row(
            children: [
              if (!isDesktop)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: AppColors.designerModule.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.designerModule,
                      size: 22,
                    ),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),

              // Search Bar
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'SEARCH',
                      hintStyle: TextStyle(
                        color: AppColors.hintText,
                        fontSize: isDesktop ? 14 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.hintText,
                        size: isDesktop ? 20 : 18,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 12 : 8),

              // Profile Section (Compact on Mobile)
              if (isDesktop)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.designerModule.withOpacity(
                          0.2,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.designerModule,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'ID: $userId',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.designerModule.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.designerModule,
                    size: 20,
                  ),
                ),
            ],
          ),

          // Second Row: LIVE and STOP buttons
          if (isDesktop) const SizedBox(height: 12),
          if (isDesktop)
            Row(
              children: [
                const Spacer(),
                _buildStatusButton(
                  icon: Icons.fiber_manual_record,
                  label: 'LIVE',
                  color: AppColors.error,
                  isActive: true,
                  onTap: () {},
                  isCompact: false,
                ),
                const SizedBox(width: 12),
                _buildStatusButton(
                  icon: Icons.stop_circle,
                  label: 'STOP',
                  color: AppColors.error,
                  isActive: false,
                  onTap: () {},
                  isCompact: false,
                ),
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatusButton(
                      icon: Icons.fiber_manual_record,
                      label: 'LIVE',
                      color: AppColors.error,
                      isActive: true,
                      onTap: () {},
                      isCompact: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatusButton(
                      icon: Icons.stop_circle,
                      label: 'STOP',
                      color: AppColors.error,
                      isActive: false,
                      onTap: () {},
                      isCompact: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusButton({
    required IconData icon,
    required String label,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
    bool isCompact = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 12 : 16,
          vertical: isCompact ? 8 : 10,
        ),
        decoration: BoxDecoration(
          color: isActive ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : color,
              size: isCompact ? 16 : 18,
            ),
            SizedBox(width: isCompact ? 4 : 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: isCompact ? 12 : 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCallSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppColors.cardBackground],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.videocam, color: AppColors.designerModule, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Video Call Design',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Video Call Interface
          Container(
            height: isDesktop ? 350 : 250,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildCallButton(Icons.call_end, Colors.red),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.call, Colors.green),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.videocam, Colors.white),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.videocam_off, Colors.white),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Video call design',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 40),

                      // Bottom Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildCallButton(Icons.mic, Colors.white),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.mic_off, Colors.white),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.person_add, Colors.white),
                          const SizedBox(width: 20),
                          _buildCallButton(Icons.lock, Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton(IconData icon, Color color) {
    final isWhite = color == Colors.white;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: isWhite
            ? LinearGradient(
                colors: [
                  AppColors.primarySkyBlue.withOpacity(0.3),
                  AppColors.deepSkyBlue.withOpacity(0.2),
                ],
              )
            : LinearGradient(colors: [color, color.withOpacity(0.8)]),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: isWhite ? Colors.white : Colors.white, size: 28),
    );
  }

  Widget _buildTeamMembersSection() {
    final members = [
      {'name': 'MAHESH K', 'id': 'ID-ZERM2300', 'status': 'online'},
      {'name': 'R PATHAK', 'id': 'ID-ZERM230', 'status': 'online'},
      {'name': 'RITU KUMARI', 'id': 'ID-ZERM2303', 'status': 'busy'},
      {'name': 'S. KIRTI', 'id': 'ID-ZERM2304', 'status': 'online'},
      {'name': 'JAYANT K', 'id': 'ID-ZERM2305', 'status': 'offline'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppColors.cardBackground],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: AppColors.designerModule, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...members
              .map(
                (member) => _buildTeamMemberCard(
                  member['name'] as String,
                  member['id'] as String,
                  member['status'] as String,
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(String name, String id, String status) {
    final statusColor = status == 'online'
        ? AppColors.success
        : status == 'busy'
        ? AppColors.warning
        : AppColors.textSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundSkyBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primarySkyBlue.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: AppColors.designerModule,
                  size: 24,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  id,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'NEW MESSAGE',
              Icons.email,
              Colors.orange.shade400,
              () => Navigator.pushNamed(context, AppRoutes.designerMessages),
              isDesktop: isDesktop,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              'NEW DESIGN',
              Icons.brush,
              Colors.green.shade400,
              () => Navigator.pushNamed(context, AppRoutes.designerWorkUpload),
              isDesktop: isDesktop,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              'SHARE SCREEN',
              Icons.screen_share,
              Colors.white,
              () => Navigator.pushNamed(context, AppRoutes.designerScreenShare),
              borderColor: Colors.grey.shade400,
              textColor: Colors.black,
              isDesktop: isDesktop,
            ),
          ),
        ],
      );
    }

    // Mobile layout
    return Column(
      children: [
        _buildActionButton(
          'NEW MESSAGE',
          Icons.email,
          Colors.orange.shade400,
          () => Navigator.pushNamed(context, AppRoutes.designerMessages),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'NEW DESIGN',
          Icons.brush,
          Colors.green.shade400,
          () => Navigator.pushNamed(context, AppRoutes.designerWorkUpload),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'SHARE SCREEN',
          Icons.screen_share,
          Colors.white,
          () => Navigator.pushNamed(context, AppRoutes.designerScreenShare),
          borderColor: Colors.grey.shade400,
          textColor: Colors.black,
          isDesktop: isDesktop,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    Color? borderColor,
    Color? textColor,
    bool isDesktop = true,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color == Colors.white ? Colors.green : Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color == Colors.white ? Colors.green : Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(
    BuildContext context,
    String userName,
    AuthProvider authProvider,
  ) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.lightSkyBlue.withOpacity(0.3),
              AppColors.backgroundSkyBlue,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.designerModule.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.designerModule,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildMenuItem(
              icon: Icons.dashboard,
              label: 'DASHBOARD',
              isActive: true,
              onTap: () => Navigator.pop(context),
            ),
            _buildMenuItem(
              icon: Icons.event,
              label: 'APPOINTMENT',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.designerRequests);
              },
            ),
            _buildMenuItem(
              icon: Icons.person,
              label: 'PROFILE',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.designerProfile);
              },
            ),
            _buildMenuItem(
              icon: Icons.payment,
              label: 'PAYOUT',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.designerPayout);
              },
            ),
            _buildMenuItem(
              icon: Icons.brush,
              label: 'DESIGN',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.designerWorkUpload);
              },
            ),
            _buildMenuItem(
              icon: Icons.settings,
              label: 'SETTING',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.designerSettings);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentStats() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppColors.cardBackground],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_available,
                color: AppColors.designerModule,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Appointments Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'TOTAL',
                  '4000',
                  AppColors.info,
                  Icons.calendar_today,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'COMPLETED',
                  '3500',
                  AppColors.success,
                  Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'CANCEL',
                  '250',
                  AppColors.error,
                  Icons.cancel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'FOLLOW UP',
                  '250',
                  AppColors.warning,
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'APPOINTMENT',
            style: TextStyle(fontSize: 9, color: color.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
