import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/digital_stamp_model.dart';

abstract class CameraLocalDataSource {
  Future<void> saveDigitalStamp(DigitalStampModel stamp);
  Future<List<DigitalStampModel>> getUserStamps();
  Future<void> deleteStamp(String id);
}

class CameraLocalDataSourceImpl implements CameraLocalDataSource {
  static const String _stampsKey = 'digital_stamps';

  @override
  Future<void> saveDigitalStamp(DigitalStampModel stamp) async {
    final prefs = await SharedPreferences.getInstance();
    final stamps = await getUserStamps();
    
    // Check if stamp already exists
    final existingIndex = stamps.indexWhere((s) => s.landmarkId == stamp.landmarkId);
    if (existingIndex != -1) {
      stamps[existingIndex] = stamp;
    } else {
      stamps.add(stamp);
    }
    
    final stampsJson = stamps.map((stamp) => stamp.toMap()).toList();
    await prefs.setString(_stampsKey, jsonEncode(stampsJson));
  }

  @override
  Future<List<DigitalStampModel>> getUserStamps() async {
    final prefs = await SharedPreferences.getInstance();
    final stampsString = prefs.getString(_stampsKey);
    
    if (stampsString == null) return [];
    
    final List<dynamic> stampsJson = jsonDecode(stampsString);
    return stampsJson
        .map((json) => DigitalStampModel.fromMap(json))
        .toList();
  }

  @override
  Future<void> deleteStamp(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final stamps = await getUserStamps();
    stamps.removeWhere((stamp) => stamp.id == id);
    
    final stampsJson = stamps.map((stamp) => stamp.toMap()).toList();
    await prefs.setString(_stampsKey, jsonEncode(stampsJson));
  }
}
