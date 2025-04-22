import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
// Lớp vị trí đại diện cho vị trí trả về từ API
class Location {
  // Một constructor chính, được khởi tạo với trường 'required' bắt buộc điền vào
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
  // Tạo các đối tượng Location từ dữ liệu JSON
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final int id; // id địa điểm
  final String name; // tên địa điểm
  final double latitude; // vĩ độ
  final double longitude; // kinh độ
}