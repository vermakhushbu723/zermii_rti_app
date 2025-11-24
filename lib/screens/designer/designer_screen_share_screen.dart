import 'package:flutter/material.dart';

class DesignerScreenShareScreen extends StatefulWidget {
  const DesignerScreenShareScreen({super.key});

  @override
  State<DesignerScreenShareScreen> createState() =>
      _DesignerScreenShareScreenState();
}

class _DesignerScreenShareScreenState extends State<DesignerScreenShareScreen> {
  bool _isSharing = false;
  bool _isMicOn = true;
  bool _isCameraOn = true;
  String _selectedCustomer = 'John Doe';

  final List<String> _customers = [
    'John Doe',
    'Sarah Wilson',
    'Mike Johnson',
    'Emily Brown',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Share'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: _isSharing ? _buildSharingView() : _buildSetupView(),
    );
  }

  Widget _buildSetupView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Card
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
                      'Share your screen to collaborate with customers in real-time',
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Select Customer
          Text(
            'Select Customer',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCustomer,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                borderRadius: BorderRadius.circular(12),
                items: _customers.map((customer) {
                  return DropdownMenuItem(
                    value: customer,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange,
                          child: Text(
                            customer[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(customer),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCustomer = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Settings
          Text(
            'Session Settings',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Enable Microphone'),
                  subtitle: const Text('Share audio during session'),
                  secondary: const Icon(Icons.mic),
                  value: _isMicOn,
                  onChanged: (value) {
                    setState(() {
                      _isMicOn = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Enable Camera'),
                  subtitle: const Text('Share video during session'),
                  secondary: const Icon(Icons.videocam),
                  value: _isCameraOn,
                  onChanged: (value) {
                    setState(() {
                      _isCameraOn = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Features List
          Text(
            'Features',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _FeatureCard(
            icon: Icons.screen_share,
            title: 'Screen Sharing',
            description: 'Share your entire screen or specific window',
          ),
          const SizedBox(height: 8),
          _FeatureCard(
            icon: Icons.draw,
            title: 'Annotation Tools',
            description: 'Draw and highlight on shared screen',
          ),
          const SizedBox(height: 8),
          _FeatureCard(
            icon: Icons.chat,
            title: 'Live Chat',
            description: 'Chat while screen sharing',
          ),
          const SizedBox(height: 8),
          _FeatureCard(
            icon: Icons.save,
            title: 'Session Recording',
            description: 'Record the session for later reference',
          ),
          const SizedBox(height: 32),

          // Start Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _startScreenShare,
              icon: const Icon(Icons.screen_share),
              label: const Text('Start Screen Share'),
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

  Widget _buildSharingView() {
    return Column(
      children: [
        // Sharing Info Bar
        Container(
          color: Colors.red[50],
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Screen sharing with $_selectedCustomer',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '00:05:23',
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Screen Preview
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!, width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.screen_share, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Your screen is being shared',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Others can see your screen',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Control Panel
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: _isMicOn ? Icons.mic : Icons.mic_off,
                label: _isMicOn ? 'Mic On' : 'Mic Off',
                isActive: _isMicOn,
                onPressed: () {
                  setState(() {
                    _isMicOn = !_isMicOn;
                  });
                },
              ),
              _ControlButton(
                icon: _isCameraOn ? Icons.videocam : Icons.videocam_off,
                label: _isCameraOn ? 'Camera On' : 'Camera Off',
                isActive: _isCameraOn,
                onPressed: () {
                  setState(() {
                    _isCameraOn = !_isCameraOn;
                  });
                },
              ),
              _ControlButton(
                icon: Icons.chat,
                label: 'Chat',
                onPressed: () {
                  // Open chat
                },
              ),
              _ControlButton(
                icon: Icons.call_end,
                label: 'End',
                color: Colors.red,
                onPressed: _stopScreenShare,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startScreenShare() {
    setState(() {
      _isSharing = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Screen sharing started'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _stopScreenShare() {
    setState(() {
      _isSharing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Screen sharing stopped')));
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Screen Share Info'),
          content: const Text(
            'Screen sharing allows you to share your design work, software, or presentations with customers in real-time. You can control audio and video settings during the session.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.1),
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color? color;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.label,
    this.isActive = true,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? (isActive ? Colors.orange : Colors.grey);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 28,
          color: Colors.white,
          style: IconButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: buttonColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
