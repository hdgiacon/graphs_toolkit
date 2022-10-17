import 'dart:collection' show ListQueue;
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:tuple/tuple.dart' show Tuple3, Tuple4;

part "edge.dart";
part "vertex.dart";

part 'not_oriented_graph.dart';
part 'oriented_graph.dart';

/// <Vertex,ConnectedFrom,Weigth,Weigth2>
typedef _WaitType = Tuple4<Vertex, Vertex, num?, num?>;

/// graph model for oriented and not oriented, with the common functionalities to both
abstract class _Graph {
  final List<Vertex> vertices;

  /// <Vertex,ConnectedFrom,Weigth,Weigth2>
  final _waitList = <_WaitType>[];

  _Graph._({required this.vertices});

  /// model function that is overridden for both oriented and not oriented graphs
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num>? weigth,
  });

  ///
  void excludeVertex({required String vertexLabel});

  /// returns a vertex from vertices list according to its label
  Vertex getV(String label) {
    return vertices.firstWhere(
      (element) => element.label == label,
      orElse: () => NullVertex(),
    );
  }

  /// set the graph to its initial values
  void _setInitialValues() {
    for (var vertex in vertices) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  ///
  Vertex get first => vertices.first;

  ///
  Vertex get last => vertices.last;

  /// Calculates distance to all reachable vertices from a vertex of origin
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

  ///
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

extension _Tuple4Extension on _WaitType {
  Vertex get vertex => item1;
  Vertex get connectedFrom => item2;
  num? get weigth => item3;
  num? get weigth2 => item4;
}

extension _Tuple3Extension on Tuple3<String, num?, num?> {
  String get connectedTo => item1;
  num? get weigth => item2;
  num? get weigth2 => item3;
}
