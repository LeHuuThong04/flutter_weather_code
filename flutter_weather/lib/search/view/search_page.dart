// Nhập thư viện Flutter UI
import 'package:flutter/material.dart';

// Tạo một StatefulWidget để người dùng có thể nhập và tìm kiếm thành phố
class SearchPage extends StatefulWidget {
  const SearchPage._(); // Constructor ẩn

  // Hàm tạo route để điều hướng đến trang SearchPage và trả về kết quả kiểu String
  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState(); // Tạo state cho SearchPage
}

// State tương ứng với SearchPage
class _SearchPageState extends State<SearchPage> {
  // Controller để quản lý nội dung trong ô nhập liệu
  final TextEditingController _textController = TextEditingController();

  // Getter để lấy nội dung người dùng đã nhập vào
  String get _text => _textController.text;

  // Giải phóng bộ nhớ khi widget bị hủy
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Search')), // Thanh tiêu đề
      body: Row( // Giao diện gồm 1 hàng ngang chứa ô nhập và nút tìm kiếm
        children: [
          Expanded( // Chiếm phần lớn chiều ngang
            child: Padding(
              padding: const EdgeInsets.all(8), // Khoảng đệm xung quanh ô nhập
              child: TextField(
                controller: _textController, // Gán controller để lấy dữ liệu nhập
                decoration: const InputDecoration(
                  labelText: 'City', // Nhãn hiển thị phía trên
                  hintText: 'Chicago', // Gợi ý trong ô nhập
                ),
              ),
            ),
          ),
          IconButton(
            key: const Key('searchPage_search_iconButton'), // Key để test
            icon: const Icon(Icons.search, semanticLabel: 'Submit'), // Icon nút tìm kiếm
            onPressed: () => Navigator.of(context).pop(_text), 
            // Khi nhấn nút -> quay về trang trước và trả về tên thành phố đã nhập
          ),
        ],
      ),
    );
  }
}
