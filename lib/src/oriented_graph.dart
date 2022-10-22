part of 'graph.dart';

class OrientedGraph extends _Graph {
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
  OrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  /// Add a new vertex to the graph
  ///
  /// if it has adjacents, their `labels` can be passed in `connectedTo`
  /// if such vertices have not yet been created, they will be stored in a waiting list until their declaration occurs,
  /// edges will be created automatically
  /// ```
  ///
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
  /// myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['x']);
  /// myGraph.addVertex(newVertex: Vertex(label: 'x'));
  ///
  ///
  /// ```
  /// The weight of the edges can be passed on `edgeWeight`
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x'],
  ///      edgeWeigth: [1, 2]);
  /// ```
  /// The values ​​are processed positionally, so:
  /// ```
  ///   | u |--1-->| v |
  ///   | u |--2-->| x |
  ///
  /// ```
  /// Weights can take on `null` values explicitly
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x'],
  ///      edgeWeigth: [1, null]);
  /// ```
  /// So
  /// ```
  ///   | u |--1-->| v |
  ///   | u |----->| x |
  /// ```
  /// Or omitting the `null` value at the end
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x', 'y'],
  ///      edgeWeigth: [1]);  // will be [1, null, null]
  ///
  ///   | u |--1-->| v |
  ///   | u |----->| x |
  ///
  ///
  /// ```
  ///
  /// May have edges that leave a vertex and arrive at it.
  /// ```
  ///   | u |----->| u |
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

    newVertex.vertexType = super.runtimeType;
    vertices.add(newVertex);

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

        newVertex.connectedFrom.add(element.connectedFrom);

        return true;
      }
      return false;
    });
  }

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

  /// removes a vertex by its `label` along with the edges that arrived at it from its adjacent ones
  @override
  void excludeVertex({required String vertexLabel}) {
    getV(vertexLabel).connectedFrom.forEach((vertex) {
      vertex.excludeEdge(destinyLabel: vertexLabel);
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

  /// A oriented graph is strongly connected if for every pair of `vertices(u, v)`, `v` is accessible from `u`
  /// ```
  ///   | u |---->| v |
  ///     ^       / |
  ///     |     /   |
  ///     |  </    \|/
  ///   | x |<----| y |
  ///
  ///
  /// ```
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

  /// If its a oriented and acyclic graph
  /// ```
  ///
  /// | v |----->| u |<-----| t |
  ///              ^          ^
  ///              |          |
  ///              |          |
  ///            | w |      | x |
  ///
  ///
  /// ```
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

  /// Show the graph in ajacencies list mode, `null` values ​​are not shown
  /// ```
  ///   myGraph.print();
  ///
  ///   (1) -----> (2)
  ///       -----> (3)
  ///
  ///   (2)
  ///
  ///   (3) -----> (3)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue -> `(label,value)`
  /// ```
  ///   myGraph.print(vertexValue: true);
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
  ///   myGraph.print(edgeWeigth: true);
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
