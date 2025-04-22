import 'dart:async'; // Hỗ trợ bất đồng bộ (Future, Stream)
import 'dart:convert'; // Hỗ trợ chuyển đổi dữ liệu JSON

import 'package:http/http.dart' as http; // Dùng để gửi HTTP request
import 'package:open_meteo_api/open_meteo_api.dart'; // Import các model Location, Weather

// Ngoại lệ xảy ra khi không thể gửi request tìm kiếm vị trí
class LocationRequestFailure implements Exception {}

// Ngoại lệ xảy ra khi không tìm thấy kết quả phù hợp với vị trí cần tìm
class LocationNotFoundFailure implements Exception {}

// Ngoại lệ xảy ra khi không thể gửi request lấy dữ liệu thời tiết
class WeatherRequestFailure implements Exception {}

// Ngoại lệ xảy ra khi không có dữ liệu thời tiết trong kết quả trả về
class WeatherNotFoundFailure implements Exception {}

/// Client API dùng để tương tác với Open Meteo API: https://open-meteo.com
class OpenMeteoApiClient {
  // Constructor chính, có thể truyền vào httpClient riêng (dùng cho test/mock)
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // URL cơ bản của API lấy thời tiết
  static const _baseUrlWeather = 'api.open-meteo.com';

  // URL cơ bản của API tìm kiếm địa điểm
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  // HTTP client dùng để gọi API
  final http.Client _httpClient;

  /// Tìm kiếm một vị trí theo tên.
  /// Gọi API: GET /v1/search?name={query}&count=1
  Future<Location> locationSearch(String query) async {
    // Tạo URL tìm kiếm
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'}, // chỉ lấy 1 kết quả
    );

    // Gửi HTTP GET request
    final locationResponse = await _httpClient.get(locationRequest);

    // Nếu không thành công (statusCode != 200), ném ngoại lệ
    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    // Giải mã dữ liệu JSON
    final locationJson = jsonDecode(locationResponse.body) as Map;

    // Nếu không có key 'results' → ném lỗi
    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    // Ép kiểu sang danh sách
    final results = locationJson['results'] as List;

    // Nếu danh sách rỗng → không có vị trí nào
    if (results.isEmpty) throw LocationNotFoundFailure();

    // Trả về Location đầu tiên
    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  /// Lấy thông tin thời tiết hiện tại theo vị trí (tọa độ).
  /// Gọi API: GET /v1/forecast?latitude=...&longitude=...&current_weather=true
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    // Tạo URL request thời tiết
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    // Gửi request đến API
    final weatherResponse = await _httpClient.get(weatherRequest);

    // Nếu lỗi, ném ngoại lệ
    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    // Giải mã JSON trả về
    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    // Nếu không có current_weather → ném lỗi
    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    // Lấy dữ liệu thời tiết hiện tại
    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;

    // Trả về đối tượng Weather
    return Weather.fromJson(weatherJson);
  }

  /// Đóng client HTTP khi không sử dụng nữa để tránh rò rỉ bộ nhớ
  void close() {
    _httpClient.close();
  }
}
