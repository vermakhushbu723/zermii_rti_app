import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.getStarted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primarySkyBlue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: ClipOval(
                child: Image.network(
                  'https://zermii.com/wp-content/uploads/2025/10/zermi_logo_psd_copy__1_-removebg-preview.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.home_work_rounded,
                      size: 80,
                      color: AppColors.primarySkyBlue,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            // App Name
            Text(
              'Zermii RTI',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.deepSkyBlue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Your Complete Interior Design Solution',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: 50),

            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepSkyBlue),
            ),
          ],
        ),
      ),
    );
  }
}
