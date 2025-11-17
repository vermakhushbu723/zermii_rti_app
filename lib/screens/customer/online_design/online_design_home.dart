import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class OnlineDesignHome extends StatelessWidget {
  const OnlineDesignHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Online Design'),
        backgroundColor: AppColors.primarySkyBlue,
      ),
      body: const Center(child: Text('Online Design Home - Coming Soon')),
    );
  }
}
