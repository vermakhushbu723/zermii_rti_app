import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class DesignerDetails extends StatelessWidget {
  const DesignerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Designer Details'),
        backgroundColor: AppColors.primarySkyBlue,
      ),
      body: const Center(child: Text('Designer Details - Coming Soon')),
    );
  }
}
