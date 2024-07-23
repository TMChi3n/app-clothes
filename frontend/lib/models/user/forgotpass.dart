class ForgotPassRequest {
  final String email;

  ForgotPassRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
