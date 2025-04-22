import 'dart:developer';

import 'package:bloc/bloc.dart';

// Lớp quan sát tùy chỉnh kế thừa từ BlocObserver
class WeatherBlocObserver extends BlocObserver {
  const WeatherBlocObserver();// Constructor không đối số

  // Ghi đè lên bloc khi nhận một sự kiện, không xài cho cubit
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event); // Gọi hàm gốc để giữ hành vi mặc định
    log('onEvent $event'); // Ghi lại log sự kiện nhận được
  }
  // Ghi đè khi trạng thái thay đổi, xài cho cả cubit và bloc
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change); 
    log('onChange $change'); // Ghi lại log trạng thái 
  }
  // Ghi đè khi thực hiện transition
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log('onTransition $transition'); // Ghi lại log toàn bộ quá trình chuyển đổi(transition) 
  }
  // Ghi đè khi có lỗi xảy ra, xài cho cả cubit và bloc
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError $error'); // Ghi lại log lỗi
  }
}