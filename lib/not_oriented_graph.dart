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
    List<String>? connectedTo,
    List<double>? weigth,
    List<double>? weigth2,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((vertex, connectedFrom) {
        if (vertex.label == newVertex.label) {
          connectedFrom.addEdge(connectedTo: newVertex);
          newVertex.addEdge(connectedTo: connectedFrom);
          return true;
        }
        return false;
      });
    }

    vertices.add(newVertex);

    if (connectedTo != null) {
      final connectedToAsTriple = [
        for (var k = 0; k < connectedTo.length; k++)
          Tuple3(connectedTo[k], weigth?[k], weigth2?[k])
      ];

      for (var t in connectedToAsTriple) {
        if (getV(t.item1) is NullVertex) {
          _waitList[Vertex(label: t.item1)] = newVertex;
        } else {
          newVertex.addEdge(
            connectedTo: getV(t.item1),
            weigth: t.item2,
          );

          getV(t.item1).addEdge(
            connectedTo: newVertex,
            weigth: t.item3,
          );
        }
      }
    }
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
