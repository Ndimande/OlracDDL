import 'package:database_repo/database_repo.dart';

class Trip extends Model {
  String uuid;
  DateTime createdAt;

  DateTime startDatetime;
  String startLatitude;
  String startLongitude;

  DateTime endDatetime;
  String endLatitude;

  String endLongitude;

  String skipperName;
  String crewMembersJson;
  String notes;
  DateTime uploadedAt;

  int portId;

  Trip(
      {int id,
      this.uuid,
      this.createdAt,
      this.startDatetime,
      this.startLatitude,
      this.startLongitude,
      this.endDatetime,
      this.endLatitude,
      this.endLongitude,
      this.skipperName,
      this.crewMembersJson,
      this.notes,
      this.uploadedAt,
      this.portId})
      : super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'uuid': uuid,
      'createdAt': createdAt,
      'startDatetime': startDatetime,
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endDatetime': endDatetime,
      'endLatitude': endLatitude,
      'endLongitude': endLongitude,
      'skipperName': skipperName,
      'crewMembersJson': crewMembersJson,
      'notes': notes,
      'uploadedAt': uploadedAt,
      'portId': portId,
    };
  }
}
