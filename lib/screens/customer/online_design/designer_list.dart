import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class DesignerList extends StatelessWidget {
  const DesignerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Designer List'),
        backgroundColor: AppColors.primarySkyBlue,
      ),
      body: const Center(child: Text('Designer List - Coming Soon')),
    );
  }
}
