import 'package:flutter/material.dart';
import 'package:olracddl/http/get_cloud_covers.dart';
import 'package:olracddl/http/get_sea_bottom_types.dart';
import 'package:olracddl/http/get_vessels.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/repos/cloud_cover.dart';
import 'package:olracddl/repos/cloud_type.dart';
import 'package:olracddl/repos/moon_phase.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/repos/vessel.dart';

import 'http/get_cloud_types.dart';
import 'http/get_moon_phases.dart';
import 'http/get_ports.dart';
import 'http/get_sea_conditions.dart';
import 'http/get_species.dart';
import 'models/port.dart';
import 'repos/port.dart';

 Future<void> storeVesselNames() async{
  final List<Vessel>  vesselNames = await getVessels();
  for(final Vessel vesselName in vesselNames){
      await VesselRepo().store(vesselName);
  }

}

// ignore: avoid_void_async
Future<void> storePorts() async{
 final List<Port>  portNames = await getPorts();
 for(final Port portName in portNames){
  await PortRepo().store(portName);
 }

}

// ignore: avoid_void_async
void storeCloudCovers() async{
 final List<CloudCover>  cloudCoversNames = await getCloudCovers();
 for(final CloudCover cloudCoverName in cloudCoversNames){
  await CloudCoverRepo().store(cloudCoverName);
 }
}

// ignore: avoid_void_async
void storeCloudTypes() async{
 final List<CloudType>  cloudTypesNames = await getCloudTypes();
 for(final CloudType cloudTypesName in cloudTypesNames){
  await CloudTypeRepo().store(cloudTypesName);
 }

}

// ignore: avoid_void_async
Future<void> storeMoonPhases() async{
 final List<MoonPhase>  moonPhaseNames = await getMoonPhases();
 for(final MoonPhase moonPhaseName in moonPhaseNames){
  await MoonPhaseRepo().store(moonPhaseName);
 }
}

// ignore: avoid_void_async
Future<void> storeSeaBottomTypes() async{
 final List<SeaBottomType>  seaBottomTypesNames = await getSeaBottomTypes();
 for(final SeaBottomType seaBottomTypesName in seaBottomTypesNames){
  await SeaBottomTypeRepo().store(seaBottomTypesName);
 }
}

// ignore: avoid_void_async
Future<void> storeSeaConditions() async{
 final List<SeaCondition>  seaConditionNames = await getSeaConditions();
 for(final SeaCondition seaConditionName in seaConditionNames){
  await SeaConditionRepo().store(seaConditionName);
 }
}

// ignore: avoid_void_async
Future<void> storeSpecies() async{
 final List<Species>  speciesNames = await getSpecies();
 for(final Species speciesName in speciesNames){
  await SpeciesRepo().store(speciesName);
 }
}





