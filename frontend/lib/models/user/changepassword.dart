class ChangePasswordRequest {
  final String email;
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
