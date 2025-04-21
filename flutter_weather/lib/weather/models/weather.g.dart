// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// Chuyển JSON thành Temperature
Temperature _$TemperatureFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Temperature', // Tên class được check
      json,
      ($checkedConvert) {
        final val = Temperature(
          value: $checkedConvert('value', (v) => (v as num).toDouble()), // Đảm bảo giá trị luôn là số thập phân
        );
        return val;
      },
    );
// Chuyển Temperature thành JSON
Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

// Chuyển JSON thành Weather
Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather', // Tên class được check
      json,
      ($checkedConvert) {
        final val = Weather(
           // Chuyển giá trị condition từ String sang Enum WeatherCondition
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          // Chuyển chuỗi ngày sang dối tượng Datetime
          lastUpdated: $checkedConvert(
              'last_updated', (v) => DateTime.parse(v as String)),
          // Gán location thành chuỗi
          location: $checkedConvert('location', (v) => v as String),
          // Tạo temperature từ JSON con
          temperature: $checkedConvert('temperature',
              (v) => Temperature.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      // Dùng để liên kết tên biến trong code với tên key trong JSON nếu tên của cả hai không giống nhau
      fieldKeyMap: const {'lastUpdated': 'last_updated'},
    );
// Chuyển Weather sang JSON
Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'location': instance.location,
      'temperature': instance.temperature.toJson(),
    };
// Enum Condition sang JSON
const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};
