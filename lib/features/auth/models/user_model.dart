class UserModel {
  final String email;
  final String password;
  final String? token;

  UserModel({required this.email, required this.password, this.token});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'token': token,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'],
    password: json['password'],
    token: json['token'],
  );
}
