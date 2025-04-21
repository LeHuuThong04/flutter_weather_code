  import 'package:equatable/equatable.dart';
  import 'package:json_annotation/json_annotation.dart';
  // Thêm thư viện thời tiết nhưng ẩn lớp Weather bên trong để tránh bị trùng tên
  import 'package:weather_repository/weather_repository.dart' hide Weather;
  import 'package:weather_repository/weather_repository.dart'
      as weather_repository; // dùng cái này để truy cập weather_repository.Weather rõ ràng khi cần dùng Weather gốc

  part 'weather.g.dart';

  // Liệt kê loại đơn vị
  enum TemperatureUnits { fahrenheit, celsius }

  // Thêm phương thức mở rộng kiểm tra nhanh đơn vị
  extension TemperatureUnitsX on TemperatureUnits {
    bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
    bool get isCelsius => this == TemperatureUnits.celsius;
  }

  // Đại diện cho một giá trị nhiệt độ
  @JsonSerializable()
  class Temperature extends Equatable {
    const Temperature({required this.value}); // Nhận giá trị nhiệt độ

    // Tạo đối tượng nhiệt độ từ dữ liệu JSON
    factory Temperature.fromJson(Map<String, dynamic> json) =>
        _$TemperatureFromJson(json);

    final double value;
    // Chuyển Temperature thành JSON để lưu trữ
    Map<String, dynamic> toJson() => _$TemperatureToJson(this);

    // Giúp Equatable so sánh theo giá trị
    @override
    List<Object> get props => [value];
  }

  // Đại diện cho thông tin thời tiết
  @JsonSerializable()
  class Weather extends Equatable {
    // Nhận giá trị thời tiết
    const Weather({
      required this.condition,
      required this.lastUpdated,
      required this.location,
      required this.temperature,
    });
    // Tạo các đối tượng từ dữ liệu JSON
    factory Weather.fromJson(Map<String, dynamic> json) =>
        _$WeatherFromJson(json);
    //Tạo đối tượng Weather từ dữ liệu gốc trong weather_repository.
    factory Weather.fromRepository(weather_repository.Weather weather) {
      return Weather(
        condition: weather.condition,
        lastUpdated: DateTime.now(), // Cập nhật time đến hiện tại
        location: weather.location,
        temperature: Temperature(value: weather.temperature),
      );
    }
    // Tạo một đối tượng mặc định khi chưa có dữ liệu
    static final empty = Weather(
      condition: WeatherCondition.unknown,
      lastUpdated: DateTime(0),
      temperature: const Temperature(value: 0),
      location: '--',
    );

    final WeatherCondition condition; // Trạng thái thời tiết
    final DateTime lastUpdated; // Ngày cập nhật
    final String location; // Vị trí
    final Temperature temperature; //  Nhiệt độ

    // Giúp Equatable so sánh dựa theo 4 tiêu chí
    @override
    List<Object> get props => [condition, lastUpdated, location, temperature];

    // Chuyển từ Weather sang JSON
    Map<String, dynamic> toJson() => _$WeatherToJson(this);
    //Tạo bản sao của Weather, có thể thay đổi vài thuộc tính
    Weather copyWith({
      WeatherCondition? condition,
      DateTime? lastUpdated,
      String? location,
      Temperature? temperature,
    }) {
      return Weather(
        condition: condition ?? this.condition,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        location: location ?? this.location,
        temperature: temperature ?? this.temperature,
      );
    }
  }