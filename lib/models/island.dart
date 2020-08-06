import 'package:database_repo/database_repo.dart';

class Island extends Model {
  String name;
  //String islandID;
  String portugueseName;
  DateTime createdAt;

  Island({int id, this.name,this.portugueseName ,this.createdAt}) : super(id: id); //this.islandID

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
   //   'island_id': islandID,
      'portuguese_name' :portugueseName,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
     // 'islandID': islandID,
      'portugueseName' :portugueseName,
      'createdAt': createdAt,
    };
  }
}
