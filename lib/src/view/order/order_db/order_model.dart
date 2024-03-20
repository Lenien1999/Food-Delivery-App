import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/fire_cloud/food/food_model.dart';

class Orders {
  String? id;
  String userId;
  String name;
  String gender;
  String age;
  String problems;
  DateTime? cancellationTimestamp;
  List<FoodItem> cartFood;
  DateTime date;
  String cafeteria;
  String address;
  TimeOfDay startTime;
  bool isDelivered;
  bool isRejected;
  TimeOfDay endTime;
  Orders({
     this.id,
    this.isDelivered = false,
    this.isRejected = false,
    required this.address,
    required this.cafeteria,
    required this.cartFood,
    required this.userId,
    required this.age,
    required this.date,
    required this.gender,
    required this.name,
    required this.endTime,
    required this.startTime,
    required this.problems,
    this.cancellationTimestamp,
  });
  String getFormattedStartTime() {
    return '${startTime.hour}:${startTime.minute}';
  }

  String getFormattedEndTime() {
    return '${endTime.hour}:${endTime.minute}';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'age': age,
      'date': date,
      'gender': gender,
      'isDelivered': isDelivered,
      'isRejected': isRejected,
      'name': name,
      'cafeteria': cafeteria,
      'problems': problems,
      'startTime': getFormattedStartTime(),
      'endTime': getFormattedEndTime(),
      'cartFood': cartFood.map((foodItem) => foodItem.toJson()).toList(),
      'address': address,
      'cancellationTimestamp': cancellationTimestamp,
    };
  }

  factory Orders.fromJson(Map<String, dynamic> data, String id) {
    return Orders(
      id: id,
      address: data['address'] ?? " ",
      cafeteria: data['cafeteria'] ?? '',
      userId: data['userId'] ?? '',
      age: data['age'] ?? '',
      cancellationTimestamp:
          (data['cancellationTimestamp'] as Timestamp?)?.toDate() ??
              DateTime.now(),
      isDelivered: data['isDelivered'] ?? false,
      isRejected: data['isRejected'] ?? false,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      gender: data['gender'] ?? '',
      name: data['name'] ?? '',
      problems: data['problems'] ?? '',
     cartFood: FoodItem.fromJsonList(data['cartFood'] ?? []),
      startTime: _convertStringToTimeOfDay(data['startTime'] ?? ''),
      endTime: _convertStringToTimeOfDay(data['endTime'] ?? ''),
    );
  }
  static TimeOfDay _convertStringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
