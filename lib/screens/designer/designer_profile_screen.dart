import 'package:flutter/material.dart';

class DesignerProfileScreen extends StatefulWidget {
  const DesignerProfileScreen({super.key});

  @override
  State<DesignerProfileScreen> createState() => _DesignerProfileScreenState();
}

class _DesignerProfileScreenState extends State<DesignerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Verification'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Verification'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildProfileTab(), _buildVerificationTab()],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Picture
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange,
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 20),
                    color: Colors.orange,
                    onPressed: _changePicture,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Personal Information
          _SectionHeader(title: 'Personal Information'),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Full Name',
            value: 'Designer Name',
            icon: Icons.person,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Email',
            value: 'designer@example.com',
            icon: Icons.email,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Phone',
            value: '+92 300 1234567',
            icon: Icons.phone,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Date of Birth',
            value: '01/01/1990',
            icon: Icons.cake,
            onEdit: () {},
          ),
          const SizedBox(height: 24),

          // Professional Information
          _SectionHeader(title: 'Professional Information'),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Specialization',
            value: 'Interior Design',
            icon: Icons.design_services,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Experience',
            value: '5 Years',
            icon: Icons.work,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Education',
            value: 'Bachelor in Interior Design',
            icon: Icons.school,
            onEdit: () {},
          ),
          const SizedBox(height: 24),

          // Address
          _SectionHeader(title: 'Address'),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'Street Address',
            value: 'Street 123, Block A',
            icon: Icons.location_on,
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          _ProfileField(
            label: 'City',
            value: 'Karachi',
            icon: Icons.location_city,
            onEdit: () {},
          ),
          const SizedBox(height: 24),

          // Portfolio
          _SectionHeader(title: 'Portfolio'),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Portfolio Link',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'www.behance.net/yourportfolio',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Change Password
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _changePassword,
              icon: const Icon(Icons.lock),
              label: const Text('Change Password'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Logout
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Verification Status
          Card(
            color: _isVerified ? Colors.green[50] : Colors.orange[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    _isVerified ? Icons.verified : Icons.pending,
                    color: _isVerified ? Colors.green : Colors.orange,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isVerified
                              ? 'Verified Designer'
                              : 'Verification Pending',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isVerified ? Colors.green : Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isVerified
                              ? 'Your account is verified'
                              : 'Please complete your verification',
                          style: TextStyle(
                            color: _isVerified
                                ? Colors.green[900]
                                : Colors.orange[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Info Card
          if (!_isVerified)
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Complete your verification to gain customer trust and get more projects',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),

          // Required Documents
          _SectionHeader(title: 'Required Documents'),
          const SizedBox(height: 12),

          // CNIC
          _DocumentCard(
            title: 'National ID Card (CNIC)',
            description: 'Upload front and back of your CNIC',
            icon: Icons.credit_card,
            isUploaded: _isVerified,
            onUpload: _uploadCNIC,
          ),
          const SizedBox(height: 12),

          // Professional Certificate
          _DocumentCard(
            title: 'Professional Certificate',
            description: 'Upload your design certification or degree',
            icon: Icons.school,
            isUploaded: false,
            onUpload: _uploadCertificate,
          ),
          const SizedBox(height: 12),

          // Portfolio
          _DocumentCard(
            title: 'Portfolio/Previous Work',
            description: 'Upload samples of your previous work',
            icon: Icons.work,
            isUploaded: false,
            onUpload: _uploadPortfolio,
          ),
          const SizedBox(height: 24),

          // Additional Verification
          _SectionHeader(title: 'Additional Verification'),
          const SizedBox(height: 12),

          // Phone Verification
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.1),
                child: Icon(Icons.phone, color: Colors.green),
              ),
              title: const Text('Phone Number'),
              subtitle: const Text('Verified'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
          const SizedBox(height: 12),

          // Email Verification
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.1),
                child: Icon(Icons.email, color: Colors.green),
              ),
              title: const Text('Email Address'),
              subtitle: const Text('Verified'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
          const SizedBox(height: 32),

          // Submit for Verification
          if (!_isVerified)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitVerification,
                icon: const Icon(Icons.send),
                label: const Text('Submit for Verification'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _changePicture() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.photo_library, color: Colors.white),
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform logout
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _uploadCNIC() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('CNIC upload feature coming soon')),
    );
  }

  void _uploadCertificate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Certificate upload feature coming soon')),
    );
  }

  void _uploadPortfolio() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Portfolio upload feature coming soon')),
    );
  }

  void _submitVerification() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit Verification'),
          content: const Text(
            'Please make sure all required documents are uploaded. Your verification request will be reviewed within 24-48 hours.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verification request submitted!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onEdit;

  const _ProfileField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUploaded;
  final VoidCallback onUpload;

  const _DocumentCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isUploaded,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isUploaded
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              child: Icon(
                icon,
                color: isUploaded ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isUploaded)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (!isUploaded) ...[
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: onUpload,
                      icon: const Icon(Icons.cloud_upload, size: 16),
                      label: const Text('Upload'),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
