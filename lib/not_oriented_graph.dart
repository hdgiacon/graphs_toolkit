part of 'graph.dart';

///
class NotOrientedGraph extends _Graph {
  NotOrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  ///
  @override
  void addVertex({
    required Vertex newVertex,
    List<Vertex>? connectedFrom,
    List<double>? value,
    List<double>? value2,
  }) {
    if (connectedFrom != null) {
      value = value ?? [];
      value2 = value2 ?? [];

      assert(
        (value.length == value2.length),
        'value and value2 lists must have the same number of elements',
      );

      for (int k = 0; k < connectedFrom.length; k++) {
        var newEdge = Edge(
          destiny: newVertex,
          value: value.isEmpty ? 0.0 : value[k],
        );

        var newEdgeToAcestor = Edge(
          destiny: connectedFrom[k],
          value: value2.isEmpty ? 0.0 : value2[k],
        );

        newVertex.edgesList.add(newEdgeToAcestor);

        connectedFrom[k].edgesList.add(newEdge);
      }
    }

    vertices.add(newVertex);
  }

  /// get the number of edges on a Not Oriented Graph
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont ~/ 2;
  }
}
