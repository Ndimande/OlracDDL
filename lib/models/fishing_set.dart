import 'package:database_repo/database_repo.dart';
import 'package:meta/meta.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';

import 'sea_bottom_type.dart';

class FishingSet extends Model {
  /// When the set started
  DateTime startedAt;

  /// When the set ended
  DateTime endedAt;

  /// GPS Start Location
  Location startLocation;

  /// GPS End Location
  Location endLocation;

  /// Sea bottom depth and unit
  int seaBottomDepth;
  LengthUnit seaBottomDepthUnit;

  /// Sea bottom type
  SeaBottomType seaBottomType;

  String minimumHookSize;

  /// Number of hooks
  int hooks;

  /// Number of traps
  int traps;

  /// Number of lines used
  int linesUsed;

  /// Additional notes
  String notes;

  /// The parent trip's ID
  int tripID;

  /// The species targeted
  Species targetSpecies;

  /// Phase of the moon
  MoonPhase moonPhase;

  /// The cloud type
  CloudType cloudType;

  /// The cloud cover
  CloudCover cloudCover;

  /// The sea condition
  SeaCondition seaCondition;

  /// The fishing method used
  FishingMethod fishingMethod;

  /// The set creation time
  DateTime createdAt;

  FishingSet({
    int id,
    @required this.startedAt,
    this.endedAt,
    @required this.startLocation,
    this.endLocation,
    @required this.seaBottomDepth,
    @required this.seaBottomDepthUnit,
    @required this.seaBottomType,
    @required this.minimumHookSize,
    this.hooks,
    this.traps,
    this.linesUsed,
    this.notes,
    @required this.tripID,
    @required this.targetSpecies,
    @required this.moonPhase,
    @required this.cloudType,
    @required this.cloudCover,
    @required this.seaCondition,
    @required this.fishingMethod,
    this.createdAt,
  })  : assert(startedAt != null),
        assert(startLocation != null),
        assert(seaBottomDepth != null),
        assert(seaBottomDepthUnit != null),
        assert(seaBottomType != null),
        assert(targetSpecies != null),
        assert(moonPhase != null),
        assert(cloudType != null),
        assert(cloudCover != null),
        assert(seaCondition != null),
        assert(fishingMethod != null),
        super(id: id);

  bool get isActive => endedAt == null;

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      // Times
      'started_at': startedAt == null ? null : startedAt.toUtc().toIso8601String(),
      'ended_at': endedAt == null ? null : endedAt.toUtc().toIso8601String(),
      // Locations
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'end_latitude': endLocation == null ? null : endLocation.latitude,
      'end_longitude': endLocation == null ? null : endLocation.longitude,
      // Others
      'sea_bottom_depth': seaBottomDepth,
      'sea_bottom_depth_unit': seaBottomDepthUnit.toString(),
      'minimum_hook_size': minimumHookSize,
      'hooks': hooks,
      'traps': traps,
      'lines_used': linesUsed,
      'notes': notes,
      // Related
      'trip_id': tripID,
      'sea_bottom_type_id': seaBottomType.id,
      'target_species_id': targetSpecies.id,
      'moon_phase_id': moonPhase.id,
      'cloud_type_id': cloudType.id,
      'cloud_cover_id': cloudCover.id,
      'sea_condition_id': seaCondition.id,
      'fishing_method_id': fishingMethod.id,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'startedAt': startedAt == null ? null : startedAt.toUtc().toIso8601String(),
      'endedAt': endedAt == null ? null : endedAt.toUtc().toIso8601String(),
      'startLatitude': startLocation.latitude,
      'startLongitude': startLocation.longitude,
      'endLatitude': endLocation.latitude,
      'endLongitude': endLocation.longitude,
      'seaBottomDepth': seaBottomDepth,
      'seaBottomDepthUnit': seaBottomDepthUnit.toString(),
      'minimumHookSize': minimumHookSize,
      'hooks': hooks,
      'traps': traps,
      'lines_used': linesUsed,
      'notes': notes,
      'tripID': tripID,
      'targetSpeciesID': targetSpecies.id,
      'moonPhaseID': moonPhase.id,
      'cloudTypeID': cloudType.id,
      'cloudCoverID': cloudCover.id,
      'seaConditionID': seaCondition.id,
      'fishingMethodID': fishingMethod.id,
    };
  }
}
