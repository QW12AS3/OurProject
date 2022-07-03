class SignInModel {
  String? id;
  String? f_name;
  String? l_name;
  String? email;
  String? password;
  String? password_confirmation;
  String? m_token;
  String? mac;
  String? c_name;
  String? profile_img;
  String? access_token;
  String? refresh_token;
  String? expire_at;
  /*
  String email;
  String password;
  String token;
  */
  String? message;
  SignInModel({
    this.id,
    this.f_name,
    this.l_name,
    this.email,
    this.password,
    this.password_confirmation,
    this.m_token,
    this.mac,
    this.c_name,
    this.message,
    this.profile_img,
    this.access_token,
    this.refresh_token,
    this.expire_at,
    /*  required this.email,
    required this.password,
    required this.token,
    */
  });
  // to convert data from json to dart object
  factory SignInModel.fromJson(Map<String, dynamic> user) => SignInModel(
        // f_name: user['f_name'],
        // l_name: user['l_name'],
        // email: user['email'],
        // password: user['password'],
        // password_confirmation: user['password_confirmation'],
        // m_token: user['token'],
        // mac: user['mac'],
        // c_name: user['c_name']
        id: user['data']['user']['id'] == null
            ? ''
            : user['data']['user']['id'],
        f_name: user['data']['user']['f_name'] == null
            ? ''
            : user['data']['user']['f_name'],
        l_name: user['data']['user']['l_name'] == null
            ? ''
            : user['data']['user']['l_name'],
        email: user['data']['user']['email'] == null
            ? ''
            : user['data']['user']['email'],
        profile_img: user['data']['user']['profile_img'] == null
            ? ''
            : user['data']['user']['profile_img'],
        access_token: user['data']['access_token'] == null
            ? ''
            : user['data']['access_token'],
        refresh_token: user['data']['refresh_token'] == null
            ? ''
            : user['data']['refresh_token'],
      );
  factory SignInModel.fromJsonWithErrors(Map<String, dynamic> user) =>
      SignInModel(message: user['message']);
  //to convert data to json
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'c_name': c_name,
        'mac': mac,
        'm_token': m_token
      };
}
