class ApiEndpoints {
  static const String baseUrl =
      "http://127.0.0.1:8000/api/registrationdetails/registrationdetails";
  // ignore: library_private_types_in_public_api
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}


