import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/custom_button.dart';

class Make3DPlan extends StatefulWidget {
  const Make3DPlan({super.key});

  @override
  State<Make3DPlan> createState() => _Make3DPlanState();
}

class _Make3DPlanState extends State<Make3DPlan>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  double _rotationAngle = 0;
  double _zoom = 1.0;
  String _selectedView = 'perspective';

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('3D Plan Viewer'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _sharePlan),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPlan,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildViewControls(),
          Expanded(child: _build3DViewer()),
          _buildBottomToolbar(),
        ],
      ),
    );
  }

  Widget _buildViewControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
      ),
      child: Row(
        children: [
          _buildViewButton('perspective', 'Perspective'),
          const SizedBox(width: 8),
          _buildViewButton('top', 'Top'),
          const SizedBox(width: 8),
          _buildViewButton('front', 'Front'),
          const SizedBox(width: 8),
          _buildViewButton('side', 'Side'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.autorenew, color: Colors.white),
            onPressed: () {
              if (_rotationController.isAnimating) {
                _rotationController.stop();
              } else {
                _rotationController.repeat();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(String view, String label) {
    final isSelected = _selectedView == view;
    return InkWell(
      onTap: () => setState(() => _selectedView = view),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.agentModule : Colors.grey[700],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Widget _build3DViewer() {
    return GestureDetector(
      onScaleUpdate: (details) {
        setState(() {
          _zoom = (_zoom * details.scale).clamp(0.5, 3.0);
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _rotationAngle += details.delta.dx * 0.01;
        });
      },
      child: Container(
        color: Colors.grey[850],
        child: Stack(
          children: [
            // 3D Model Placeholder
            Center(
              child: AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _zoom,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                          _rotationAngle + _rotationController.value * 6.28,
                        ),
                      alignment: Alignment.center,
                      child: _build3DModelPlaceholder(),
                    ),
                  );
                },
              ),
            ),
            // Info overlay
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'View: ${_selectedView.toUpperCase()}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'Zoom: ${(_zoom * 100).toInt()}%',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            // Instructions
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Drag to rotate • Pinch to zoom',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build3DModelPlaceholder() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.agentModule.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Stack(
        children: [
          // Front wall
          Positioned(
            left: 40,
            top: 40,
            child: Container(
              width: 220,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.brown[300],
                border: Border.all(color: Colors.white30),
              ),
            ),
          ),
          // Side wall
          Positioned(
            left: 260,
            top: 40,
            child: Container(
              width: 40,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.brown[400],
                border: Border.all(color: Colors.white30),
              ),
            ),
          ),
          // Roof
          Positioned(
            left: 40,
            top: 20,
            child: Container(
              width: 260,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.brown[200],
                border: Border.all(color: Colors.white30),
              ),
            ),
          ),
          // Door
          Positioned(
            left: 120,
            top: 100,
            child: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.brown[700],
                border: Border.all(color: Colors.white30),
              ),
            ),
          ),
          // Window
          Positioned(
            left: 180,
            top: 70,
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                border: Border.all(color: Colors.white30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.zoom_in, color: Colors.white),
                onPressed: () =>
                    setState(() => _zoom = (_zoom + 0.2).clamp(0.5, 3.0)),
              ),
              IconButton(
                icon: const Icon(Icons.zoom_out, color: Colors.white),
                onPressed: () =>
                    setState(() => _zoom = (_zoom - 0.2).clamp(0.5, 3.0)),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  text: 'Save 3D Model',
                  onPressed: () => _savePlan(),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text(
                    'Back to 2D',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sharePlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing 3D plan...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _downloadPlan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading 3D model...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _savePlan() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save 3D Plan'),
        content: const Text(
          'Your 3D floor plan will be saved to your projects.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('3D plan saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.agentModule,
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
