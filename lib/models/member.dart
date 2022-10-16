import 'dart:convert';

class MemberModel {
  final int id;
  final String name;
  final String hometown;
  final String father;
  final String mother;
  final String? position;
  final String? contact;
  final int aimsCode;
  final String zone;
  final int? wassiyat;
  final int? role;
  MemberModel({
    required this.id,
    required this.name,
    required this.hometown,
    required this.father,
    required this.mother,
    this.position,
    this.contact,
    required this.aimsCode,
    required this.zone,
    this.wassiyat,
    this.role,
  });
  MemberModel copyWith({
    required int id,
    required String name,
    required String hometown,
    required String father,
    required String mother,
    String? position,
    String? contact,
    required int aimsCode,
    int? wassiyat,
    int? role,
    required String zone,
  }) {
    return MemberModel(
      id: id, // this.id,
      name: name, // this.name,
      hometown: hometown, // this.hometown,
      father: father, // this.father,
      mother: mother, // this.mother,
      position: position, // this.position,
      contact: contact, // this.contact,
      aimsCode: aimsCode, // this.aimsCode,
      wassiyat: wassiyat, // this.wassiyat,
      role: role, // this.role,
      zone: zone,
    );
  }

  MemberModel merge(MemberModel model) {
    return MemberModel(
      id: model.id, // this.id,
      name: model.name, // this.name,
      hometown: model.hometown, // this.hometown,
      father: model.father, // this.father,
      mother: model.mother, // this.mother,
      position: model.position, // this.position,
      contact: model.contact, // this.contact,
      aimsCode: model.aimsCode, // this.aimsCode,
      wassiyat: model.wassiyat, // this.wassiyat,
      role: model.role, // this.role,
      zone: model.zone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hometown': hometown,
      'father': father,
      'mother': mother,
      'position': position,
      'contact': contact,
      'aimsCode': aimsCode,
      'wassiyat': wassiyat,
      'role': role,
      'zone': zone,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['ID'],
      name: map['Fullname'],
      hometown: map['Hometown'],
      father: map['Father'],
      mother: map['Mother'],
      position: map['Position'],
      contact: map['Contact'],
      aimsCode: map['AimsCode'],
      wassiyat: map['Wassiyat'],
      role: map['Role'],
      zone: map['Zone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) =>
      MemberModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Member(id: $id, name: $name, hometown: $hometown, father: $father, mother: $mother, position: $position, contact: $contact, aimsCode: $aimsCode, wassiyat: $wassiyat, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemberModel &&
        other.id == id &&
        other.name == name &&
        other.hometown == hometown &&
        other.father == father &&
        other.mother == mother &&
        other.position == position &&
        other.contact == contact &&
        other.aimsCode == aimsCode &&
        other.wassiyat == wassiyat &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        hometown.hashCode ^
        father.hashCode ^
        mother.hashCode ^
        position.hashCode ^
        contact.hashCode ^
        aimsCode.hashCode ^
        wassiyat.hashCode ^
        role.hashCode;
  }
}
