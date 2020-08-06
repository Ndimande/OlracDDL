import 'package:flutter/material.dart';
import 'package:olracddl/http/get_cloud_covers.dart';
import 'package:olracddl/http/get_country.dart';
import 'package:olracddl/http/get_fishing_areas.dart';
import 'package:olracddl/http/get_fishing_methods.dart';
import 'package:olracddl/http/get_islands.dart';
import 'package:olracddl/http/get_sea_bottom_types.dart';
import 'package:olracddl/http/get_vessels.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/island.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/cloud_cover.dart';
import 'package:olracddl/repos/cloud_type.dart';
import 'package:olracddl/repos/country.dart';
import 'package:olracddl/repos/crew_member.dart';
import 'package:olracddl/repos/fishing_area.dart';
import 'package:olracddl/repos/fishing_method.dart';
import 'package:olracddl/repos/island.dart';
import 'package:olracddl/repos/moon_phase.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/repos/vessel.dart';

import 'http/get_catch_conditions.dart';
import 'http/get_cloud_types.dart';
import 'http/get_crew_members.dart';
import 'http/get_moon_phases.dart';
import 'http/get_ports.dart';
import 'http/get_sea_conditions.dart';
import 'http/get_skippers.dart';
import 'http/get_species.dart';
import 'models/catch_condition.dart';
import 'models/crew_member.dart';
import 'models/port.dart';
import 'repos/port.dart';


Future<void> storeCountries() async{
 final List<Country>  countryNames = await getCountries();
 for(final Country countryName in countryNames){
  await CountryRepo().store(countryName);
 }
}


 Future<void> storeVesselNames() async{
  final List<Vessel>  vesselNames = await getVessels();
  for(final Vessel vesselName in vesselNames){
      await VesselRepo().store(vesselName);
  }

}


Future<void> storePorts() async{
 final List<Port>  portNames = await getPorts();
 for(final Port portName in portNames){
  await PortRepo().store(portName);
 }
}


Future<void> storeCloudCovers() async{
 final List<CloudCover>  cloudCoversNames = await getCloudCovers();
 for(final CloudCover cloudCoverName in cloudCoversNames){
  await CloudCoverRepo().store(cloudCoverName);
 }
}


Future<void> storeCloudTypes() async{
 final List<CloudType>  cloudTypesNames = await getCloudTypes();
 for(final CloudType cloudTypesName in cloudTypesNames){
  await CloudTypeRepo().store(cloudTypesName);
 }

}


Future<void> storeMoonPhases() async{
 final List<MoonPhase>  moonPhaseNames = await getMoonPhases();
 for(final MoonPhase moonPhaseName in moonPhaseNames){
  await MoonPhaseRepo().store(moonPhaseName);
 }
}

Future<void> storeSeaBottomTypes() async{
 final List<SeaBottomType>  seaBottomTypesNames = await getSeaBottomTypes();
 for(final SeaBottomType seaBottomTypesName in seaBottomTypesNames){
  await SeaBottomTypeRepo().store(seaBottomTypesName);
 }
}


Future<void> storeSeaConditions() async{
 final List<SeaCondition>  seaConditionNames = await getSeaConditions();
 for(final SeaCondition seaConditionName in seaConditionNames){
  await SeaConditionRepo().store(seaConditionName);
 }
}

Future<void> storeSpecies() async{
 final List<Species>  speciesNames = await getSpecies();
 for(final Species speciesName in speciesNames){
  await SpeciesRepo().store(speciesName);
 }
}

Future<void> storeFishingAreas() async{
 final List<FishingArea>  fishingAreaNames = await getFishingAreas();
 for(final FishingArea fishingAreaName in fishingAreaNames){
  await FishingAreaRepo().store(fishingAreaName);
 }
}

// Future<void> storeFishingMethods() async{
//  final List<FishingMethod>  fishingMethodNames = await getFishingMethods();
//  for(final FishingMethod fishingMethodName in fishingMethodNames){
//   await FishingMethodRepo().store(fishingMethodName);
//  }
// }

Future<void> storeCrewMembers() async{
 final List<CrewMember>  crewMemberNames = await getCrewMembers();
 for(final CrewMember crewMemberName in crewMemberNames){
  await CrewMemberRepo().store(crewMemberName);
 }
}

Future<void> storeSkippers() async{
 final List<Skipper>  skipperNames = await getSkippers();
 for(final Skipper skipperName in skipperNames){
  await SkipperRepo().store(skipperName);
 }
}

Future<void> storeCatchConditions() async{
 final List<CatchCondition>  catchConditionNames = await getCatchConditions();
 for(final CatchCondition catchConditionName in catchConditionNames){
  await CatchConditionRepo().store(catchConditionName);
 }
}

Future<void> storeIsland() async{
 final List<Island>  islandNames = await getIslands();
 for(final Island islandName in islandNames){
  await IslandRepo().store(islandName);
 }
}






