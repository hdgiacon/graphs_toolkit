import 'dart:collection' show ListQueue;
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:tuple/tuple.dart' show Tuple3;

part "edge.dart";
part "vertex.dart";

part 'not_oriented_graph.dart';
part 'oriented_graph.dart';

/// <Vertex,ConnectedFrom,EdgeWeigth>
typedef _WaitType = Tuple3<Vertex, Vertex, num?>;

/// Graph model for oriented and not oriented, with the common functionalities to both
abstract class _Graph {
  /// List containing all existing `vertices` in the graph
  final List<Vertex> vertices;

  _Graph._({required this.vertices});

  /// List used for the `addVertex` method, in which a `vertex` not yet created is added here
  final _waitList = <_WaitType>[];

  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num>? edgeWeigth,
  });

  void excludeVertex({required String vertexLabel});

  /// Returns a `vertex` from vertices list according to its label
  ///
  /// If the searched vertex is not found, returns a `NullVertex`
  Vertex getV(String label) {
    return vertices.firstWhere(
      (element) => element.label == label,
      orElse: () => NullVertex(),
    );
  }

  void _setInitialValues() {
    for (var vertex in vertices) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  /// First vertex of the list of vertices
  Vertex get first => vertices.first;

  /// Last vertex of the list of vertices
  Vertex get last => vertices.last;

  /// Breadth First Search
  ///
  /// Calculates distance to all reachable vertices from a vertex of origin
  ///
  /// Causes a side effect on the graph, generating a `breadth-first search tree`
  ///
  /// The tree is defined by the `ancestor` field at each vertex
  ///
  /// The `distance` calculated and stored in `value`
  ///
  /// `ancestor` saves the previous vertex
  ///
  /// `visited` becomes true
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

  /// Depth-first search
  ///
  /// At each vertex of the graph, explore as much as possible until going to the next unvisited vertex
  ///
  /// Causes a side effect on the graph, building a depth-first search forest
  ///
  /// Contains several depth-first search trees
  ///
  /// The `distance` calculated and stored in `value`
  ///
  /// `ancestor` saves the previous vertex
  ///
  /// `visited` becomes true
  void dfs() {
    _setInitialValues();

    var time = 0;

    for (var vertex in vertices) {
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

  /// Checks if there are any cycles in the whole graph
  ///
  /// valid for Not Oriented Graphs
  /// ```
  ///   | u |----| v |    | w |
  ///     |      / |      / |
  ///     |    /   |    /   |
  ///     |  /     |  /     |
  ///   | x |----| y |    | z |
  ///
  ///
  /// ```
  /// and Oriented Graphs
  /// ```
  ///   | u |---->| v |      | w |
  ///     ^      /> |        / ^
  ///     |    /    |      /   |
  ///     |  /     \ /  </     |
  ///   | x |<----| y |      | z |
  ///
  ///
  /// ```
  bool hasCycle() {
    _setInitialValues();

    var time = 0;

    for (var vertex in vertices) {
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

  bool _searchWaitList(String label) {
    for (var elem in _waitList) {
      if (elem.item1.label == label) {
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is _Graph && listEquals(other.vertices, vertices);
  }

  @override
  int get hashCode => vertices.hashCode;
}

extension _Tuple3Extension on _WaitType {
  Vertex get vertex => item1;
  Vertex get connectedFrom => item2;
  num? get edgeWeigth => item3;
}
