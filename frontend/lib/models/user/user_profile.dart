import 'package:clothes_app/models/orders/getoder_res.dart';

class UserProfile {
  final String username;
  final String address;
  final String gender;
  final String birthday;
  final int phoneNumber;

  UserProfile({
    required this.username,
    required this.address,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json)  => UserProfile (
    username: json['username'] ?? 'Chưa điền',
    address: json['address'] ?? 'Chưa điền',
    gender: json['gender'] ?? '',
    birthday: json['birthday'] != null
        ? _formatDate(json['birthday'])
        : ' ',
    phoneNumber: json['phone_number'] ?? 0,
  );

  static String _formatDate(String? dateInput) {
    if (dateInput == null) {
      // Handle null case or invalid date format
      return ' '; // Default value or appropriate fallback
    }
    // Format date as needed
    DateTime? date = DateTime.tryParse(dateInput);
    if (date == null) {
      return 'Ngày sinh không hợp lệ';
    }
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().substring(2)}';
  }

  @override
  String toString() {
    return 'UserProfile: { username: $username, address: $address, gender: $gender, birthday: $birthday, phoneNumber: $phoneNumber }';
  }
}
