import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

class RoutingMachineService {
  final OSRMManager osrmManager;
  RoutingMachineService({
    required this.osrmManager,
  });

  List<LngLat> convertPointsToWay(List<LatLng> points) {
    List<LngLat> waypoints =
        points.map((e) => LngLat(lng: e.longitude, lat: e.latitude)).toList();
    return waypoints;
  }

  Future<Road> getRoad(List<LngLat> waypoints) async {
    final road = await osrmManager.getRoad(
      waypoints: waypoints,
      roadType: RoadType.foot,
      geometries: Geometries.geojson,
      steps: true,
      language: Languages.en,
    );
    return road;
  }

  Future<List<RoadInstruction>> getInstructions(Road road) async {
    final instructions = await osrmManager.buildInstructions(road);
    return instructions;
  }

  // get string instruction grouped for each destination
  Future<List<List<String>>> getInstructionsByDestinations(Road road) async {
    final instructions = await osrmManager.buildInstructions(road);
    final splittedInstructions = instructions
        .map((e) => e.instruction)
        .splitAfter((e) => e.contains('destination'))
        .toList();
    return splittedInstructions;
  }

  Future<List<String>> getDestinations(Road road) async {
    final destinations = road.roadLegs
        .expand((e) => e)
        .map((e) => e.destinations)
        .whereNotNull()
        .toList();
    return destinations;
  }

// get polyline that can be used in flutter_map
  List<LatLng>? getPolyline(Road road) {
    final polyline = road.polyline?.map((e) => LatLng(e.lat, e.lng)).toList();
    return polyline;
  }
}
