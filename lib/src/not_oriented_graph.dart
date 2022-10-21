part of 'graph.dart';

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
  /// The weights of both forward and back edges can be passed in `edgeWeight` and `edgeWeigthBack` respectively
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1, 2],
  ///        edgeWeigthBack: [3, 4]);
  /// ```
  /// The values ​​are processed positionally, so:
  /// ```
  ///   | u |--1--| v |
  ///   | u |--2--| x |
  ///
  ///   | v |--3--| u |
  ///   | x |--4--| u |
  /// ```
  /// Weights can take on `null` values explicitly
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1, null],
  ///        edgeWeigthBack: [3, 4]);
  /// ```
  /// So
  /// ```
  ///   | u |--1--| v |
  ///   | u |--null--| x |
  ///
  ///   | v |--3--| u |
  ///   | x |--4--| u |
  /// ```
  /// Or omitting the `null` value at the end
  /// ```
  ///   myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///        connectedTo: ['v', 'x'],
  ///        edgeWeigth: [1, 2],
  ///        edgeWeigthBack: [3]);
  ///
  ///   | u |--1--| v |
  ///   | u |--2--| x |
  ///
  ///   | v |--3--| u |
  ///   | x |--null--| u |
  ///
  ///
  /// ```
  @override
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? edgeWeigth,
    List<num?>? edgeWeigthBack,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _removeFromWaitList(newVertex);
    }

    newVertex.vertexType = NotOrientedGraph;
    vertices.add(newVertex);

    if (connectedTo != null) {
      final connectedToAsTriple = [
        for (var k = 0; k < connectedTo.length; k++)
          Tuple3(connectedTo[k], edgeWeigth?[k], edgeWeigthBack?[k])
      ];

      _connectVertices(connectedToAsTriple, newVertex);
    }
  }

  void _removeFromWaitList(Vertex newVertex) {
    _waitList.removeWhere((element) {
      if (element.vertex.label == newVertex.label) {
        element.connectedFrom
            .addEdge(connectedTo: newVertex, weigth: element.edgeWeigth);
        newVertex.addEdge(
            connectedTo: element.connectedFrom, weigth: element.edgeWeigthBack);
        return true;
      }
      return false;
    });
  }

  void _connectVertices(
      List<Tuple3<String, num?, num?>> connectedToAsTriple, Vertex newVertex) {
    for (var t in connectedToAsTriple) {
      if (getV(t.connectedTo) is NullVertex) {
        _waitList.add(Tuple4(Vertex(label: t.connectedTo), newVertex,
            t.edgeWeigth, t.edgeWeigthBack));
      } else {
        newVertex.addEdge(
          connectedTo: getV(t.connectedTo),
          weigth: t.edgeWeigth,
        );

        getV(t.connectedTo).addEdge(
          connectedTo: newVertex,
          weigth: t.edgeWeigthBack,
        );
      }
    }
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

  /// An unoriented graph is said to be connected if from one vertex it can be reached all others.
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
    if (hasCicle()) {
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
