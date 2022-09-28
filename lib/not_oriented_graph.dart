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
    List<Vertex>? connectedTo,
    List<double>? value,
    List<double>? value2,
  }) {
    if (connectedTo != null) {
      value = value ?? [];
      value2 = value2 ?? [];

      assert(
        (value.length == value2.length),
        'value and value2 lists must have the same number of elements',
      );

      for (int k = 0; k < connectedTo.length; k++) {
        var newEdge = Edge(
          destiny: connectedTo[k],
          value: value2.isEmpty ? 0.0 : value[k],
        );

        var newEdgeFromConnected = Edge(
          destiny: newVertex,
          value: value.isEmpty ? 0.0 : value2[k],
        );

        connectedTo[k].edgesList.add(newEdge);

        newVertex.edgesList.add(newEdgeFromConnected);
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
