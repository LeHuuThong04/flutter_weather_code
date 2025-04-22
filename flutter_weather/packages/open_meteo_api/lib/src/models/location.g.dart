// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// Chuyển JSON thành Location
Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location', // Class được check
      json,
      ($checkedConvert) {
        final val = Location(
          id: $checkedConvert('id', (v) => (v as num).toInt()), // Chuyển id thành int
          name: $checkedConvert('name', (v) => v as String), // chuyển name thành string 
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()), // chuyển vĩ độ thành số thập phân
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()), // chuyển kinh độ thành số thập phân
        );
        return val;
      },
    );
