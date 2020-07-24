import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/species.dart';

class DisposalRepo extends DatabaseRepo<Disposal> {
  DisposalRepo() : super(tableName: 'disposals', database: DatabaseProvider().database);

  @override
  Future<Disposal> fromDatabaseResult(Map<String, dynamic> result) async {
    final Species species = await SpeciesRepo().find(result['species_id']);

    final CatchCondition catchCondition = await CatchConditionRepo().find(result['disposal_state_id']);

    assert(species != null);
    assert(catchCondition != null);

    return Disposal(
      id: result['id'] as int,
      estimatedGreenWeight: result['estimated_green_weight'] as int,
      estimatedGreenWeightUnit: weightUnitFromString(result['estimated_green_weight_unit']),
      individuals: result['individuals'] as int,
      location: Location(latitude: result['latitude'], longitude: result['longitude']),
      species: species,
      createdAt: DateTime.parse(result['created_at']),
      disposalState: catchCondition,
      fishingSetID: result['fishing_set_id'],
    );
  }
}
