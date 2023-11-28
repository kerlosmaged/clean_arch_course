// this is file is like model but for the data you need to send or get in the request for the internet
class LoginRequests {
  String email;
  String password;
  LoginRequests({
    required this.email,
    required this.password,
  });
}

class ForgetRequests {
  String email;
  ForgetRequests({required this.email});
}

class RegisterRequest {
  String userName;
  String email;
  String password;
  String codeNumber;
  String phoneNumber;
  String userImage;

  RegisterRequest({
    required this.userName,
    required this.email,
    required this.password,
    required this.codeNumber,
    required this.phoneNumber,
    required this.userImage,
  });
}
