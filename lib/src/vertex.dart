part of 'graph.dart';

///
class Vertex {
  num value;

  final List<Edge> edgesList;

  /// null for root
  Vertex? ancestor;
  bool visited;

  String label;

  Vertex({
    required this.label,
    this.value = 0,
    List<Edge>? edgesList,
    this.ancestor,
    this.visited = false,
  }) : edgesList = edgesList ?? [];

  /// adds an edge across the current and an existing vertex
  void addEdge({required Vertex connectedTo, num? weigth}) {
    final newEdge = Edge(
      destiny: connectedTo,
      weigth: weigth,
    );

    edgesList.add(newEdge);
  }

  /// returns vertex adjacency list from edge list
  List<Vertex> get verticesOfEdgesList {
    return [for (var edge in edgesList) edge.destiny];
  }

  ///
  bool isSinkhole(OrientedGraph graph) {
    if (edgesList.isEmpty && ancestor != null) {
      return true;
    }

    return false;
  }

  ///
  bool isGenerator(OrientedGraph graph) {
    if (edgesList.isNotEmpty && ancestor == null) {
      return true;
    }

    return false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Vertex &&
        other.value == value &&
        listEquals(other.edgesList, edgesList) &&
        other.visited == visited &&
        other.label == label;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        edgesList.hashCode ^
        visited.hashCode ^
        label.hashCode;
  }
}

///
class NullVertex extends Vertex {
  NullVertex({super.label = '0xff2e2e2e'});
}
