import 'dart:collection';

part "vertex.dart";
part "edge.dart";

part 'oriented_graph.dart';
part 'not_oriented_graph.dart';

///
class _Graph {
  List<Vertex> vertices;

  _Graph._({required this.vertices});

  ///
  void addVertex({
    required Vertex newVertex,
    Vertex? connectedFrom,
    double value = 0,
  }) {}

  ///
  void reset() {
    for (var vertex in vertices) {
      vertex
        ..visited = false
        ..ancestor = null
        ..value = 0;
    }
  }

  ///
  void bfs(Vertex initialNode) {
    // dar o reset aqui
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

  void dfs() {
    // dar o reset aqui
    var tempo = 0.0;

    for (var vertex in vertices) {
      if (!vertex.visited) {
        tempo += dfsVisit(vertex, tempo);
      }
    }
  }

  double dfsVisit(Vertex actual, double tempo) {
    tempo += 1;
    actual.value = tempo;
    actual.visited = true;

    for (var vertex in actual.verticesOfEdgesList) {
      if (!vertex.visited) {
        vertex.ancestor = actual;
        dfsVisit(actual, tempo);
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
      graphString =
          "$graphString(${vertex.label ?? vertex.value.toString()}) - [";

      for (var adj in vertex.edgesList) {
        graphString =
            "$graphString (${adj.destiny.label ?? adj.destiny.value.toString()})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }
}
