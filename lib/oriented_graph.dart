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
    List<String>? connectedTo,
    List<double>? value,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((vertex, connectedFrom) {
        if (vertex.label == newVertex.label) {
          connectedFrom.addEdge(connectedTo: newVertex);
          return true;
        }
        return false;
      });
    }

    vertices.add(newVertex);

    if (connectedTo != null) {
      value = value ?? [];

      for (var k = 0; k < connectedTo.length; k++) {
        if (getV(connectedTo[k]) is NullVertex) {
          _waitList[Vertex(label: connectedTo[k])] = newVertex;
        } else {
          newVertex.addEdge(
            connectedTo: getV(connectedTo[k]),
            value: value.isEmpty ? 0.0 : value[k],
          );
        }
      }
    }
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
