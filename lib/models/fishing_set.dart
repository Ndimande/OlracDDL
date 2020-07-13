import 'package:database_repo/database_repo.dart';
import 'package:meta/meta.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set_event.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';

class FishingSet extends Model {
  int id;

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

  int minimumHookSize;

  /// Number of hooks
  int hooks;

  /// Number of traps
  int traps;

  /// Number of lines used
  int linesUsed;

  /// Additional notes
  String notes;

  /// The parent trip's ID
  int tripId;

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

  /// The [FishingSetEvent]s that have this as a parent
  List<FishingSetEvent> fishingSetEvents;

  /// The set creation time
  DateTime createdAt;

  FishingSet({
    this.id,
    @required this.startedAt,
    this.endedAt,
    @required this.startLocation,
    this.endLocation,
    this.seaBottomDepth,
    this.seaBottomDepthUnit,
    this.minimumHookSize,
    this.hooks,
    this.traps,
    this.linesUsed,
    this.notes,
    this.tripId,
    this.targetSpecies,
    this.moonPhase,
    this.cloudType,
    this.cloudCover,
    this.seaCondition,
    @required this.fishingMethod,
    this.createdAt,
    this.fishingSetEvents,
  })  : assert(startedAt != null),
        super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      // Times
      'started_at': startedAt == null ? null : startedAt.toUtc().toIso8601String(),
      'ended_at': endedAt == null ? null : endedAt.toUtc().toIso8601String(),
      // Locations
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'end_latitude': endLocation.latitude,
      'end_longitude': endLocation.longitude,
      // Others
      'sea_bottom_depth': seaBottomDepth,
      'sea_bottom_depth_unit': seaBottomDepthUnit.toString(),
      'minimum_hook_size': minimumHookSize,
      'hooks': hooks,
      'traps': traps,
      'lines_used': linesUsed,
      'notes': notes,
      // Related
      'trip_id': tripId,
      'target_species_id': targetSpecies.id,
      'moon_phase_id': moonPhase.id,
      'cloud_type_id': cloudType.id,
      'cloud_cover_id': cloudCover.id,
      'sea_condition_id': seaCondition.id,
      'fishing_method_id': fishingMethod.id,
    };
  }
}
