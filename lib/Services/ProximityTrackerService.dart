import 'dart:async';
import 'package:geolocator/geolocator.dart';
import './NotificationService.dart';
import '../Models/Company.dart';

class ProximityTracker {
  StreamSubscription<Position>? _sub;
  final List<Company> companies;
  final Set<String> _notified = {};

  ProximityTracker(this.companies);

  Future<void> start() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;

    var p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
      if (p == LocationPermission.denied) return;
    }
    if (p == LocationPermission.deniedForever) return;

    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50,
      ),
    ).listen(_check);
  }

  void _check(Position pos) {
    for (final c in companies) {
      final d = Geolocator.distanceBetween(pos.latitude, pos.longitude, c.lat, c.lon);
      final inside = _notified.contains(c.id.toString());

      if (d <= 50 && !inside) {

        _notified.add(c.id.toString());
        NotificationService.show(c.id, c.name);
      } else if (d > 100 && inside) {
        _notified.remove(c.id.toString());
      }
    }
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
    _notified.clear();
  }
}