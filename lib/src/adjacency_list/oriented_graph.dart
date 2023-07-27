part of '../graphs_toolkit_base.dart';

class _OrientedGraph extends AdjacencyList implements _Oriented {
  /// Type of graph in which the edges have a definite way
  /// ```
  ///   | u |<---| v |
  ///     ^
  ///     |
  ///   | w |
  /// ```
  /// can be declared without vertices:
  /// ```
  ///   final myGraph = OrientedGraph()
  /// ```
  /// or with pre-defined vertices:
  /// ```
  ///   final myGraph = OrientedGraph(vertices:[Vertex(label: 'u'), Vertex(label: 'v')])
  /// ```
  _OrientedGraph({
    List<Vertex>? adjacencyList,
  }) : super(adjacencyList: adjacencyList ?? []);

  @override
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? edgeWeigth,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _removeFromWaitList(newVertex);
    }

    newVertex.vertexType = super.runtimeType;
    adjacencyList.add(newVertex);

    if (connectedTo != null) {
      edgeWeigth = _listFillIfNecessaryWithNull(connectedTo, edgeWeigth);

      final connectedToAsMap = {
        for (var k = 0; k < connectedTo.length; k++)
          connectedTo[k]: edgeWeigth?[k]
      };

      _connectVertexToNext(connectedToAsMap, newVertex);
    }
  }

  List<num?>? _listFillIfNecessaryWithNull(
      List<String>? connectedTo, List<num?>? edgeWeigth) {
    if (edgeWeigth != null && connectedTo!.length >= edgeWeigth.length) {
      while (edgeWeigth.length != connectedTo.length) {
        edgeWeigth.add(null);
      }
    }

    return edgeWeigth;
  }

  void _removeFromWaitList(Vertex newVertex) {
    _waitList.removeWhere((element) {
      if (element.$1.label == newVertex.label) {
        element.$2.addEdge(connectedTo: newVertex, weight: element.$3);

        newVertex.connectedFrom.add(element.$2);

        return true;
      }
      return false;
    });
  }

  void _connectVertexToNext(
    Map<String, num?> connectedToAsMap,
    Vertex newVertex,
  ) {
    for (var edge in connectedToAsMap.entries) {
      var connectedTo = edge.key;
      var edgeWeigth = edge.value;

      try {
        newVertex.addEdge(
          connectedTo: getV(connectedTo),
          weight: edgeWeigth,
        );

        getV(connectedTo).connectedFrom.add(newVertex);
      } on StateError catch (_) {
        _waitList.add(
          (Vertex(label: connectedTo), newVertex, edgeWeigth),
        );
      } on EdgeAlreadyExistsException catch (e, s) {
        final logger = Logger();
        logger.e(e.cause);

        log('', error: e, stackTrace: s);
      }
    }
  }

  @override
  void excludeVertex({required String vertexLabel}) {
    final logger = Logger();

    try {
      final connectedFrom = getV(vertexLabel).connectedFrom;

      for (var vertex in connectedFrom) {
        vertex.excludeEdge(destinyLabel: vertexLabel);
      }

      adjacencyList.removeWhere((vertex) => vertex.label == vertexLabel);
    } on StateError catch (e, s) {
      logger.e('(Vertex $vertexLabel) not found for exclusion!!!!!!');

      log(e.message, error: e, stackTrace: s);
    } on EdgeNotFoundException catch (e, s) {
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  }

  @override
  int get numOfEdges {
    var cont = 0;

    for (var vertex in adjacencyList) {
      cont += vertex.edgesList.length;
    }

    return cont;
  }

  @override
  List<Edge> get getAllEdges {
    return [
      for (var vertex in adjacencyList)
        for (var edge in vertex.edgesList) edge
    ];
  }

  @override
  bool get isStronglyConnected {
    bfs(first);

    for (var vertex in adjacencyList) {
      if (!vertex.visited) {
        return false;
      }
    }

    setInitialValues();

    return true;
  }

  @override
  bool isDAG() {
    if (hasCycle()) {
      return false;
    }

    return true;
  }

  @override
  String toString() {
    var graphString = "";

    for (var vertex in adjacencyList) {
      graphString = "$graphString(${vertex.label}) -> [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.destiny.label})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }

  //TODO: criar um doc comment para print graph, mesclar oriented com not oriented e colocar na base

  /// Show the graph in ajacencies list mode
  /// ```
  ///   myGraph.printGraph();
  ///
  ///   (1) -----> (2)
  ///       -----> (3)
  ///
  ///   (2)
  ///
  ///   (3) -----> (3)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue :> `(label,value)`
  /// ```
  ///   myGraph.printGraph(vertexValue: true);
  ///
  ///   (1:5) -----> (2:4)
  ///         -----> (3:10)
  ///
  ///   (2:4)
  ///
  ///   (3:10) -----> (3:10)
  /// ```
  /// Edge weights can be shown with edgeWeight
  /// ```
  ///   myGraph.printGraph(edgeWeigth: true);
  ///
  ///   (1) --1--> (2)
  ///       --2--> (3)
  ///
  ///   (2)
  ///
  ///   (3) --8--> (3)
  /// ```
  ///
  /// `null` values ​​are not shown
  @override
  String printGraph({bool vertexValue = false, bool edgeWeigth = false}) {
    var graphString = "";
    var cont = 1;

    for (var vertex in adjacencyList) {
      // first vertex
      graphString =
          "$graphString(${vertex.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.value) : ""})";

      // first edge
      if (vertex.edgesList.isNotEmpty) {
        graphString =
            "$graphString --${edgeWeigth ? _printNum(vertex.edgesList.first.weight) ?? "-" : "-"}-> (${vertex.edgesList.isEmpty ? '' : vertex.edgesList.first.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.first.destiny.value) : ""}) \n";
      }

      while (cont < vertex.edgesList.length - 1) {
        // middle edges
        graphString =
            "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(vertex.edgesList[cont].weight) ?? "-" : "-"}-> (${vertex.edgesList[cont].destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList[cont].destiny.value) : ""}) \n";

        cont++;
      }

      // last edge
      if (vertex.edgesList.isNotEmpty && vertex.edgesList.length > 1) {
        graphString =
            "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.last.weight) ?? "-" : "-"}-> (${vertex.edgesList.isEmpty ? '' : vertex.edgesList.last.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.last.destiny.value) : ""})";
      }

      cont = 1;

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
