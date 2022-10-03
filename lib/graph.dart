import 'dart:collection';

part "vertex.dart";
part "edge.dart";

part 'oriented_graph.dart';
part 'not_oriented_graph.dart';

/// graph model for oriented and not oriented, with the common functionalities to both
class _Graph {
  List<Vertex> vertices;

  final _waitList = <_WaitListElement>[];

  _Graph._({required this.vertices});

  /// model function that is overridden for both oriented and not oriented graphs
  void addVertex({
    required Vertex newVertex,
    List<Vertex>? connectedTo,
    List<double>? value,
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

  // TODO: usar map para mapear connectedTo com value?
  void addVertexTunned({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<double>? value,
  }) {}
}

class _WaitListElement {
  Vertex vertex;
  Vertex connectedFrom;

  _WaitListElement({
    required this.vertex,
    required this.connectedFrom,
  });
}
