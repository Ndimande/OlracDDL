import 'package:database_repo/database_repo.dart';

class CrewMember extends Model {
  String name;
  String firstName;
  String middleName;
  String lastName;
  String shortName;
  String seamanId;
  int islandID;
  DateTime createdAt;
  int defaultRole;
  int secondaryRole;

  CrewMember(
      {int id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.seamanId,
      this.defaultRole,
      this.secondaryRole,
      this.islandID,
      this.createdAt,
      this.name,
      this.shortName})
      : super(id: id);

  factory CrewMember.fromMap(Map map) {
    return CrewMember(
      id: map['id'] as int,
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      seamanId: map['seamanId'],
      islandID: map['islandID'],
      createdAt: DateTime.parse(map['createdAt'] as String),
      defaultRole: map['defualtRole'],
      secondaryRole: map['secondaryRole'],
    );
  }

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    name = '$firstName $middleName $lastName';
    shortName = '$firstName  $lastName';
    return {
      'name': name,
      'short_name': shortName,
      'island_id': islandID,
      'seaman_id': seamanId,
      'default_role': defaultRole,
      'secondary_role': secondaryRole,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'islandID': islandID,
      'seamanId': seamanId,
      'createdAt': createdAt.toIso8601String(),
      'defaultRole': defaultRole,
      'secondaryRole': secondaryRole,
    };
  }
}
