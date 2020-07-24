import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/marine_life.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/species.dart';

class MarineLifeRepo extends DatabaseRepo<MarineLife> {
  MarineLifeRepo() : super(tableName: 'marine_life', database: DatabaseProvider().database);

  @override
  Future<MarineLife> fromDatabaseResult(Map<String, dynamic> result) async {
    final Species species = await SpeciesRepo().find(result['species_id']);
    final CatchCondition condition = await CatchConditionRepo().find(result['condition_id']);
    print('test');


    return MarineLife(
      id: result['id'],
      estimatedWeight: result['estimated_weight'],
      estimatedWeightUnit: weightUnitFromString(result['estimated_weight_unit']),
      //individuals: result['individuals'],
      location: Location(latitude: result['latitude'], longitude: result['longitude']),
      tagNumber: result['tag_number'],
      species: species,
      fishingSetID: result['fishing_set_id'],
      condition: condition,
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
