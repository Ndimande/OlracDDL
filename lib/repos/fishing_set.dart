import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/cloud_cover.dart';
import 'package:olracddl/repos/cloud_type.dart';
import 'package:olracddl/repos/fishing_method.dart';
import 'package:olracddl/repos/moon_phase.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/species.dart';

class FishingSetRepo extends DatabaseRepo<FishingSet> {
  FishingSetRepo() : super(tableName: 'fishing_sets', database: DatabaseProvider().database);

  @override
  Future<FishingSet> fromDatabaseResult(Map<String, dynamic> result) async {
    final MoonPhase moonPhase = await MoonPhaseRepo().find(result['moon_phase_id']);
    final CloudType cloudType = await CloudTypeRepo().find(result['cloud_type_id']);
    final CloudCover cloudCover = await CloudCoverRepo().find(result['cloud_cover_id']);
    final FishingMethod fishingMethod = await FishingMethodRepo().find(result['fishing_method_id']);
    final Species targetSpecies = await SpeciesRepo().find(result['target_species_id']);
    final SeaCondition seaCondition = await SeaConditionRepo().find(result['sea_condition_id']);
    final LengthUnit lengthUnit = lengthUnitFromString(result['sea_bottom_depth_unit']);
    final Location startLocation = Location(latitude: result['start_latitude'], longitude: result['start_longitude']);
    final Location endLocation = Location(latitude: result['end_latitude'], longitude: result['end_longitude']);

    return FishingSet(
      id: result['id'],
      // Timestamps
      createdAt: DateTime.parse(result['created_at']),
      startedAt: DateTime.parse(result['started_at']),
      endedAt: DateTime.parse(result['ended_at']),
      // Locations
      startLocation: startLocation,
      endLocation: endLocation,
      // others
      seaBottomDepth: result['sea_bottom_depth'],
      seaBottomDepthUnit: lengthUnit,
      minimumHookSize: result['minimum_hook_size'],
      hooks: result['hooks'],
      traps: result['traps'],
      linesUsed: result['lines_used'],
      notes: result['notes'],
      // related
      tripId: result['trip_id'],
      moonPhase: moonPhase,
      cloudType: cloudType,
      cloudCover: cloudCover,
      fishingMethod: fishingMethod,
      targetSpecies: targetSpecies,
      seaCondition: seaCondition,
    );
  }
}
