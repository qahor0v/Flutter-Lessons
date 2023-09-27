class UserModel {
  String name;
  String email;
  String password;
  int age;
  String job;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.job,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      job: json['job'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "job": job,
        "age": age,
      };
}
