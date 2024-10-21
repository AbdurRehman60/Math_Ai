class Endpoints{
  Endpoints._();


  static const String serverURL = "http://navid978.pythonanywhere.com/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  //authenticatoions
  static const String login = 'authentication/token/obtain';
  static const String verifyOTP = 'authentication/reset';
  static const String menus = 'api/menus';


}