// GENERATED CODE - DO NOT MODIFY BY HAND
// File này tự dộng sinh ra - không nên sửa trực tiếp
part of 'weather_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


//Chuyển JSON thành WeatherState
WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate( 
      'WeatherState', // Tên của class được check
      json,
      ($checkedConvert) {
        final val = WeatherState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$WeatherStatusEnumMap, v) ??
                  WeatherStatus.initial), // Nếu không có giá trị thì xài giá trị mặc định initial
          temperatureUnits: $checkedConvert(
              'temperature_units',
              (v) =>
                  $enumDecodeNullable(_$TemperatureUnitsEnumMap, v) ??
                  TemperatureUnits.celsius), // Mặc định là độ C nếu không xác định được đơn vị
          weather: $checkedConvert(
              'weather',
              (v) => v == null
                  ? null
                  : Weather.fromJson(v as Map<String, dynamic>)), // Chuyển từ JSON sang Weather
        );
        return val;
      },
      // Dùng để liên kết tên biến trong code với tên key trong JSON nếu tên của cả hai không giống nhau
      fieldKeyMap: const {'temperatureUnits': 'temperature_units'},
    );
// Chuyển WeatherState thành JSON
Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'status': _$WeatherStatusEnumMap[instance.status]!, // Chuyển Enum sang String
      'weather': instance.weather.toJson(), // Chuyển đối tượng weather thành JSON
      'temperature_units':
          _$TemperatureUnitsEnumMap[instance.temperatureUnits]!, // Chuyển Enum sang string
    };


// Enum status sang String cho JSON
const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};
// Enum nhiệt độ sang String 
const _$TemperatureUnitsEnumMap = {
  TemperatureUnits.fahrenheit: 'fahrenheit',
  TemperatureUnits.celsius: 'celsius',
};
