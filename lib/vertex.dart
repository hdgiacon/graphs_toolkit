part of 'graph.dart';

///
class Vertex {
  double value;

  List<Edge> edgesList;

  /// null for root
  Vertex? ancestor;
  bool visited;

  String? label;

  Vertex({
    this.value = 0,
    List<Edge>? edgesList,
    this.label,
    this.ancestor,
    this.visited = false,
  }) : edgesList = edgesList ?? [];

  ///
  List<Vertex> get verticesOfEdgesList {
    final lista = <Vertex>[];

    for (var edge in edgesList) {
      lista.add(edge.destiny);
    }

    return lista;
  }
}
