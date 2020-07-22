import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/species.dart';

class RetainedCatch extends Model {
  RetainedCatch({
    int id,
    this.greenWeight,
    this.greenWeightUnit,
    this.individuals,
    this.location,
    this.createdAt,
    this.species,
    this.fishingSetID,
  }) : super(id: id);

  int greenWeight;
  WeightUnit greenWeightUnit;
  int individuals;
  Location location;
  DateTime createdAt;
  Species species;
  int fishingSetID;

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'green_weight': greenWeight,
      'green_weight_unit': greenWeightUnit,
      'individuals': individuals,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'species_id': species.id,
      'fishing_set_id': fishingSetID,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'greenWeight': greenWeight,
      'greenWeightUnit': greenWeightUnit.toString(),
      'individuals': individuals,
      'location': location.toMap(),
      'speciesID': species.id,
      'fishingSetID': fishingSetID,
    };
  }
}
