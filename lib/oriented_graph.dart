part of 'graph.dart';

///
class OrientedGraph extends _Graph {
  OrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  ///
  @override
  void addVertex({
    required Vertex newVertex,
    List<Vertex>? connectedFrom,
    List<double>? value,
  }) {
    if (connectedFrom != null) {
      value = value ?? [];

      for (int k = 0; k < connectedFrom.length; k++) {
        var newEdge = Edge(
          destiny: newVertex,
          value: value.isEmpty ? 0.0 : value[k],
        );

        connectedFrom[k].edgesList.add(newEdge);
      }
    }

    vertices.add(newVertex);
  }

  /// get the number of edges on a Oriented Graph
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont;
  }

  ///
  bool get isSinkhole => true;

  ///
  bool get isGenerator => true;
}