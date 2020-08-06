import 'package:database_repo/database_repo.dart';

class Country extends Model {
  String name;
  String countryPortuguese;
  DateTime createdAt;
  Country({int id, this.name,this.countryPortuguese, this.createdAt}) : super(id: id);
  factory Country.fromMap(Map map) {
    return Country(
      id: map['id'] as int,
      name: map['name'],
      countryPortuguese: map['countryPortuguese'],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'country_portuguese' : countryPortuguese,
    };
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'countryPortuguese' : countryPortuguese,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}