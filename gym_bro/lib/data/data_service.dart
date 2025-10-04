import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';

class DataService {
  static Future<GymData> loadGymData() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/gym_data.json',
      );
      final Map<String, dynamic> data = json.decode(response);
      return GymData.fromJson(data);
    } catch (e) {
      // Use debugPrint instead of print for production
      debugPrint("Error loading gym data: $e");
      return GymData(
        responses: {},
        workouts: {},
        nutrition: {},
        weeklySchedule: {},
      );
    }
  }
}
