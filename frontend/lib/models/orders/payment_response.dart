class PaymentResponse {
  final String checkoutUrl;
  final String paymentId;

  PaymentResponse({required this.checkoutUrl, required this.paymentId});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      checkoutUrl: json['checkoutUrl'],
      paymentId: json['paymentId'],
    );
  }
}
