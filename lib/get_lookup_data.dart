import 'package:flutter/material.dart';
import 'package:olracddl/http/get_vessels.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/repos/vessel.dart';

import 'http/get_ports.dart';
import 'models/port.dart';
import 'repos/port.dart';

 // ignore: avoid_void_async
 void storeVesselNames() async{
  final List<Vessel>  vesselNames = await getVessels();
  for(final Vessel vesselName in vesselNames){
      await VesselRepo().store(vesselName);
  }

}

// ignore: avoid_void_async
void storePorts() async{
 final List<Port>  portNames = await getPort();
 for(final Port portName in portNames){
  await PortRepo().store(portName);
 }
 print('Port DOne !!!!!!!!!!!');

}

