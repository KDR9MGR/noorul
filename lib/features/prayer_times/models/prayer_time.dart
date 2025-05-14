class PrayerTime {
  final String name;
  final DateTime time;
  final String icon;

  PrayerTime({
    required this.name,
    required this.time,
    required this.icon,
  });

  static String getIconForPrayer(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return '🌅';
      case 'zohar':
        return '☀️';
      case 'asar':
        return '🌤️';
      case 'maghrib':
        return '🌅';
      case 'isha':
        return '🌙';
      default:
        return '⏰';
    }
  }
} 