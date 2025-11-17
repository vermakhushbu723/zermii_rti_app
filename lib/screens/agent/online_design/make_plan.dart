import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/custom_button.dart';

class MakePlan extends StatefulWidget {
  const MakePlan({super.key});

  @override
  State<MakePlan> createState() => _MakePlanState();
}

class _MakePlanState extends State<MakePlan> {
  String _selectedTool = 'wall';
  final List<Map<String, dynamic>> _drawings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Make 2D Plan'),
        backgroundColor: AppColors.agentModule,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _drawings.isEmpty ? null : _undo,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _savePlan),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildDrawingCanvas()),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildToolButton('wall', Icons.web_asset, 'Wall'),
            _buildToolButton('door', Icons.door_front_door, 'Door'),
            _buildToolButton('window', Icons.window, 'Window'),
            _buildToolButton('room', Icons.crop_square, 'Room'),
            _buildToolButton('furniture', Icons.weekend, 'Furniture'),
            _buildToolButton('dimension', Icons.straighten, 'Dimension'),
            _buildToolButton('text', Icons.text_fields, 'Text'),
            _buildToolButton('erase', Icons.delete, 'Erase'),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton(String tool, IconData icon, String label) {
    final isSelected = _selectedTool == tool;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedTool = tool),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.agentModule : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.agentModule : Colors.grey[300]!,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawingCanvas() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Grid background
          CustomPaint(painter: GridPainter(), size: Size.infinite),
          // Drawing area
          GestureDetector(
            onTapDown: (details) => _handleCanvasTap(details.localPosition),
            child: Container(
              color: Colors.transparent,
              child: CustomPaint(
                painter: FloorPlanPainter(_drawings),
                size: Size.infinite,
              ),
            ),
          ),
          // Tool indicator
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.agentModule.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Selected: ${_selectedTool.toUpperCase()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _clearCanvas,
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear All'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: 'Save & Continue',
              onPressed: () => _savePlan(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCanvasTap(Offset position) {
    setState(() {
      _drawings.add({
        'type': _selectedTool,
        'position': position,
        'timestamp': DateTime.now(),
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_selectedTool added at (${position.dx.toInt()}, ${position.dy.toInt()})',
        ),
        duration: const Duration(milliseconds: 500),
        backgroundColor: AppColors.agentModule,
      ),
    );
  }

  void _undo() {
    if (_drawings.isNotEmpty) {
      setState(() => _drawings.removeLast());
    }
  }

  void _clearCanvas() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Canvas'),
        content: const Text('Are you sure you want to clear all drawings?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _drawings.clear());
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _savePlan() {
    if (_drawings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please draw something before saving'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save Plan'),
        content: const Text('Save your 2D floor plan and proceed to 3D view?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Plan saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamed(context, '/agent/make3DPlan');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.agentModule,
            ),
            child: const Text(
              'Save & Continue',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Grid painter for the canvas
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 0.5;

    const gridSize = 20.0;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floor plan painter
class FloorPlanPainter extends CustomPainter {
  final List<Map<String, dynamic>> drawings;

  FloorPlanPainter(this.drawings);

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawing in drawings) {
      final position = drawing['position'] as Offset;
      final type = drawing['type'] as String;

      final paint = Paint()
        ..color = _getColorForType(type)
        ..strokeWidth = 3;

      switch (type) {
        case 'wall':
          canvas.drawCircle(position, 5, paint);
          break;
        case 'door':
          canvas.drawRect(
            Rect.fromCenter(center: position, width: 40, height: 10),
            paint,
          );
          break;
        case 'window':
          canvas.drawRect(
            Rect.fromCenter(center: position, width: 30, height: 5),
            paint,
          );
          break;
        default:
          canvas.drawCircle(position, 8, paint);
      }
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'wall':
        return Colors.black;
      case 'door':
        return Colors.brown;
      case 'window':
        return Colors.blue;
      case 'room':
        return Colors.green;
      case 'furniture':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  bool shouldRepaint(covariant FloorPlanPainter oldDelegate) => true;
}
