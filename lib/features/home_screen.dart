import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../core/services/location_service.dart';
import '../features/prayer_times/services/prayer_time_service.dart';
import 'profile/profile_screen.dart';
import 'prayer_times/prayer_times_screen.dart';
import 'qibla/qibla_screen.dart';
import 'dua/dua_screen.dart';
import 'zakat/zakat_calculator_screen.dart';
import 'quran/quran_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  Map<String, String> _prayerTimes = {};
  String _currentLocation = 'New Delhi';
  final Set<Marker> _markers = {};
  int _selectedIndex = 0;
  String _currentDate = '';
  String _currentTime = '';
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _updateDateTime();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _currentDate = DateFormat('d-M-yyyy').format(now);
      _currentTime = DateFormat('HH:mm').format(now);
    });
  }

  Future<void> _initializeLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = 'Location services are disabled.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = 'Location permissions are denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation = 'Location permissions are permanently denied.';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final address = await LocationService.getAddressFromCoordinates(position);

      final prayerTimes = await PrayerTimeService.getPrayerTimes(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _currentPosition = position;
        _currentLocation = address;
        _prayerTimes = prayerTimes;
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );
      });
      await _fetchNearbyMasjids(position.latitude, position.longitude);
    } catch (e) {
      // Error getting location, using default
      setState(() {
        _currentLocation = 'New Delhi';
      });
    }
  }

  Future<void> _fetchNearbyMasjids(double lat, double lng) async {
    // For demo purposes, adding some sample mosque markers
    final sampleMosques = [
      {'name': 'Jama Masjid', 'lat': lat + 0.01, 'lng': lng + 0.01},
      {'name': 'Fatehpuri Masjid', 'lat': lat - 0.01, 'lng': lng - 0.01},
      {'name': 'Red Fort Mosque', 'lat': lat + 0.005, 'lng': lng - 0.005},
    ];

    setState(() {
      for (var mosque in sampleMosques) {
        _markers.add(
          Marker(
            markerId: MarkerId(mosque['name'] as String),
            position: LatLng(mosque['lat'] as double, mosque['lng'] as double),
            infoWindow: InfoWindow(title: mosque['name'] as String),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FD),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            _buildHomeContent(),
            const QuranScreen(),
            _buildMoreContent(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4A90E2),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with location and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentLocation,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                _currentTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Date and Prayer Time Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _currentDate,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMMM').format(DateTime.now()).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'SAHR ${_prayerTimes['Fajr'] ?? '5:55'}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'START ${_prayerTimes['Isha'] ?? '7:33'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ISHA',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'END ${_prayerTimes['Fajr'] ?? '5:55'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Dua Shortcuts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDuaCard('Dua for travel', Icons.flight, Colors.blue, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DuaScreen(category: 'travel')));
              }),
              _buildDuaCard('Dua for food', Icons.restaurant, Colors.grey, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DuaScreen(category: 'food')));
              }),
              _buildDuaCard('Dua for sleeping', Icons.bed, Colors.grey, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DuaScreen(category: 'sleep')));
              }),
            ],
          ),
          const SizedBox(height: 32),

          // Prayer Times Section
          const Text(
            'Namaz timing',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildPrayerTimesCard(),
          const SizedBox(height: 32),

          // Nearby Masjid Section
          const Text(
            'Nearby masjid',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildMapSection(),
        ],
      ),
    );
  }

  Widget _buildMoreContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildFeatureCard('Qibla Direction', Icons.explore, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QiblaScreen()));
              }),
              _buildFeatureCard('Zakat Calculator', Icons.calculate, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ZakatCalculatorScreen()));
              }),
              _buildFeatureCard('Prayer Times', Icons.schedule, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrayerTimesScreen()));
              }),
              _buildFeatureCard('Profile', Icons.person, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDuaCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color == Colors.blue ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color == Colors.blue ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color == Colors.blue ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimesCard() {
    final prayers = [
      {
        'name': 'Fajar',
        'time': _prayerTimes['Fajr'] ?? '6:40 am',
        'icon': Icons.wb_sunny_outlined
      },
      {
        'name': 'Zohar',
        'time': _prayerTimes['Dhuhr'] ?? '2:00 pm',
        'icon': Icons.wb_sunny
      },
      {
        'name': 'Asar',
        'time': _prayerTimes['Asr'] ?? '5:15 pm',
        'icon': Icons.wb_twilight
      },
      {
        'name': 'Maghrib',
        'time': _prayerTimes['Maghrib'] ?? '6:30 pm',
        'icon': Icons.wb_shade
      },
      {
        'name': 'Isha',
        'time': _prayerTimes['Isha'] ?? '8:30 pm',
        'icon': Icons.nights_stay
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: prayers.map((prayer) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  prayer['icon'] as IconData,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    prayer['name'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  prayer['time'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.settings,
                  color: Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.notifications,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _currentPosition != null
            ? GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 14,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              )
            : Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF4A90E2),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
