import 'package:database_repo/database_repo.dart';

class SeaCondition extends Model {
  String name;
  String namePortuguese;
  DateTime createdAt;
  String imageString;
  String portugueseName;

  SeaCondition({
    int id,
    this.name,
    this.portugueseName,
    this.createdAt,
    this.imageString,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'portuguese_name': portugueseName, 
      'image_string': imageString,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'portugueseName': portugueseName, 
      'imageString': imageString,
      'name': name,
      'namePortuguese' : namePortuguese,
      'createdAt': createdAt,
    };
  }
}
