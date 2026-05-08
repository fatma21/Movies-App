class MyUserModel {
  static const String collectionName = 'users';
  String id;
  String name;
  String email;
  String phone;
  String avatar;
  List<String> wishlist;
  List<String> history;

  MyUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    this.wishlist = const [],
    this.history = const [],
  });

  MyUserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    avatar: json['avatar'] ?? '',
    wishlist: List<String>.from(json['wishlist'] ?? []),
    history: List<String>.from(json['history'] ?? []),
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "avatar": avatar,
      "wishlist": wishlist,
      "history": history,
    };
  }

  MyUserModel copyWith({
    String? name,
    String? phone,
    String? avatar,
  }) {
    return MyUserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
}