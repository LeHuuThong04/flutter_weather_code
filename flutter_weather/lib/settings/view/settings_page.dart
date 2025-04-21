// Nhập các thư viện cần thiết
import 'package:flutter/material.dart'; // Thư viện Flutter UI
import 'package:flutter_bloc/flutter_bloc.dart'; // Thư viện Bloc để quản lý trạng thái
import 'package:flutter_weather/weather/weather.dart'; // Thư viện chứa WeatherCubit và các class liên quan

// Tạo một StatelessWidget tên là SettingsPage
class SettingsPage extends StatelessWidget {
  // Constructor ẩn (private constructor) cho trang SettingsPage
  const SettingsPage._();

  // Hàm route để tạo route điều hướng tới trang SettingsPage
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingsPage._(), // Trả về instance của trang SettingsPage
    );
  }

  @override
  Widget build(BuildContext context) {
    // Trả về widget Scaffold (khung màn hình cơ bản)
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')), // Thanh tiêu đề
      body: ListView( // Dùng ListView để có thể cuộn nội dung
        children: <Widget>[
          // BlocBuilder để rebuild phần giao diện khi trạng thái thay đổi
          BlocBuilder<WeatherCubit, WeatherState>(
            // buildWhen chỉ build lại khi temperatureUnits thay đổi
            buildWhen: (previous, current) =>
                previous.temperatureUnits != current.temperatureUnits,
            builder: (context, state) {
              return ListTile(
                title: const Text('Temperature Units'), // Tiêu đề mục cài đặt
                isThreeLine: true, // Cho phép subtitle hiển thị nhiều dòng
                subtitle: const Text(
                  'Use metric measurements for temperature units.', // Mô tả mục cài đặt
                ),
                trailing: Switch( // Nút gạt để đổi đơn vị nhiệt độ
                  value: state.temperatureUnits.isCelsius, // Trạng thái hiện tại (Celsius hoặc không)
                  onChanged: (_) => context.read<WeatherCubit>().toggleUnits(), // Gọi hàm toggleUnits() để thay đổi đơn vị
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
