/// University bus route + stop models. A route is one numbered line;
/// each line has an ordered list of stops.
library;

class BusStop {
  final String name;
  final String eta; // human-friendly ETA, e.g. '07:15'
  final int order;

  const BusStop({required this.name, required this.eta, required this.order});
}

class BusRoute {
  final String id;
  final String number; // e.g. '1', '2A'
  final String name; // e.g. 'Campus ↔ Talaimari'
  final String description;
  final List<BusStop> stops;

  const BusRoute({
    required this.id,
    required this.number,
    required this.name,
    required this.description,
    required this.stops,
  });
}




