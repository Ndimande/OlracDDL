import 'package:database_repo/database_repo.dart';

class CrewMember extends Model {
  String name;
  String shortName;
  String seamanId; 
  DateTime createdAt;

  CrewMember({int id, this.name, this.shortName, this.seamanId, this.createdAt}) : super(id: id);

  factory CrewMember.fromMap(Map map) {
    return CrewMember(
      id: map['id'] as int,
      shortName: map['shortName'],
      name: map['name'],
      seamanId: map['seamanId'],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'short_name': shortName,
      'seaman_id': seamanId, 
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName, 
      'seamanId': seamanId, 
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
