import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable() // Cho phép sinh code tự động để chuyển đổi giữa JSON và đối tượng
//  Lớp đại diện cho dữ liệu thời tiết trả về từ API
class Weather {
  // Constructor chính, được khởi tạo có giá trị bắt buộc truyền vào
  const Weather({required this.temperature, required this.weatherCode});

  // Tạo đối tượng Weather từ dữ liệu JSON
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final double temperature; // Lưu nhiệt độ
  @JsonKey(name: 'weathercode') // Dùng để liên kết tên biến trong code Dart với tên key trong JSON 
  final double weatherCode; // Lưu mã thời tiết trong Dart
}