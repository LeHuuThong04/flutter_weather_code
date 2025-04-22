// Import thư viện để hỗ trợ so sánh các đối tượng dễ dàng
import 'package:equatable/equatable.dart';
// Import thư viện để hỗ trợ chuyển đổi JSON
import 'package:json_annotation/json_annotation.dart';

// Tự động tạo file `weather.g.dart` chứa code sinh ra để xử lý JSON
part 'weather.g.dart';

// Enum đại diện cho các điều kiện thời tiết
enum WeatherCondition {
  clear,   // Trời quang
  rainy,   // Trời mưa
  cloudy,  // Trời nhiều mây
  snowy,   // Trời tuyết
  unknown, // Không xác định
}

// Annotation để chỉ định lớp này hỗ trợ (de)serialize JSON
@JsonSerializable()
class Weather extends Equatable {
  // Constructor chính với các thuộc tính bắt buộc
  const Weather({
    required this.location,     // Vị trí
    required this.temperature,  // Nhiệt độ
    required this.condition,    // Trạng thái thời tiết
  });

  // Factory constructor để tạo đối tượng Weather từ JSON
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json); // Gọi hàm sinh tự động

  // Chuyển đối tượng Weather thành Map JSON
  Map<String, dynamic> toJson() => _$WeatherToJson(this); // Gọi hàm sinh tự động

  // Các thuộc tính
  final String location;
  final double temperature;
  final WeatherCondition condition;

  // Ghi đè props để so sánh các đối tượng Weather theo giá trị
  @override
  List<Object> get props => [location, temperature, condition];
}
