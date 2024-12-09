class RoutesModel {
  final List<Route> routes;

  RoutesModel({required this.routes});

  factory RoutesModel.fromJson(Map<String, dynamic> json) {
    return RoutesModel(
      routes: (json['routes'] as List)
          .map((routeJson) => Route.fromJson(routeJson))
          .toList(),
    );
  }
}

class Route {
  final int distanceMeters;
  final String duration;
  final String encodedPolyline;

  Route({
    required this.distanceMeters,
    required this.duration,
    required this.encodedPolyline,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      distanceMeters: json['distanceMeters'],
      duration: json['duration'],
      encodedPolyline: json['polyline']['encodedPolyline'],
    );
  }
}
