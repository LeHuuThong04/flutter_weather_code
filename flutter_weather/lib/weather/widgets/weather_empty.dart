// Nhập thư viện Flutter UI
import 'package:flutter/material.dart';

// Widget hiển thị khi chưa có dữ liệu thời tiết (trạng thái ban đầu)
class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key}); // Constructor không có tham số

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Lấy thông tin chủ đề giao diện hiện tại (màu, font, v.v.)

    return Column(
      mainAxisSize: MainAxisSize.min, // Chiều cao vừa đủ với nội dung
      children: [
        // Biểu tượng thành phố (emoji)
        const Text('🏙️', style: TextStyle(fontSize: 64)),

        // Dòng chữ nhắc người dùng chọn thành phố
        Text(
          'Please Select a City!',
          style: theme.textTheme.headlineSmall, // Sử dụng kiểu chữ từ theme để đồng bộ giao diện
        ),
      ],
    );
  }
}
