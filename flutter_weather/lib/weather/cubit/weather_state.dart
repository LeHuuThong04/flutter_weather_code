part of 'weather_cubit.dart';
//Trạng thái của WeatherStatus
// Có 4 trạng thái
// initial: ban đầu, loading: đang lấy dữ liệu, success: thành công, failure: thất bại
enum WeatherStatus { initial, loading, success, failure }


// Thêm các phương thức mở rộng để kiểm tra nhanh hơn
extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

//Lớp đại diện cho trạng thái của ứng dụng
@JsonSerializable() // Giúp tự động chuyển đổi sang JSON và ngược lại

//Equatable giúp so sánh hai WeatherState
final class WeatherState extends Equatable {
  // Khởi tạo mặc định nếu không truyền vào
  WeatherState({
    this.status = WeatherStatus.initial, // Mặc định là initial
    this.temperatureUnits = TemperatureUnits.celsius, // Mặc định là độ C
    Weather? weather, // Thông tin thời tiết
  }) : weather = weather ?? Weather.empty; // Nếu không có, dùng dữ liệu rỗng

  // Tạo các đối tượng từ dữ liệu JSON (dùng cho HydratedBloc)
  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);
  
  // Thuộc tính của state
  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits temperatureUnits;
  
  // Tạo bản sao của đối tượng
  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }
  
  // Chuyển WeatherState thành JSON để lưu trữ
  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  // Giúp Equatable so sánh dựa trên 3 giá trị là status,....
  @override
  List<Object?> get props => [status, temperatureUnits, weather];
}