class CustomUser {
  final String? name;
  final String? phone;

  String? get userName => name ?? "USER";
  String? get getPhone => phone ?? '';

  CustomUser({this.name,this.phone});


}