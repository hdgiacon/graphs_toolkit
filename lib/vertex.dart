part of "graph.dart";

///
class Vertex {
  double value;

  List<Vertex> edgesList;

  /// null for root
  Vertex? ancestor;
  bool visited;

  String? label;

  Vertex({
    this.value = 0,
    List<Vertex>? edgesList,
    this.label,
    this.ancestor,
    this.visited = false,
  }) : edgesList = edgesList ?? [];
}
