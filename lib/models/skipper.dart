import 'package:database_repo/database_repo.dart';

class Skipper extends Model {
  String name;
  String shortName;
  String seamanId;
  DateTime createdAt;

  Skipper({
    int id,
    this.name,
    this.shortName,
    this.seamanId,
    this.createdAt,
  }) : super(id: id);

  factory Skipper.fromMap(Map map) {
    return Skipper(
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
