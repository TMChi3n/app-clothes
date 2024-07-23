class Config {
  static const String apiLocalhost = '10.0.2.2:8080';
  static const String loginUrl = '/api/v1/auth/login';
  static const String registerUrl = '/api/v1/auth/register';
  static const String getProductByidProduct = "/api/v1/product/get/:id";
  static const String getAllProduct = '/api/v1/product/get';
  static const String updateProfileUser = '/api/v1/auth/update-profile/';
  static const String getProfileUser = '/api/v1/auth/profile/';
  static const String getOderByUser = '/api/v1/order/user/';
  static const String forgotPassword = '/api/v1/auth/forgot-password';
  static const String changePassword = '/api/v1/auth/change-password';
  static const String getCart = '/api/v1/cart/get';
  static const String getFavorite = '/api/v1/favorite/user';
  static const String clearCart = '';
  static const String addCart = '/api/v1/cart/add';
}
