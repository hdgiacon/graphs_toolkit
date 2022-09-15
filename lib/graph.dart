import 'dart:collection';

part "vertex.dart";
part "edge.dart";

class Graph {
  List<Vertex> vertices;
  List<Edge> edges;

  Graph({
    required this.vertices,
    required this.edges,
  });

  /// Calculates distance to all reachable vertices from a vertex of origin s
  ///
  ///
  void bfs(Vertex initialNode) {
    initialNode.visited = true;

    final queueWait = ListQueue<Vertex>();
    queueWait.addLast(initialNode);

    Vertex dequeuedVertex;

    while (queueWait.isNotEmpty) {
      dequeuedVertex = queueWait.removeFirst();

      for (var vertex in dequeuedVertex.edgesList) {
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

  /// returns the vertex with the greatest distance
  ///
  /// Input must be a tree
  Vertex largest() {
    assert(
        (isTree()), 'to find the largest vertex, the graph needs to be a tree');

    var largest = Vertex(edgesList: []);

    largest.value = 0;

    for (var vertex in vertices) {
      if (vertex.value >= largest.value) {
        largest = vertex;
      }
    }

    return largest;
  }

  ///
  bool isConnected() {
    for (var vertex in vertices) {
      if (!vertex.visited) {
        return false;
      }
    }

    return true;
  }

  ///
  bool isTree() {
    if (edges.length != vertices.length - 1) {
      return false;
    }

    bfs(vertices[0]);

    return isConnected();
  }

  @override
  String toString() {
    var graphString = "";

    for (var vertex in vertices) {
      graphString =
          "$graphString(${vertex.label ?? vertex.value.toString()}) - [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.label ?? adj.value.toString()})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }
}
