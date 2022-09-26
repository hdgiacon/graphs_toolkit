part of 'graph.dart';

class OrientedGraph extends Graph {
  OrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

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
}
