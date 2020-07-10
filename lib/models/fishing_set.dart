import 'package:database_repo/database_repo.dart';
import 'package:meta/meta.dart';
import 'package:olrac_utils/olrac_utils.dart';

class FishingSet extends Model {
  int id;

  /// When the set started
  DateTime startedAt; //

  /// When the set ended
  DateTime endedAt; //

  /// GPS Start Location
  Location startLocation;

  /// GPS End Location
  Location endLocation;

  int seaBottomDepth;

  int minimumHookSize;

  int hooks;

  int traps;

  int linesUsed;

  String notes;

  int tripId;

  int targetSpeciesId;

  int moonPhaseId;

  int cloudTypeId;

  int cloudCoverId;

  int seaConditionId;

  int fishingMethodId;

  // List<SetEvent> setEvents;

  //**********************************
  // DO WE NEED to also add image here;
  //**********************************

  DateTime createdAt;

  FishingSet({
    this.id,
    @required this.startedAt,
    this.endedAt,
    @required this.startLocation,
    this.endLocation,
    @required this.seaBottomDepth,
    @required this.minimumHookSize,
    @required this.hooks,
    @required this.traps,
    @required this.linesUsed,
    @required this.notes,
    this.tripId,
    this.targetSpeciesId,
    this.moonPhaseId,
    this.cloudTypeId,
    this.cloudCoverId,
    this.seaConditionId,
    this.fishingMethodId,
    this.createdAt,
  })  : assert(startedAt != null),
        super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'started_at': startedAt == null ? null : startedAt.toUtc().toIso8601String(),
      'ended_at': endedAt == null ? null : endedAt.toUtc().toIso8601String(),
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'end_latitude': endLocation.latitude,
      'end_longitude': endLocation.longitude,
      'sea_bottom_depth': seaBottomDepth,
      'minimum_hook_size': minimumHookSize,
      'hooks': hooks,
      'traps': traps,
      'lines_used': linesUsed,
      'notes': notes,
      'trip_id': tripId,
      'target_species_id': targetSpeciesId,
      'moon_phase_id': moonPhaseId,
      'cloud_type_id': cloudTypeId,
      'cloud_cover_id': cloudCoverId,
      'sea_condition_id': seaConditionId,
      'fishing_method_id': fishingMethodId,
    };
  }
}
