import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/providers/database.dart';
import 'package:sqflite/sqflite.dart';

class CurrentFishingMethod {
  static const jsonKey = 'current_fishing_method';

  CurrentFishingMethod({
    @required this.uuid,
    @required this.username,
    @required this.email,
    @required this.country,
  }) : assert(uuid != null);

  String uuid;
  String username;
  String email;
  Country country;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
    };
  }

  static Future<FishingMethod> get() async {
    final Database db = DatabaseProvider().database;

    final List<Map<String, dynamic>> results = await db.query('json', where: "key = '$jsonKey'");

    if (results.isEmpty) {
      return null;
    }
    final resultJson = jsonDecode(results.first['json'] as String);

    return FishingMethod(
        id: resultJson['id'] as int,
        createdAt: DateTime.parse(resultJson['createdAt'] as String),
        name: resultJson['name'] as String,
        svgPath: resultJson['svgPath'] as String,
        abbreviation: resultJson['abbreviation'] as String);
  }

  static Future<void> set(FishingMethod method) async {
    assert(method != null);

    final Database db = DatabaseProvider().database;
    // Delete existing record first
    await db.delete('json', where: "key = '$jsonKey'");

    final String json = jsonEncode(method.toMap());

    await db.insert('json', {'key': jsonKey, 'json': json});
  }
}
