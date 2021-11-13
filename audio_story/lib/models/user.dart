class CustomUser {
  String name;
  String phoneNumber;

  CustomUser({
    required this.name, 
    required this.phoneNumber
    });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser
    (
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String
    );
  }
}
