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
    List<num?>? weigth,
    List<num?>? weigth2,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _removeFromWaitList(newVertex);
    }

    newVertex.vertexType = NotOrientedGraph;
    vertices.add(newVertex);

    if (connectedTo != null) {
      final connectedToAsTriple = [
        for (var k = 0; k < connectedTo.length; k++)
          Tuple3(connectedTo[k], weigth?[k], weigth2?[k])
      ];

      _connectVertices(connectedToAsTriple, newVertex);
    }
  }

  ///
  void _removeFromWaitList(Vertex newVertex) {
    _waitList.removeWhere((element) {
      if (element.vertex.label == newVertex.label) {
        element.connectedFrom
            .addEdge(connectedTo: newVertex, weigth: element.weigth);
        newVertex.addEdge(
            connectedTo: element.connectedFrom, weigth: element.weigth2);
        return true;
      }
      return false;
    });
  }

  ///
  void _connectVertices(
      List<Tuple3<String, num?, num?>> connectedToAsTriple, Vertex newVertex) {
    for (var t in connectedToAsTriple) {
      if (getV(t.connectedTo) is NullVertex) {
        _waitList.add(Tuple4(
            Vertex(label: t.connectedTo), newVertex, t.weigth, t.weigth2));
      } else {
        newVertex.addEdge(
          connectedTo: getV(t.connectedTo),
          weigth: t.weigth,
        );

        getV(t.connectedTo).addEdge(
          connectedTo: newVertex,
          weigth: t.weigth2,
        );
      }
    }
  }

  //TODO: testar a exclusao de vertices
  ///
  @override
  void excludeVertex({required String vertexLabel}) {
    getV(vertexLabel).edgesList.forEach((edge) {
      getV(edge.destiny.label).edgesList.removeWhere(
          (edgeNeighbor) => edgeNeighbor.destiny.label == vertexLabel);
    });

    vertices.removeWhere((vertex) => vertex.label == vertexLabel);
  }

  /// get the number of edges on a Not Oriented Graph
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont ~/ 2;
  }

  ///
  bool get isConnected {
    bfs(first);

    for (var vertex in vertices) {
      if (!vertex.visited) {
        return false;
      }
    }

    _setInitialValues();

    return true;
  }

  ///
  bool get isTree {
    if (numOfEdges != vertices.length - 1) {
      return false;
    }

    return isConnected;
  }

  bool get isForest => true;

  bool get hasCicle => true;

  @override
  String toString() {
    var graphString = "";

    for (var vertex in vertices) {
      graphString = "$graphString(${vertex.label}) - [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.destiny.label})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }

  String print({bool vertexValue = false, bool edgeWeigth = false}) {
    var graphString = "";

    for (var vertex in vertices) {
      graphString =
          "$graphString(${vertex.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.value) : ""})";

      for (var adj in vertex.edgesList) {
        if (vertex.edgesList.first == adj) {
          graphString =
              "$graphString --${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        } else if (vertex.edgesList.last == adj) {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""})";
        } else {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        }
      }

      graphString = "$graphString \n\n";
    }

    return graphString;
  }

  num? _printNum(num? num) {
    if (num != null) {
      if (num % 1 == 0) {
        return num.toInt();
      } else {
        return num;
      }
    }
    return null;
  }
}
