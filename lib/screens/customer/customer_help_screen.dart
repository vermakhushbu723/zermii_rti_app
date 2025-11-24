import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class CustomerHelpScreen extends StatelessWidget {
  const CustomerHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text(
          'Help & FAQs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primarySkyBlue, AppColors.deepSkyBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpCard(
            icon: Icons.headset_mic_rounded,
            title: 'Contact Support',
            description: 'Get in touch with our support team',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildHelpCard(
            icon: Icons.chat_rounded,
            title: 'Live Chat',
            description: 'Chat with our support agents',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildHelpCard(
            icon: Icons.email_rounded,
            title: 'Email Us',
            description: 'Send us an email at support@zermii.com',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          _buildFAQSection(),
        ],
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primarySkyBlue.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.deepSkyBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.deepSkyBlue, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySkyBlue.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFAQItem(
            question: 'How do I track my order?',
            answer:
                'You can track your order by going to the Orders section in your account. Click on the order you want to track to see detailed tracking information.',
          ),
          _buildDivider(),
          _buildFAQItem(
            question: 'What is your return policy?',
            answer:
                'We offer a 30-day return policy on all furniture items. The product must be in its original condition with all tags and packaging intact.',
          ),
          _buildDivider(),
          _buildFAQItem(
            question: 'How long does delivery take?',
            answer:
                'Standard delivery takes 7-14 business days. Express delivery is available for select items and locations, which takes 3-5 business days.',
          ),
          _buildDivider(),
          _buildFAQItem(
            question: 'Do you offer assembly services?',
            answer:
                'Yes, we provide professional assembly services for all furniture items. You can add this service during checkout or contact our support team.',
          ),
          _buildDivider(),
          _buildFAQItem(
            question: 'What payment methods do you accept?',
            answer:
                'We accept all major credit/debit cards, UPI, net banking, and digital wallets. Cash on delivery is available for orders below ₹50,000.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        splashColor: AppColors.primarySkyBlue.withOpacity(0.1),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        iconColor: AppColors.deepSkyBlue,
        collapsedIconColor: Colors.grey.shade600,
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey.shade200);
  }
}
