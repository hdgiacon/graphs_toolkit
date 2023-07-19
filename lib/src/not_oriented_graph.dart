part of 'graphs_toolkit_base.dart';

class NotOrientedGraph extends _Graph {
  /// Type of graph in which the edges have no definite way
  /// ```
  /// | u |----| v |
  ///   |
  ///   |
  /// | w |
  /// ```
  /// can be declared without vertices:
  /// ```
  /// final myGraph = NotOrientedGraph()
  /// ```
  /// or with pre-defined vertices:
  /// ```
  /// final myGraph = NotOrientedGraph(vertices:[Vertex(label: 'u'), Vertex(label: 'v')])
  /// ```
  NotOrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  /// Add a new vertex to the graph
  ///
  /// if it has adjacents, their `labels` can be passed in `connectedTo`
  /// if such vertices have not yet been created, they will be stored in a waiting list until their declaration occurs,
  /// edges will be created automatically
  /// ```
  ///
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
  ///   myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['x']);
  ///   myGraph.addVertex(newVertex: Vertex(label: 'x'));
  ///
  ///
  /// ```
  /// The weights of both forward and back edges can be passed in `edgeWeight`
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1, 2]);
  /// ```
  /// The values ​​are processed `positionally`, so:
  /// ```
  ///   | u |--1--| v |
  ///   | u |--2--| x |
  ///
  ///   | v |--1--| u |
  ///   | x |--2--| u |
  /// ```
  /// Weights can take on `null` values explicitly
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1, null]);
  /// ```
  /// So
  /// ```
  ///   | u |--1--| v |
  ///   | u |--null--| x |
  ///
  ///   | v |--1--| u |
  ///   | x |--null--| u |
  /// ```
  /// Or omitting the `null` value at the end
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1]);
  ///
  ///   | u |--1--| v |
  ///   | u |--null--| x |
  ///
  ///   | v |--1--| u |
  ///   | x |--null--| u |
  ///
  ///
  /// ```
  @override
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? edgeWeigth,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _removeFromWaitList(newVertex);
    }

    newVertex.vertexType = NotOrientedGraph;
    vertices.add(newVertex);

    if (connectedTo != null) {
      edgeWeigth = _listFillIfNecessaryWithNull(connectedTo, edgeWeigth);

      final connectedToAsMap = {
        for (var k = 0; k < connectedTo.length; k++)
          connectedTo[k]: edgeWeigth?[k]
      };

      _connectVertices(connectedToAsMap, newVertex);
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
      if (element.vertex.label == newVertex.label) {
        element.connectedFrom
            .addEdge(connectedTo: newVertex, weight: element.edgeWeigth);
        newVertex.addEdge(
            connectedTo: element.connectedFrom, weight: element.edgeWeigth);
        return true;
      }
      return false;
    });
  }

  void _connectVertices(Map<String, num?> connectedToAsMap, Vertex newVertex) {
    for (var edge in connectedToAsMap.entries) {
      var connectedTo = edge.key;
      var edgeWeigth = edge.value;

      try {
        newVertex.addEdge(
          connectedTo: getV(connectedTo),
          weight: edgeWeigth,
        );

        getV(edge.key).addEdge(
          connectedTo: newVertex,
          weight: edgeWeigth,
        );
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

  /// Removes a vertex by its `label` along with the edges that arrived at it from its adjacent ones
  ///
  /// If the vertex is `not found`, a `log` message will be displayed.
  ///
  /// In *`run`* mode only the message will be shown, for more information about the exception and stack
  /// status (StackTrace), run in *`debug`* mode.
  @override
  void excludeVertex({required String vertexLabel}) {
    final logger = Logger();

    try {
      final edgesList = getV(vertexLabel).edgesList;

      for (var edge in edgesList) {
        edge.destiny.excludeEdge(destinyLabel: vertexLabel);
      }

      vertices.removeWhere((vertex) => vertex.label == vertexLabel);
    } on StateError catch (e, s) {
      logger.e('(Vertex $vertexLabel) not found for exclusion!!!!!!');

      log(e.message, error: e, stackTrace: s);
    } on EdgeNotFoundException catch (e, s) {
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
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

  /// List with all existing edges in the graph
  List<Edge> get getAllEdges {
    return [
      for (var vertex in vertices)
        for (var edge in vertex.edgesList) edge
    ];
  }

  /// An not oriented graph is said to be connected if from one vertex it can be reached all others.
  /// ```
  ///   | u |----| v |    | w |
  ///     |      / |      / |
  ///     |    /   |    /   |
  ///     |  /     |  /     |
  ///   | x |----| y |    | z |
  /// ```
  ///
  bool isConnected() {
    bfs(first);

    for (var vertex in vertices) {
      if (!vertex.visited) {
        _setInitialValues();

        return false;
      }
    }

    _setInitialValues();

    return true;
  }

  /// If its a not oriented, acyclic and connected graph
  /// ```
  ///
  ///       | u |-----| t |
  ///       /   \
  ///      /     \
  ///   | v |   | w |
  ///              \
  ///               \
  ///             | x |
  /// ```
  bool isTree() {
    if (hasCycle()) {
      return false;
    }

    return isConnected();
  }

  /// If its a not oriented and acyclic graph
  /// ```
  ///
  ///       | u |             | y |----| b |
  ///       /   \             /   \
  ///      /     \           /     \
  ///   | v |   | w |     | z |   | a |
  ///              \
  ///               \
  ///             | x |
  /// ```
  bool isForest() {
    if (hasCycle()) {
      return false;
    }

    return true;
  }

  @override
  String toString() {
    var graphString = "";

    for (var vertex in vertices) {
      graphString = "$graphString(${vertex.label}) -- [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.destiny.label})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }

  /// Show the graph in ajacencies list mode
  /// ```
  ///   myGraph.printGraph();
  ///
  ///   (1) ----- (2)
  ///       ----- (3)
  ///
  ///   (2) ----- (1)
  ///
  ///   (3) ----- (1)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue => `(label,value)`
  /// ```
  ///   myGraph.printGraph(vertexValue: true);
  ///
  ///   (1:5) ----- (2:4)
  ///         ----- (3:10)
  ///
  ///   (2:4) ----- (1:5)
  ///
  ///   (3:10) ----- (1:5)
  /// ```
  /// Edge weights can be shown with edgeWeight
  /// ```
  ///   myGraph.printGraph(edgeWeigth: true);
  ///
  ///   (1) --1-- (2)
  ///       --2-- (3)
  ///
  ///   (2) --5-- (1)
  ///
  ///   (3) --10-- (1)
  /// ```
  /// `null` values ​​are not shown
  @override
  String printGraph({bool vertexValue = false, bool edgeWeigth = false}) {
    var graphString = "";
    var cont = 1;

    for (var vertex in vertices) {
      // first vertex
      graphString =
          "$graphString(${vertex.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.value) : ""})";

      // first edge
      if (vertex.edgesList.isNotEmpty) {
        graphString =
            "$graphString --${edgeWeigth ? _printNum(vertex.edgesList.first.weight) ?? "-" : "-"}-- (${vertex.edgesList.isEmpty ? '' : vertex.edgesList.first.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.first.destiny.value) : ""}) \n";
      }

      while (cont < vertex.edgesList.length - 1) {
        // middle edges
        graphString =
            "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(vertex.edgesList[cont].weight) ?? "-" : "-"}-- (${vertex.edgesList[cont].destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList[cont].destiny.value) : ""})\n";

        cont++;
      }

      // last edge
      if (vertex.edgesList.isNotEmpty && vertex.edgesList.length > 1) {
        graphString =
            "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.last.weight) ?? "-" : "-"}-- (${vertex.edgesList.isEmpty ? '' : vertex.edgesList.last.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.edgesList.isEmpty ? null : vertex.edgesList.last.destiny.value) : ""})\n";
      }

      cont = 1;

      graphString = "$graphString\n";
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
