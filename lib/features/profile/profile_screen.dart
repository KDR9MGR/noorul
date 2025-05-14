import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _storage = const FlutterSecureStorage();
  late SharedPreferences _prefs;
  String _userEmail = '';
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final email = await _storage.read(key: 'email');
    setState(() {
      _userEmail = email ?? 'Not logged in';
      _notificationsEnabled = _prefs.getBool('notifications_enabled') ?? true;
      _darkModeEnabled = _prefs.getBool('dark_mode_enabled') ?? false;
      _selectedLanguage = _prefs.getString('selected_language') ?? 'English';
    });
  }

  Future<void> _updateNotifications(bool value) async {
    await _prefs.setBool('notifications_enabled', value);
    setState(() {
      _notificationsEnabled = value;
    });
  }

  Future<void> _updateDarkMode(bool value) async {
    await _prefs.setBool('dark_mode_enabled', value);
    setState(() {
      _darkModeEnabled = value;
    });
    // Implement theme switching logic here
  }

  Future<void> _updateLanguage(String value) async {
    await _prefs.setString('selected_language', value);
    setState(() {
      _selectedLanguage = value;
    });
    // Implement language switching logic here
  }

  Future<void> _handleLogout() async {
    await _storage.deleteAll();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/auth');
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            _userEmail,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SwitchListTile(
          title: const Text('Prayer Time Notifications'),
          subtitle: const Text('Receive notifications for prayer times'),
          value: _notificationsEnabled,
          onChanged: _updateNotifications,
        ),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Enable dark theme'),
          value: _darkModeEnabled,
          onChanged: _updateDarkMode,
        ),
        ListTile(
          title: const Text('Language'),
          subtitle: Text(_selectedLanguage),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _showLanguageDialog,
        ),
        ListTile(
          title: const Text('About'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to About screen
          },
        ),
        ListTile(
          title: const Text('Help & Support'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to Help & Support screen
          },
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to Privacy Policy screen
          },
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout, color: Colors.red),
          onTap: _handleLogout,
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'English';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Arabic'),
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'Arabic';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Urdu'),
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'Urdu';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const Divider(),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }
} 