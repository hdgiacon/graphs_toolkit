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
    List<double?>? weigth,
    List<double?>? weigth2,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((element) {
        if (element.item1.label == newVertex.label) {
          element.item2.addEdge(connectedTo: newVertex, weigth: element.item3);
          newVertex.addEdge(connectedTo: element.item2, weigth: element.item4);
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
          _waitList
              .add(Tuple4(Vertex(label: t.item1), newVertex, t.item2, t.item3));
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
