class User {
  String name;
  String ident;
  String phone;
  String prefix;
  String picture;
  String recovery;
  String email;
  String role;

  User(this.phone, this.prefix);

  Map<String, dynamic> toMap() => {
        "ident": ident,
        "name": name,
        "email": email,
        "phone": phone,
        "picture": picture,
        "recovery": recovery,
        "prefix": prefix,
        "role": role,
      };

  User.fromJson(Map<dynamic, dynamic> json)
      : name = json["name"] ?? '',
        email = json["email"] ?? '',
        ident = json["_id"] ?? '',
        phone = json["phone"] ?? '',
        prefix = json["prefix"] ?? '',
        picture = json["picture"] ?? '',
        role = json["role"] ?? '',
        recovery = json["recovery"];

  // this method is used only my app call SQLite database;
  User.fromJsonLite(Map<dynamic, dynamic> json)
      : name = json["name"],
        email = json["email"],
        ident = json["ident"],
        phone = json["phone"],
        prefix = json["prefix"],
        picture = json["picture"] ?? '',
        role = json["role"] ?? '',
        recovery = json["recovery"];
}
