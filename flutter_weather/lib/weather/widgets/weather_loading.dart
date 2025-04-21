// Nhập thư viện giao diện Flutter
import 'package:flutter/material.dart';

// Widget hiển thị trong lúc đang tải dữ liệu thời tiết
class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key}); // Constructor không tham số

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Lấy chủ đề hiện tại để dùng style chữ

    return Column(
      mainAxisSize: MainAxisSize.min, // Chiều cao chỉ chiếm đúng nội dung
      children: [
        // Emoji biểu tượng thời tiết
        const Text('⛅', style: TextStyle(fontSize: 64)),

        // Thông báo đang tải dữ liệu
        Text(
          'Loading Weather', // Đang tải thời tiết
          style: theme.textTheme.headlineSmall, // Dùng style đồng bộ với giao diện chung
        ),

        // Vòng tròn xoay (loading indicator)
        const Padding(
          padding: EdgeInsets.all(16), // Khoảng cách xung quanh indicator
          child: CircularProgressIndicator(), // Hiển thị vòng tròn tải
        ),
      ],
    );
  }
}
