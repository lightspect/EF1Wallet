class User {
  String address;
  String password;
  String seedPhrase;
  bool isLogin;

  User(this.address, this.password, this.seedPhrase, this.isLogin);

  User.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        password = json['password'],
        seedPhrase = json['seedPhrase'],
        isLogin = json['isLogin'];

  Map<String, dynamic> toJson() => {
        'address': address,
        'password': password,
        'seedPhrase': seedPhrase,
        'isLogin': isLogin,
      };
}

User newUser = User("0xabcxxx...001", "megamanzx",
    "bird cat dog frog cow fox fish mouse chicken turtle lizard snake", false);
