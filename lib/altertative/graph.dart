import 'dart:collection';

part "vertex.dart";
part "edge.dart";

part 'oriented_graph.dart';
part 'not_oriented_graph.dart';

// comum às duas classes, não pode ser instanciada
class Graph {
  List<Vertex> vertices;

  Graph._({required this.vertices});

  void bfs(Vertex initialNode) {
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

///
/*
class Graph {
  List<Vertex> vertices;
  bool isOriented;

  Graph({
    List<Vertex>? vertices,
    this.isOriented = false,
  }) : vertices = vertices ?? [];

  void addVertex({
    required Vertex newVertex,
    Vertex? connectedFrom,
    double value = 0,
    double value2 = 0,
  }) {
    if (connectedFrom != null) {
      final newEdge = Edge(
        destiny: newVertex,
        value: value,
      );

      if (!isOriented) {
        final newEdgeToAcestor = Edge(
          destiny: connectedFrom,
          value: value2,
        );

        newVertex.edgesList.add(newEdgeToAcestor);
      }

      connectedFrom.edgesList.add(newEdge);
    }

    vertices.add(newVertex);
  }

  void bfs(Vertex initialNode) {
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

  /// returns the vertex with the greatest distance
  ///
  /// Input must be a tree
  Vertex get largest {
    assert(
        (isTree), 'to find the largest vertex, the graph needs to be a tree');

    var largest = Vertex();

    largest.value = 0;

    for (var vertex in vertices) {
      if (vertex.value >= largest.value) {
        largest = vertex;
      }
    }

    return largest;
  }

  //TODO: mudar esse algoritmo, depende do bfs pra funcionar
  ///
  bool get isConnected {
    for (var vertex in vertices) {
      if (!vertex.visited) {
        return false;
      }
    }

    return true;
  }

  ///
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont ~/ 2;
  }

  //TODO: o bug de alterar os parametros esta aqui, reformular esse getter
  ///
  /// ver se consigo mudar esse algoritmo, depende do bfs
  bool get isTree {
    if (numOfEdges != vertices.length - 1) {
      return false;
    }

    bfs(vertices[0]);

    return isConnected;
  }

  ///
  bool get isSinkhole => true;

  ///
  bool get isGenerator => true;

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
*/