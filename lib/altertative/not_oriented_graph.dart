part of 'graph.dart';

class NotOrientedGraph extends Graph {
  NotOrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  // TODO: da pra fazer override, precisa fazer pra orientado
  // TODO: connectedFrom ser uma lista? olhar nas definições de grafo (ver o que aconetece com ancestor)
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

      final newEdgeToAcestor = Edge(
        destiny: connectedFrom,
        value: value2,
      );

      newVertex.edgesList.add(newEdgeToAcestor);

      connectedFrom.edgesList.add(newEdge);
    }

    vertices.add(newVertex);
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
}
