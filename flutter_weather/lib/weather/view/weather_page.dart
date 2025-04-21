// Nhập các thư viện cần thiết
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/search.dart'; // Trang tìm kiếm thành phố
import 'package:flutter_weather/settings/settings.dart'; // Trang cài đặt
import 'package:flutter_weather/weather/weather.dart'; // Bloc + models về thời tiết

// Widget không có trạng thái để hiển thị thông tin thời tiết
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Cho phép nội dung hiển thị phía sau AppBar
      appBar: AppBar(
        actions: [
          // Nút settings ở góc phải AppBar
          IconButton(
            icon: const Icon(Icons.settings), // Icon bánh răng
            onPressed: () => Navigator.of(context).push<void>(
              SettingsPage.route(), // Điều hướng đến trang cài đặt
            ),
          ),
        ],
      ),
      body: Center(
        // BlocBuilder lắng nghe thay đổi từ WeatherCubit
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            // Sử dụng cú pháp switch expression để hiển thị widget tương ứng với trạng thái
            return switch (state.status) {
              WeatherStatus.initial => const WeatherEmpty(), // Trạng thái khởi tạo, chưa có dữ liệu
              WeatherStatus.loading => const WeatherLoading(), // Đang tải dữ liệu
              WeatherStatus.failure => const WeatherError(), // Gặp lỗi khi lấy dữ liệu
              WeatherStatus.success => WeatherPopulated(
                  weather: state.weather, // Dữ liệu thời tiết
                  units: state.temperatureUnits, // Đơn vị nhiệt độ
                  onRefresh: () {
                    // Gọi lại API để làm mới dữ liệu
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                ),
            };
          },
        ),
      ),
      // Nút tìm kiếm nổi (FloatingActionButton) ở góc phải bên dưới
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'), // Icon kính lúp
        onPressed: () async {
          // Điều hướng đến trang tìm kiếm và chờ kết quả trả về
          final city = await Navigator.of(context).push(SearchPage.route());
          
          // Kiểm tra nếu context đã bị hủy
          if (!context.mounted) return;

          // Gọi hàm fetchWeather để lấy dữ liệu thời tiết theo tên thành phố
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
