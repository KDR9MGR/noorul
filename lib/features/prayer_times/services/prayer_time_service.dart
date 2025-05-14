import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerTimeService {
  static Future<Map<String, String>> getPrayerTimes(
    double latitude,
    double longitude,
  ) async {
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    final DateTime now = DateTime.now();
    final coordinates = Coordinates(latitude, longitude);
    final PrayerTimes prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(now),
      params,
    );

    final formatter = DateFormat('h:mm a');

    return {
      'Fajr': formatter.format(prayerTimes.fajr),
      'Sunrise': formatter.format(prayerTimes.sunrise),
      'Dhuhr': formatter.format(prayerTimes.dhuhr),
      'Asr': formatter.format(prayerTimes.asr),
      'Maghrib': formatter.format(prayerTimes.maghrib),
      'Isha': formatter.format(prayerTimes.isha),
    };
  }

  static String getNextPrayer(Map<String, String> prayerTimes) {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    final currentTime = formatter.format(now);

    // Convert prayer times to comparable DateTime objects
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    Map<String, DateTime> prayerDateTimes = {};

    prayerTimes.forEach((name, time) {
      try {
        final dateTimeStr = '$todayStr $time';
        final dateTime = DateFormat('yyyy-MM-dd h:mm a').parse(dateTimeStr);
        prayerDateTimes[name] = dateTime;
      } catch (e) {
        print('Error parsing time for $name: $e');
      }
    });

    // Find the next prayer
    DateTime? nextPrayerTime;
    String nextPrayerName = '';

    prayerDateTimes.forEach((name, time) {
      if (time.isAfter(now)) {
        if (nextPrayerTime == null || time.isBefore(nextPrayerTime!)) {
          nextPrayerTime = time;
          nextPrayerName = name;
        }
      }
    });

    return nextPrayerName.isNotEmpty ? nextPrayerName : 'Fajr';
  }
} 