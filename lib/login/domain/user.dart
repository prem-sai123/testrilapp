class ADUser {
  String? name;
  String? createdBy;
  String? username;
  String? password;

  ADUser({
    this.name,
    this.createdBy,
    this.username,
    this.password,
  });

  factory ADUser.fromJson(Map<String, dynamic> json) => ADUser(
    name: json["name"],
    createdBy: json["createdBy"],
    username: json["username"],
    password: json["password"],
  );
}