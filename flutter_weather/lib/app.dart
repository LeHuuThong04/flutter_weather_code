import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather/view/weather_page.dart' show WeatherPage;
import 'package:flutter_weather/weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherCondition, WeatherRepository;

// Widget chính khởi tạo app
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      // Cung cấp WeatherRepository cho toàn app
      create: (_) => WeatherRepository(),
      // Hủy repository khi không cần thiết nữa
      dispose: (repository) => repository.dispose(),
      child: BlocProvider(
        // Tạo WeatherCubit để quản lý state
        create: (context) => WeatherCubit(context.read<WeatherRepository>()),
        child: const WeatherAppView(), // Giao diện chính của app
      ),
    );
  }
}

// Giao diện chính của app
class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy màu chủ đạo dựa vào trạng thái thời tiết hiện tại
    final seedColor = context.select(
      (WeatherCubit cubit) => cubit.state.weather.toColor,
    );

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0, // AppBar phẳng
        ),
        // Tạo chủ đề màu từ seedColor (động)
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        // Sử dụng font chữ Rajdhani từ Google Fonts
        textTheme: GoogleFonts.rajdhaniTextTheme(),
      ),
      home: const WeatherPage(), // Trang chính hiển thị thời tiết
    );
  }
}

// Mở rộng class Weather để lấy màu tương ứng với điều kiện thời tiết
extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.yellow; // Trời nắng
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent; // Có tuyết
      case WeatherCondition.cloudy:
        return Colors.blueGrey; // Có mây
      case WeatherCondition.rainy:
        return Colors.indigoAccent; // Có mưa
      case WeatherCondition.unknown:
        return Colors.cyan; // Không rõ
    }
  }
}
