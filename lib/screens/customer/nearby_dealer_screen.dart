import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/app_colors.dart';

class NearbyDealerScreen extends StatefulWidget {
  const NearbyDealerScreen({super.key});

  @override
  State<NearbyDealerScreen> createState() => _NearbyDealerScreenState();
}

class _NearbyDealerScreenState extends State<NearbyDealerScreen> {
  int _selectedDealerIndex = 0;
  bool _showSatellite = false;
  Position? _currentPosition;
  bool _locationPermissionGranted = false;

  final List<DealerInfo> _dealers = [
    DealerInfo(
      name: 'Shree JI',
      address: 'Swarnagiri,moooo, Ajay Colony',
      landmark: 'Madhuban',
      phone: '04 666 023',
      email: 'swarnagiri@gmail.com',
      distance: '2.5 km',
      location: const DealerLocation(28.6139, 77.2090),
    ),
    DealerInfo(
      name: 'Aircraft Centre',
      address: '4236 B-Wing, Vardan Park, Pune Elisabeth Eastern Vaue, CA 9833',
      phone: '04 666 023',
      email: 'swarnagiri@gmail.com',
      distance: '3.2 km',
      location: const DealerLocation(28.6189, 77.2190),
    ),
    DealerInfo(
      name: 'Astro Club',
      address:
          '4 Francis Road, Beverly Hill, Port Elisabeth Eastern Vaue, CA 9833',
      phone: '04 666 023',
      email: 'swarnagiri@gmail.com',
      distance: '5.8 km',
      location: const DealerLocation(28.6089, 77.1990),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    setState(() {
      _locationPermissionGranted = true;
    });

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.grey.shade800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.location_on,
                color: Colors.brown.shade700,
                size: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.folder_rounded, color: Colors.brown.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.brown.shade700,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Placeholder Map (Demo)
          Positioned.fill(
            child: Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map_rounded,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _locationPermissionGranted
                          ? 'Map View (Demo Mode)'
                          : 'Location Permission Required',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_currentPosition != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, '
                        'Long: ${_currentPosition!.longitude.toStringAsFixed(4)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Map Type Toggle
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildMapTypeButton('Map', !_showSatellite, () {
                    setState(() {
                      _showSatellite = false;
                    });
                  }),
                  _buildMapTypeButton('Satellite', _showSatellite, () {
                    setState(() {
                      _showSatellite = true;
                    });
                  }),
                ],
              ),
            ),
          ),

          // Dealer Cards Slider
          Positioned(
            left: 0,
            right: 0,
            top: 70,
            child: SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: _dealers.length,
                onPageChanged: (index) {
                  setState(() {
                    _selectedDealerIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildDealerCard(_dealers[index]);
                },
              ),
            ),
          ),

          // Zoom Controls
          Positioned(
            right: 16,
            bottom: 120,
            child: Column(
              children: [
                _buildZoomButton(Icons.add_rounded, () {
                  // Zoom in (demo)
                }),
                const SizedBox(height: 8),
                _buildZoomButton(Icons.remove_rounded, () {
                  // Zoom out (demo)
                }),
              ],
            ),
          ),

          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNavigation(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTypeButton(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.error : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildDealerCard(DealerInfo dealer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(maxHeight: 210),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dealer.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      dealer.distance,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      dealer.address,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (dealer.landmark != null) ...[
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.place_rounded,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        dealer.landmark!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.phone_rounded,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    dealer.phone,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.email_rounded,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      dealer.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Open in maps
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Directions',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Call dealer
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        side: BorderSide(color: AppColors.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Call',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.grey.shade800, size: 24),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.draw_rounded, 'Online design', false, () {
                Navigator.pop(context);
              }),
              _buildNavItem(Icons.event_rounded, 'Site booking', true, () {}),
              _buildNavItem(
                Icons.construction_rounded,
                'Work in progress',
                false,
                () {
                  Navigator.pop(context);
                },
              ),
              _buildNavItem(Icons.download_rounded, 'Download', false, () {
                Navigator.pop(context);
              }),
              _buildNavItem(Icons.account_circle_rounded, 'Profile', false, () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.deepSkyBlue.withOpacity(0.15)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isActive ? AppColors.deepSkyBlue : Colors.grey.shade500,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DealerInfo {
  final String name;
  final String address;
  final String? landmark;
  final String phone;
  final String email;
  final String distance;
  final DealerLocation location;

  DealerInfo({
    required this.name,
    required this.address,
    this.landmark,
    required this.phone,
    required this.email,
    required this.distance,
    required this.location,
  });
}

class DealerLocation {
  final double latitude;
  final double longitude;

  const DealerLocation(this.latitude, this.longitude);
}
