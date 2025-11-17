import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_routes.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Select User Type'),
        backgroundColor: AppColors.primarySkyBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who are you?',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Please select your role to continue',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              ),
              const SizedBox(height: 30),

              // User Type Cards
              _UserTypeCard(
                icon: Icons.person_outline,
                title: 'Customer',
                description: 'Looking for interior design & services',
                color: AppColors.customerModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeCustomer,
                  AppRoutes.login,
                ),
              ),
              const SizedBox(height: 16),

              _UserTypeCard(
                icon: Icons.business_center_outlined,
                title: 'Agent',
                description: 'Real estate agent & property dealer',
                color: AppColors.agentModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeAgent,
                  AppRoutes.agentLogin,
                ),
              ),
              const SizedBox(height: 16),

              _UserTypeCard(
                icon: Icons.design_services_outlined,
                title: 'Designer',
                description: 'Interior designer & architect',
                color: AppColors.designerModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeDesigner,
                  AppRoutes.designerLogin,
                ),
              ),
              const SizedBox(height: 16),

              _UserTypeCard(
                icon: Icons.store_outlined,
                title: 'Vendor',
                description: 'Material supplier & vendor',
                color: AppColors.vendorModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeVendor,
                  AppRoutes.vendorLogin,
                ),
              ),
              const SizedBox(height: 16),

              _UserTypeCard(
                icon: Icons.local_shipping_outlined,
                title: 'Delivery',
                description: 'Delivery personnel',
                color: AppColors.deliveryModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeDelivery,
                  AppRoutes.deliveryLogin,
                ),
              ),
              const SizedBox(height: 16),

              _UserTypeCard(
                icon: Icons.admin_panel_settings_outlined,
                title: 'Admin / HR',
                description: 'Administrative & HR management',
                color: AppColors.adminModule,
                onTap: () => _navigateToLogin(
                  context,
                  AppConstants.userTypeAdmin,
                  AppRoutes.adminLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context, String userType, String route) {
    // Navigate to respective login screen
    Navigator.pushNamed(context, route, arguments: {'userType': userType});
  }
}

class _UserTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _UserTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
