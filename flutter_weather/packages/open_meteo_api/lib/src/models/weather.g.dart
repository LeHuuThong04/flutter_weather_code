// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// Chuyển JSON thành Weather
Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather', // class được check
      json,
      ($checkedConvert) {
        final val = Weather(
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()), // Chuyển temperature thành số thập phân
          weatherCode:
              $checkedConvert('weathercode', (v) => (v as num).toDouble()), // Chuyển weathercode thành số thập phân
        );
        return val;
      },
      fieldKeyMap: const {'weatherCode': 'weathercode'}, // Dùng để liên kết tên biến trong code Dart với tên key trong JSON 
    );
