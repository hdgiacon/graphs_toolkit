part of 'graph.dart';

class NotOrientedGraph extends _Graph {
  NotOrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  // TODO: connectedFrom ser uma lista? olhar nas definições de grafo (ver o que aconetece com ancestor)

  @override
  void addVertex({
    required Vertex newVertex,
    Vertex? connectedFrom,
    double value = 0,
    double value2 = 0,
  }) {
    if (connectedFrom != null) {
      final newEdge = Edge(
        destiny: newVertex,
        value: value,
      );

      final newEdgeToAcestor = Edge(
        destiny: connectedFrom,
        value: value2,
      );

      newVertex.edgesList.add(newEdgeToAcestor);

      connectedFrom.edgesList.add(newEdge);
    }

    vertices.add(newVertex);
  }

  ///
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont ~/ 2;
  }
}
