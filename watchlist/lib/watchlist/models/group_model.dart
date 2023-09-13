
class GroupModel {
    String id;
    String name;
    String contacts;
    String url;
     final bool checkedNew; // Add the 'checked' field

    GroupModel({
        required this.id,
        required this.name,
        required this.contacts,
        required this.url, this.checkedNew = false, // Add the 'checked' field
    });

    factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        contacts: json["Contacts"],
        url: json["url"],
    );

 bool get checked => false;

  set checked(bool checked) {}

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Contacts": contacts,
        "url": url,
        "checked":checkedNew
    };

    // If the == operator is properly implemented
     @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel &&
        other.id == id &&
        other.url == url &&
        other.name == name &&
        other.contacts == contacts &&
        other.checked == checked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        name.hashCode ^
        contacts.hashCode ^
        checked.hashCode;
  }
}
