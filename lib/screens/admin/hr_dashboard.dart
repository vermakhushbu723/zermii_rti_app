import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('HR Dashboard'),
        backgroundColor: AppColors.adminModule,
      ),
      body: const Center(child: Text('HR Dashboard - Coming Soon')),
    );
  }
}
