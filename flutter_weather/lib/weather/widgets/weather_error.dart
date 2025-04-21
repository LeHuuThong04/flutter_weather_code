// Nhập thư viện giao diện Flutter
import 'package:flutter/material.dart';

// Widget hiển thị khi có lỗi xảy ra khi tải dữ liệu thời tiết
class WeatherError extends StatelessWidget {
  const WeatherError({super.key}); // Constructor không tham số

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Lấy chủ đề giao diện hiện tại

    return Column(
      mainAxisSize: MainAxisSize.min, // Chiều cao chỉ đủ chứa nội dung
      children: [
        // Emoji diễn tả lỗi hoặc "không thấy gì"
        const Text('🙈', style: TextStyle(fontSize: 64)),

        // Thông báo lỗi cho người dùng
        Text(
          'Something went wrong!', // Có lỗi xảy ra!
          style: theme.textTheme.headlineSmall, // Dùng kiểu chữ từ theme để đồng bộ giao diện
        ),
      ],
    );
  }
}
