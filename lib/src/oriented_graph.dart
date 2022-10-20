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
    List<num?>? weigth,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _removeFromWaitList(newVertex);
    }

    newVertex.vertexType = super.runtimeType;
    vertices.add(newVertex);

    if (connectedTo != null) {
      final connectedToAsMap = {
        for (var k = 0; k < connectedTo.length; k++) connectedTo[k]: weigth?[k]
      };

      _connectVertexToNext(connectedToAsMap, newVertex);
    }
  }

  ///
  void _removeFromWaitList(Vertex newVertex) {
    _waitList.removeWhere((element) {
      if (element.vertex.label == newVertex.label) {
        element.connectedFrom
            .addEdge(connectedTo: newVertex, weigth: element.weigth);

        newVertex.connectedFrom.add(element.connectedFrom);

        return true;
      }
      return false;
    });
  }

  ///
  void _connectVertexToNext(
    Map<String, num?> connectedToAsMap,
    Vertex newVertex,
  ) {
    connectedToAsMap.forEach((connectedTo, weigth) {
      if (getV(connectedTo) is NullVertex) {
        _waitList.add(
          Tuple4(Vertex(label: connectedTo), newVertex, weigth, null),
        );
      } else {
        newVertex.addEdge(
          connectedTo: getV(connectedTo),
          weigth: weigth,
        );

        getV(connectedTo).connectedFrom.add(newVertex);
      }
    });
  }

  ///
  @override
  void excludeVertex({required String vertexLabel}) {
    getV(vertexLabel).connectedFrom.forEach((vertex) {
      vertex.edgesList.removeWhere((edge) => edge.destiny.label == vertexLabel);
    });

    vertices.removeWhere((vertex) => vertex.label == vertexLabel);
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
  bool get isStronglyConnected {
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
  bool isDAG() {
    if (hasCicle()) {
      return false;
    }

    return true;
  }

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

  ///
  String print({bool vertexValue = false, bool edgeWeigth = false}) {
    var graphString = "";

    for (var vertex in vertices) {
      graphString =
          "$graphString(${vertex.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.value) : ""})";

      for (var adj in vertex.edgesList) {
        if (vertex.edgesList.first == adj) {
          graphString =
              "$graphString --${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-> (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        } else if (vertex.edgesList.last == adj) {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-> (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""})";
        } else {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-> (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        }
      }

      graphString = "$graphString \n\n";
    }

    return graphString;
  }

  ///
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
