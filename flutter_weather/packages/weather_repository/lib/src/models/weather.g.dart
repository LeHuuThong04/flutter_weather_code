// GENERATED CODE - DO NOT MODIFY BY HAND
// => ĐÂY LÀ CODE ĐƯỢC TỰ ĐỘNG TẠO RA, KHÔNG NÊN CHỈNH SỬA BẰNG TAY

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// Hàm chuyển đổi từ JSON (Map) sang đối tượng Weather
Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather', // Tên lớp đang xử lý
      json, // Dữ liệu JSON đầu vào
      ($checkedConvert) {
        // Hàm xử lý từng trường trong JSON
        final val = Weather(
          // Lấy giá trị từ JSON với key 'location' và ép kiểu String
          location: $checkedConvert('location', (v) => v as String),
          // Lấy giá trị từ JSON với key 'temperature', ép kiểu num rồi chuyển thành double
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          // Lấy giá trị từ JSON với key 'condition', chuyển chuỗi thành Enum WeatherCondition
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
        );
        return val; // Trả về đối tượng Weather
      },
    );

// Hàm chuyển đổi từ đối tượng Weather sang JSON (Map)
Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      // Lưu thuộc tính location vào JSON
      'location': instance.location,
      // Lưu thuộc tính temperature vào JSON
      'temperature': instance.temperature,
      // Lưu trạng thái thời tiết (condition) dưới dạng chuỗi (dùng ánh xạ từ enum)
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
    };

// Map ánh xạ giữa Enum WeatherCondition và chuỗi tương ứng trong JSON
const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',     // Enum clear → "clear"
  WeatherCondition.rainy: 'rainy',     // Enum rainy → "rainy"
  WeatherCondition.cloudy: 'cloudy',   // Enum cloudy → "cloudy"
  WeatherCondition.snowy: 'snowy',     // Enum snowy → "snowy"
  WeatherCondition.unknown: 'unknown', // Enum unknown → "unknown"
};
