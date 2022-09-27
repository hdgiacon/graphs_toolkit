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
    if (connectedFrom != null && value != null && value2 != null) {
      assert(
        (connectedFrom.length == value.length &&
            connectedFrom.length == value2.length),
        'connectedFrom, value and value 2 lists must have the same number of elements',
      );

      for (int k = 0; k < connectedFrom.length; k++) {
        var newEdge = Edge(
          destiny: newVertex,
          value: value[k],
        );

        var newEdgeToAcestor = Edge(
          destiny: connectedFrom[k],
          value: value2[k],
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
