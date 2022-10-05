import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

part "edge.dart";
part "vertex.dart";

part 'not_oriented_graph.dart';
part 'oriented_graph.dart';

/// graph model for oriented and not oriented, with the common functionalities to both
class _Graph {
  List<Vertex> vertices;

  /// <Vertex,ConnectedFrom,Weigth>
  final _waitList = <Tuple4<Vertex, Vertex, double?, double?>>[];

  _Graph._({required this.vertices});

  /// model function that is overridden for both oriented and not oriented graphs
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<double>? weigth,
  }) {}

  /// returns a vertex according to its label
  Vertex getV(String label) {
    return vertices.firstWhere(
      (element) => element.label == label,
      orElse: () => NullVertex(),
    );
  }

  /// set the graph to its initial values
  void reset() {
    for (var vertex in vertices) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  /// Calculates distance to all reachable vertices from a vertex of origin
  void bfs(Vertex initialNode) {
    reset();

    initialNode.visited = true;

    final queueWait = ListQueue<Vertex>();
    queueWait.addLast(initialNode);

    Vertex dequeuedVertex;

    while (queueWait.isNotEmpty) {
      dequeuedVertex = queueWait.removeFirst();

      //TODO: talvez o deep copy nao esta funcionando por conta disso
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
  void dfs() {
    reset();

    var tempo = 0.0;

    for (var vertex in vertices) {
      if (!vertex.visited) {
        tempo += _dfsVisit(vertex, tempo);
      }
    }
  }

  double _dfsVisit(Vertex actual, double tempo) {
    tempo += 1;
    actual.value = tempo;
    actual.visited = true;

    for (var vertex in actual.verticesOfEdgesList) {
      if (!vertex.visited) {
        vertex.ancestor = actual;
        _dfsVisit(actual, tempo);
      }
    }

    tempo += 1;

    return tempo;
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

  //TODO: criar um pra orientado e um pra não orientado, colocar opção de ter o peso das atestas ou não (peso dos vertices tambem?)
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
}
