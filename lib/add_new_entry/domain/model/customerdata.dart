class BusinessPartner {
  BusinessPartner({
    this.name,
    this.id,
  });

  String? name;
  String? id;

  factory BusinessPartner.fromJson(Map<String, dynamic> json) =>
      BusinessPartner(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
