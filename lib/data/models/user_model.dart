class UserModel {
  final String uid;
  final String email;
  final String name;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',

    );
  }
}
