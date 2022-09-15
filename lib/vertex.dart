part of "graph.dart";

class Vertex {
  int value;

  List<Vertex> edgesList;

  Vertex? ancestor; // null for root
  bool visited;

  String? label;

  Vertex({
    this.value = 0,
    this.label,
    required this.edgesList,
    this.ancestor,
    this.visited = false,
  });
}
