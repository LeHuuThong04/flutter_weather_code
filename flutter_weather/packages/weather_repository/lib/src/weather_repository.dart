import 'dart:async'; // Hỗ trợ xử lý bất đồng bộ

import 'package:open_meteo_api/open_meteo_api.dart' hide Weather; // Import OpenMeteo nhưng ẩn class Weather có sẵn trong package này
import 'package:weather_repository/weather_repository.dart'; // Import model Weather và Enum WeatherCondition của bạn

// Repository dùng để lấy dữ liệu thời tiết từ API
class WeatherRepository {
  // Hàm khởi tạo, cho phép truyền client API tùy chọn
  WeatherRepository({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient(); // Nếu không truyền thì tạo một client mới

  final OpenMeteoApiClient _weatherApiClient; // Biến giữ client dùng để gọi API

  // Hàm lấy thông tin thời tiết theo tên thành phố
  Future<Weather> getWeather(String city) async {
    // Gọi API tìm vị trí theo tên thành phố
    final location = await _weatherApiClient.locationSearch(city);

    // Gọi API lấy dữ liệu thời tiết tại vị trí đã tìm được
    final weather = await _weatherApiClient.getWeather(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    // Trả về một đối tượng Weather (model của bạn) dựa trên dữ liệu lấy từ API
    return Weather(
      temperature: weather.temperature, // Nhiệt độ từ API
      location: location.name, // Tên vị trí
      condition: weather.weatherCode.toInt().toCondition, // Chuyển weatherCode (kiểu int) thành Enum WeatherCondition
    );
  }

  // Đóng kết nối khi không dùng nữa (giải phóng tài nguyên)
  void dispose() => _weatherApiClient.close();
}

// Extension giúp chuyển weatherCode (kiểu int) thành WeatherCondition enum
extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear; // Trời nắng
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy; // Trời nhiều mây/sương mù
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy; // Trời mưa/có bão
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy; // Trời tuyết
      default:
        return WeatherCondition.unknown; // Không xác định được thời tiết
    }
  }
}
