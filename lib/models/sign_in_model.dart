class SignInModel {
  String f_name;
  String l_name;
  String email;
  String password;
  String password_confirmation;
  String m_token;
  String mac;
  String c_name;
  SignInModel(
      {required this.f_name,
      required this.l_name,
      required this.email,
      required this.password,
      required this.password_confirmation,
      required this.m_token,
      required this.mac,
      required this.c_name});
  factory SignInModel.fromJson(Map<String, dynamic> user) => SignInModel(
      f_name: user['f_name'],
      l_name: user['l_name'],
      email: user['email'],
      password: user['password'],
      password_confirmation: user['password_confirmation'],
      m_token: user['m_token'],
      mac: user['mac'],
      c_name: user['c_name']);
}
