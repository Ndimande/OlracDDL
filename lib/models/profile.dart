import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/providers/database.dart';
import 'package:sqflite/sqflite.dart';

class Profile {
  static const jsonKey = 'user';

  Profile({
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

  static Future<Profile> get() async {
    final Database db = DatabaseProvider().database;

    final List<Map<String, dynamic>> results = await db.query('json', where: "key = '$jsonKey'");

    if (results.isEmpty) {
      return null;
    }
    final resultJson = jsonDecode(results.first['json'] as String);

    return Profile(
        uuid: resultJson['uuid'] as String,
        username: resultJson['username'] as String,
        email: resultJson['email'] as String,
        country: Country.fromMap(resultJson['country'] as Map));
  }

  static Future<void> set(Profile profile) async {
    assert(profile != null);

    final Database db = DatabaseProvider().database;
    final Map<String, dynamic> userMap = {
      'uuid': profile.uuid,
      'username': profile.username,
      'email': profile.email,
      'country': profile.country.toMap(),
    };

    final String json = jsonEncode(userMap);

    await db.insert('json', {'key': jsonKey, 'json': json});
  }
}
