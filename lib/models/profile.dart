import 'dart:convert';

import 'package:olracddl/providers/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class Profile {
  static const jsonKey = 'user';

  Profile({
    this.factoryName,
    this.name,
    this.email,
    this.positionAtFactory,
    this.contactNumber,
    this.companyName,
    this.factoryAddress,
  });

  String factoryName;
  final String uuid = Uuid().v4();
  String name;
  String positionAtFactory;
  String email;
  String contactNumber;
  String companyName;
  String factoryAddress;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'factoryName': factoryName,
      'name': name,
      'positionAtFactory': positionAtFactory,
      'email': email,
      'contactNumber': contactNumber,
      'companyName': companyName,
      'factoryAddress': factoryAddress
    };
  }

  static Future<Profile> get() async {
    final Database db = DatabaseProvider().database;

    final List<Map<String, dynamic>> results = await db.query('json', where: "key = '$jsonKey'");

    if (results.isEmpty) {
      return null;
    }
    final resultJson = jsonDecode(results.first['json'] as String);

    return Profile(factoryName: resultJson['factoryName'] as String);
  }

  static Future<void> set(Profile profile) async {
    assert(profile != null);

    final Database db = DatabaseProvider().database;
    final Map<String, dynamic> userMap = {
      'factoryName': profile.factoryName,
    };

    final String json = jsonEncode(userMap);

    await db.insert('json', {'key': jsonKey, 'json': json});
  }
}
