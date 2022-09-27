part of 'graph.dart';

///
class OrientedGraph extends _Graph {
  OrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  @override
  void addVertex({
    required Vertex newVertex,
    Vertex? connectedFrom,
    double value = 0,
  }) {
    if (connectedFrom != null) {
      final newEdge = Edge(
        destiny: newVertex,
        value: value,
      );

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

    return cont;
  }

  ///
  bool get isSinkhole => true;

  ///
  bool get isGenerator => true;
}
