// Nhập các thư viện cần thiết
import 'package:flutter/foundation.dart'; // Dùng để kiểm tra nền tảng (web, mobile...)
import 'package:flutter/material.dart'; // Thư viện giao diện Flutter
import 'package:flutter_weather/app.dart'; // File chính chứa widget WeatherApp
import 'package:flutter_weather/weather_bloc_observer.dart'; // Lớp quan sát trạng thái BLoC
import 'package:hydrated_bloc/hydrated_bloc.dart'; // Dùng để lưu trạng thái BLoC
import 'package:path_provider/path_provider.dart'; // Dùng để lấy đường dẫn bộ nhớ thiết bị

void main() async {
  // Đảm bảo các plugin được khởi tạo trước khi chạy app
  WidgetsFlutterBinding.ensureInitialized();

  // Gán trình quan sát BLoC để theo dõi các thay đổi trạng thái BLoC
  Bloc.observer = const WeatherBlocObserver();

  // Khởi tạo bộ nhớ cho HydratedBloc (để lưu trạng thái BLoC)
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web // Nếu chạy trên web thì dùng bộ nhớ dành cho web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path), // Nếu không thì dùng thư mục tạm của thiết bị
  );

  // Chạy ứng dụng chính
  runApp(const WeatherApp());
}
