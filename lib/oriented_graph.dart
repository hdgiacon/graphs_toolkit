part of 'graph.dart';

///
class OrientedGraph extends _Graph {
  OrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  ///
  @override
  void addVertex({
    required Vertex newVertex,
    List<Vertex>? connectedTo,
    List<double>? value,
  }) {
    if (connectedTo != null) {
      value = value ?? [];

      for (int k = 0; k < connectedTo.length; k++) {
        var newEdge = Edge(
          destiny: connectedTo[k],
          value: value.isEmpty ? 0.0 : value[k],
        );

        newVertex.edgesList.add(newEdge);
      }
    }

    vertices.add(newVertex);
  }

  /// get the number of edges on a Oriented Graph
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont;
  }

  ///
  bool get isSinkhole => true;

  ///
  bool get isGenerator => true;

  bool _searchWaitList(String label) {
    for (var elem in _waitList) {
      if (elem.vertex.label == label) {
        return true;
      }
    }
    return false;
  }

  @override
  void addVertexTunned({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<double>? value,
  }) {
    // se newVertex esta na lista de espera
    // retirar da lista de espera
    // adicionar na lista de vertices

    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((element) {
        if (element.vertex.label == newVertex.label) {
          element.connectedFrom.addEdge(connectedTo: newVertex);
          return true;
        }
        return false;
      });
    }

    vertices.add(newVertex);

    if (connectedTo != null) {
      value = value ?? [];

      // for indo de k = 0 ate connectedTo.length
      // se getV em connectedTo[k] não retornar um vertice
      // adicionar connectedTo[k] na lista de espera
      // se não
      // criar uma aresta entre newVertex e connectedTo[k]

      for (var k = 0; k < connectedTo.length; k++) {
        if (getV(connectedTo[k]) is NullVertex) {
          _waitList.add(_WaitListElement(
            vertex: Vertex(label: connectedTo[k]),
            connectedFrom: newVertex,
          ));
        } else {
          var newEdge = Edge(
            destiny: getV(connectedTo[k]),
            value: value.isEmpty ? 0.0 : value[k],
          );

          newVertex.edgesList.add(newEdge);
        }
      }
    }
  }
}
