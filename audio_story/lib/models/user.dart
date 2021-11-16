class CustomUser {

  String uid;
  String name;
  String phoneNumber;

  CustomUser({ required this.uid,required this.name,required this.phoneNumber});


  /*
  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser
    (
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String
    );
  }
  */
}
