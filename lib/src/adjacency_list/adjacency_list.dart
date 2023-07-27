part of '../interfaces/graph_base.dart';

///
typedef AdjacencyListT = List<Vertex>;

/// <Vertex,ConnectedFrom,EdgeWeigth>
typedef _WaitType = (Vertex, Vertex, num?);

abstract class AdjacencyList implements _GraphBase {
  ///
  final AdjacencyListT adjacencyList;

  ///
  final Type graphType;

  ///
  AdjacencyList._({required this.adjacencyList, required this.graphType});

  ///
  factory AdjacencyList.oriented({AdjacencyListT? adjacencyList}) {
    return _OrientedListGraph(adjacencyList: adjacencyList);
  }

  ///
  factory AdjacencyList.notOriented({AdjacencyListT? adjacencyList}) {
    return _NotOrientedListGraph(adjacencyList: adjacencyList);
  }

  /// List used for the `addVertex` method, in which a `vertex` not yet created is added here
  final _waitList = <_WaitType>[];

  bool _searchWaitList(String label) {
    try {
      _waitList.firstWhere((element) => element.$1.label == label);

      return true;
    } on StateError catch (_) {
      return false;
    }
  }

  @override
  Vertex getV(String label) {
    return adjacencyList.firstWhere(
      (element) => element.label == label,
    );
  }

  @override
  Vertex get first => adjacencyList.first;

  @override
  Vertex get last => adjacencyList.last;

  void _setInitialValues() {
    for (var vertex in adjacencyList) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  @override
  void bfs(Vertex initialNode) {
    _setInitialValues();

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
    _setInitialValues();

    var time = 0;

    for (var vertex in adjacencyList) {
      if (!vertex.visited) {
        _dfsVisit(vertex, time, false);
      }
    }
  }

  int _dfsVisit(Vertex actual, int time, bool cicleSearch) {
    time += 1;
    actual.value = time;
    actual.visited = true;

    for (var vertexAdj in actual.verticesOfEdgesList) {
      if (!vertexAdj.visited) {
        vertexAdj.ancestor = actual;
        time = _dfsVisit(vertexAdj, time, cicleSearch);
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
  bool hasCycle() {
    _setInitialValues();

    var time = 0;

    for (var vertex in adjacencyList) {
      if (!vertex.visited) {
        if (_dfsVisit(vertex, time, true) == -1) {
          _setInitialValues();

          return true;
        }
      }
    }

    _setInitialValues();

    return false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is AdjacencyList &&
        listEquals(other.adjacencyList, adjacencyList);
  }

  @override
  int get hashCode => adjacencyList.hashCode;
}
