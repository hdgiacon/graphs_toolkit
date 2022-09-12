import 'dart:collection';

class Graph {
  List<Vertex> vertices;

  Graph({
    required this.vertices,
  });

  void bfs(Vertex initialNode) {
    initialNode.visited = true;

    final queueWait = ListQueue<Vertex>();
    queueWait.addLast(initialNode);

    Vertex dequeuedVertex;

    while (queueWait.isNotEmpty) {
      dequeuedVertex = queueWait.removeFirst();

      for (var vertex in dequeuedVertex.edgesList!) {
        if (!vertex.visited!) {
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
  String toString({bool printAdjMatrix = false}) {
    if (printAdjMatrix) {
      return "matrix";
    } else {
      var graphString = "";

      for (var vertex in vertices) {
        graphString =
            "$graphString(${vertex.label ?? vertex.value.toString()}) - [";

        for (var adj in vertex.edgesList!) {
          graphString = "$graphString (${adj.label ?? adj.value.toString()})";
        }

        graphString = "$graphString ]\n";
      }

      return graphString.substring(0, graphString.length - 1);
    }
  }
}

// olhar geeks for geeks
class Vertex {
  int value;

  List<Vertex>? edgesList;
  List<List<bool>>? edgesMatrix;

  Vertex? ancestor; // null for root
  bool? visited;

  String? label;

  Vertex({
    this.value = 0,
    this.label,
    this.edgesList,
    this.edgesMatrix,
    this.ancestor,
    this.visited = false,
  }) : assert(
          (edgesList != null || edgesMatrix != null),
          'One of the parameters must be provided',
        );
}
