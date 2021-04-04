class AppUser {
  final String login;
  final String password;
  final String name;
  final String registrationDate;

  AppUser({this.login, this.password, this.name, this.registrationDate});

  AppUser.fromJson(Map<String, dynamic> json)
      : this(
          login: json['login'],
          password: json['password'],
          name: json['name'],
          registrationDate: json['registrationDate'],
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'login': this.login,
        'password': this.password,
        'name': this.name,
        'registrationDate': this.registrationDate,
      };
}
