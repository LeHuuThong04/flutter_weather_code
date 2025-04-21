import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart' show WeatherCondition;

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final Weather weather; // Dữ liệu thời tiết
  final TemperatureUnits units; // Đơn vị đo nhiệt độ (Celsius hoặc Fahrenheit)
  final ValueGetter<Future<void>> onRefresh; // Hàm được gọi khi người dùng kéo để làm mới

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Lấy chủ đề hiện tại để áp dụng kiểu chữ
    return Stack(
      children: [
        _WeatherBackground(), // Nền gradient
        RefreshIndicator( // Widget kéo để làm mới
          onRefresh: onRefresh,
          child: Align(
            alignment: const Alignment(0, -1 / 3), // Căn giữa và dịch lên phía trên một chút
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Cho phép cuộn dù nội dung ít
              clipBehavior: Clip.none,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 48), // Khoảng cách phía trên
                  _WeatherIcon(condition: weather.condition), // Biểu tượng thời tiết
                  Text(
                    weather.location, // Tên địa điểm
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w200, // Kiểu chữ nhẹ
                    ),
                  ),
                  Text(
                    weather.formattedTemperature(units), // Nhiệt độ đã định dạng
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold, // Nổi bật nhiệt độ
                    ),
                  ),
                  Text(
                    '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                    // Hiển thị thời gian cập nhật cuối cùng
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 75.0; // Kích thước biểu tượng

  final WeatherCondition condition; // Trạng thái thời tiết

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji, // Chuyển trạng thái thành emoji
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  // Chuyển đổi trạng thái thời tiết thành emoji tương ứng
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer; // Màu nền chính từ theme
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0], // Các điểm dừng màu
            colors: [
              color,
              color.brighten(), // Làm sáng màu gốc
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  // Hàm mở rộng để làm sáng một màu
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    final alpha = a.round();
    final red = r.round();
    final green = g.round();
    final blue = b.round();
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(), // Làm sáng đỏ
      green + ((255 - green) * p).round(), // Làm sáng xanh lá
      blue + ((255 - blue) * p).round(), // Làm sáng xanh dương
    );
  }
}

extension on Weather {
  // Hàm mở rộng để định dạng nhiệt độ theo đơn vị
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
