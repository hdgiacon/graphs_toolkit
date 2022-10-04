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

  @override
  void addVertexTunned({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<double>? value,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((element) {
        if (element.vertex.label == newVertex.label) {
          element.connectedFrom.addEdge(connectedTo: newVertex);
          newVertex.addEdge(connectedTo: element.connectedFrom);
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
          _waitList.add(_WaitListElement(
            vertex: Vertex(label: connectedTo[k]),
            connectedFrom: newVertex,
          ));
        } else {
          newVertex.addEdge(
            connectedTo: getV(connectedTo[k]),
            value: value.isEmpty ? 0.0 : value[k],
          );

          getV(connectedTo[k]).addEdge(
            connectedTo: newVertex,
            value: value.isEmpty ? 0.0 : value[k],
          );
        }
      }
    }
  }
}
