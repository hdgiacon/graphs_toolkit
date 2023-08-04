part of '../interfaces/graph_base.dart';

class _OrientedMatrixGraph extends AdjacencyMatrix implements _Oriented {
  _OrientedMatrixGraph({
    Int64List? adjacencyMatrix,
  }) : super._(
          adjacencyMatrix: adjacencyMatrix ?? Int64List(1),
          graphType: _Oriented,
        );

  @override
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? edgeWeigth,
  }) {
    // TODO: implement addVertex
  }

  @override
  void bfs(Vertex initialNode) {
    // TODO: implement bfs
  }

  @override
  void dfs() {
    // TODO: implement dfs
  }

  @override
  void excludeVertex({required String vertexLabel}) {
    // TODO: implement excludeVertex
  }

  @override
  // TODO: implement first
  Vertex get first => throw UnimplementedError();

  @override
  // TODO: implement getAllEdges
  List<Edge> get getAllEdges => throw UnimplementedError();

  @override
  Vertex getV(String label) {
    // TODO: implement getV
    throw UnimplementedError();
  }

  @override
  bool hasCycle() {
    // TODO: implement hasCycle
    throw UnimplementedError();
  }

  @override
  bool isDAG() {
    // TODO: implement isDAG
    throw UnimplementedError();
  }

  @override
  // TODO: implement isStronglyConnected
  bool get isStronglyConnected => throw UnimplementedError();

  @override
  // TODO: implement last
  Vertex get last => throw UnimplementedError();

  @override
  // TODO: implement numOfEdges
  int get numOfEdges => throw UnimplementedError();

  @override
  String printGraph({bool vertexValue = false, bool edgeWeigth = false}) {
    // TODO: implement printGraph
    throw UnimplementedError();
  }
}
