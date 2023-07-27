part of '../graphs_toolkit_base.dart';

typedef AdjacencyListT = List<Vertex>;

/// <Vertex,ConnectedFrom,EdgeWeigth>
typedef _WaitType = (Vertex, Vertex, num?);

abstract class _AdjacencyList implements _GraphBase {
  final AdjacencyListT adjacencyList;

  _AdjacencyList._({required this.adjacencyList});

  /// List used for the `addVertex` method, in which a `vertex` not yet created is added here
  final _waitList = <_WaitType>[];

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
  /// The values ​​are processed `positionally`, so:
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
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num>? edgeWeigth,
  });

  /// removes a vertex by its `label` along with the edges that arrived at it from its adjacent ones
  ///
  /// If the vertex is `not found`, a `log` message will be displayed.
  ///
  /// In *`run`* mode only the message will be shown, for more information about the exception and stack
  /// status (StackTrace), run in *`debug`* mode.
  void excludeVertex({required String vertexLabel});

  @override
  void bfs(Vertex initialNode) {
    setInitialValues();

    initialNode.visited = true;

    final queueWait = ListQueue<Vertex>();
    queueWait.addLast(initialNode);

    Vertex dequeuedVertex;

    while (queueWait.isNotEmpty) {
      dequeuedVertex = queueWait.removeFirst();

      for (var vertex in dequeuedVertex.verticesOfEdgesList) {
        if (!vertex.visited) {
          vertex
            ..visited = true
            ..ancestor = dequeuedVertex
            ..value = dequeuedVertex.value + 1;

          queueWait.add(vertex);
        }
      }
    }
  }

  @override
  void dfs() {
    setInitialValues();

    var time = 0;

    for (var vertex in adjacencyList) {
      if (!vertex.visited) {
        dfsVisit(vertex, time, false);
      }
    }
  }

  @override
  int dfsVisit(Vertex actual, int time, bool cicleSearch) {
    time += 1;
    actual.value = time;
    actual.visited = true;

    for (var vertexAdj in actual.verticesOfEdgesList) {
      if (!vertexAdj.visited) {
        vertexAdj.ancestor = actual;
        time = dfsVisit(vertexAdj, time, cicleSearch);
      } else if (cicleSearch && vertexAdj.visited) {
        return -1;
      }
    }

    actual.visited = true;
    time += 1;
    actual.value = time;

    return time;
  }

  @override
  Vertex get first => adjacencyList.first;

  @override
  Vertex getV(String label) {
    return adjacencyList.firstWhere(
      (element) => element.label == label,
    );
  }

  @override
  bool hasCycle() {
    setInitialValues();

    var time = 0;

    for (var vertex in adjacencyList) {
      if (!vertex.visited) {
        if (dfsVisit(vertex, time, true) == -1) {
          setInitialValues();

          return true;
        }
      }
    }

    setInitialValues();

    return false;
  }

  @override
  Vertex get last => adjacencyList.last;

  @override
  String printGraph({bool vertexValue = false, bool edgeWeigth = false});

  @override
  void setInitialValues() {
    for (var vertex in adjacencyList) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  bool _searchWaitList(String label) {
    try {
      _waitList.firstWhere((element) => element.$1.label == label);

      return true;
    } on StateError catch (_) {
      return false;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is _AdjacencyList &&
        listEquals(other.adjacencyList, adjacencyList);
  }

  @override
  int get hashCode => adjacencyList.hashCode;
}

/*

  AdjacencyList.oriented(AdjacencyListT? adjacencyList)
      : adjacencyList = adjacencyList ?? [];

  AdjacencyList.notOriented(AdjacencyListT? adjacencyList)
      : adjacencyList = adjacencyList ?? [];

  */