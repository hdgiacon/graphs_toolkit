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
  /// The values ​​are processed positionally, so:
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
    assert(
      newVertex.runtimeType == NullVertex,
      '\n\nNullVertex should never be instantiated!!!!!!\n',
    );

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
    if (edgeWeigth != null && connectedTo!.length != edgeWeigth.length) {
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
            .addEdge(connectedTo: newVertex, weigth: element.edgeWeigth);
        newVertex.addEdge(
            connectedTo: element.connectedFrom, weigth: element.edgeWeigth);
        return true;
      }
      return false;
    });
  }

  void _connectVertices(Map<String, num?> connectedToAsMap, Vertex newVertex) {
    connectedToAsMap.forEach((connectedTo, edgeWeigth) {
      if (getV(connectedTo) is NullVertex) {
        _waitList
            .add(Tuple3(Vertex(label: connectedTo), newVertex, edgeWeigth));
      } else {
        newVertex.addEdge(
          connectedTo: getV(connectedTo),
          weigth: edgeWeigth,
        );

        getV(connectedTo).addEdge(
          connectedTo: newVertex,
          weigth: edgeWeigth,
        );
      }
    });
  }

  /// Removes a vertex by its `label` along with the edges that arrived at it from its adjacent ones
  @override
  void excludeVertex({required String vertexLabel}) {
    getV(vertexLabel).edgesList.forEach((edge) {
      edge.destiny.excludeEdge(destinyLabel: vertexLabel);
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
      graphString = "$graphString(${vertex.label}) - [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.destiny.label})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }

  /// Show the graph in ajacencies list mode, `null` values ​​are not shown
  /// ```
  ///   myGraph.print();
  ///
  ///   (1) ----- (2)
  ///       ----- (3)
  ///
  ///   (2) ----- (1)
  ///
  ///   (3) ----- (1)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue -> `(label,value)`
  /// ```
  ///   myGraph.print(vertexValue: true);
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
  ///   myGraph.print(edgeWeigth: true);
  ///
  ///   (1) --1-- (2)
  ///       --2-- (3)
  ///
  ///   (2) --5-- (1)
  ///
  ///   (3) --10-- (1)
  /// ```
  /// `null` values ​​are not shown
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
