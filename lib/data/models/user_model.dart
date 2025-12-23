class UserModel {
  final String uid;
  final String email;
  final String name;
  final String imageUrl;
  final String role;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      role: data['role'] ?? 'user',

    );
  }
}
