import 'package:database_repo/database_repo.dart';

class Skipper extends Model {
  String name;
  String shortName;
  String seamanId;
  DateTime createdAt;
  String firstName;
  String middleName;
  String lastName;

  Skipper({
    int id,
    this.name,
    this.shortName,
    this.seamanId,
    this.createdAt,
    this.firstName,
    this.middleName,
    this.lastName,
  }) : super(id: id);

  factory Skipper.fromMap(Map map) {
    return Skipper(
      id: map['id'] as int,
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      seamanId: map['seamanId'],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    name = '$firstName $middleName $lastName';
    shortName ='$firstName  $lastName';
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
