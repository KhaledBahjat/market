class UserModel {
  final String name;
  final String email;
  final String id;
  UserModel({required this.name, required this.email, required this.id});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
    );
  }
  
}