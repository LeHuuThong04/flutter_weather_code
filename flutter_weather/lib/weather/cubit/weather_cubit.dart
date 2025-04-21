import 'package:equatable/equatable.dart'; // dùng để so sánh các đối tượng dễ dàng hơn 
import 'package:flutter_weather/weather/weather.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'; // Lưu trạng thái cubit vào trong lưu trữ cục bộ để không mất state
import 'package:json_annotation/json_annotation.dart'; // Chuyển đổi từ JSON sang model và ngược lại
import 'package:weather_repository/weather_repository.dart' // import repository để gọi API thời tiết
    show WeatherRepository;

//chia nhỏ file
part 'weather_cubit.g.dart';
part 'weather_state.dart';

// Cubit quản lý trạng thái thời tiết, có khả năng lưu state vào local
class WeatherCubit extends HydratedCubit<WeatherState> {
  // Constructor WeatherCubit nhận vào repository (this._...) để lấy dữ liệu
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  // Hàm bất đồng bộ để gọi API thời tiết dựa theo tên thành phố
  Future<void> fetchWeather(String? city) async {
    // Không trả về nếu không có thành phố
    if (city == null || city.isEmpty) return;

    //Cập nhật trạng thái loading 
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      // Gọi API lấy dữ liệu trong Repository, chuyển sang model Weather local
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(city),
      );
      // Kiểm tra đơn vị nhiệt độ, chuyển đổi nếu cần
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;
      // Cập nhật lại trạng thái khi lấy thành công dữ liệu
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure)); // Nếu có lỗi sẽ ném ra trạng thái failure
    }
  }
  // Hàm bất đồng bộ làm mới dữ liệu
  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return; // Nếu không thành phải trạng thái success thì không làm gì
    if (state.weather == Weather.empty) return; // Không có weather thì bỏ qua
    try {
      // Lấy lại dữ liệu thời tiết ở location hiện tại
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(state.weather.location),
      );
      // Kiểm tra đơn vị và đổi nếu cần
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;
      // Cập nhật lại trạng thái khi lấy dữ liệu thành công
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    } on Exception {
      emit(state);// Ném lỗi nếu thất bại
    }
  }

  // Đổi đơn vị đo giữa độ C và độ F
  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    // Nếu không phải trạng thái success (chưa có dữ liệu) thì chỉ cập nhật đơn vị
    if (!state.status.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      final temperature = weather.temperature;
      // Chuyển đơn vị nhiệt độ
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();
      // Cập nhật lại trạng thái (state)
      emit(
        state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    }
  }

  // Hai hàm này giúp lưu và khôi phục trạng thái từ lưu trữ cục bộ (local storage) khi dùng HydratedBloc
  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json); // Chuyển JSON thành WeatherState

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson(); // chuyển ngược lại thành JSON
}
// Chuyển nhiệt độ
extension TemperatureConversion on double {
  double toFahrenheit() => (this * 9 / 5) + 32; // từ độ C sang F
  double toCelsius() => (this - 32) * 5 / 9; // từ độ F sang C
}