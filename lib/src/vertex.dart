part of 'graphs_toolkit_base.dart';

class Vertex {
  /// A `num` value that can be stored
  num value;

  /// Matches the links this vertex has with others
  final List<Edge> edgesList;

  /// Corresponds to the vertices that connect to this one
  ///
  /// In not oriented graphs, the edgesList itself is the previously connected list
  final List<Vertex> connectedFrom;

  /// First vertex before this one
  ///
  /// `null` for root
  Vertex? ancestor;

  /// Indicator if the vertex has already been `visited` by one of the algorithms or not
  bool visited;

  /// Identifier so that the vertex can be distinguished from the others
  String label;

  /// A type for this vertex according to the graph in which it was inserted
  late final Type vertexType;

  /// Basic and fundamental unit of a graph
  /// ```
  ///   | label |
  ///```
  /// Must have a label so it can be found in the vertex set
  ///
  /// edgesList matches the links this vertex has with others
  ///
  /// connectedFrom corresponds to the vertices that connect to this one (if it is an not oriented graph, this list will be empty)
  ///
  /// - Both lists are auto-populated in the `addVertex` method
  ///
  /// A type for this vertex according to the graph in which it was inserted
  ///
  /// The value, visited and ancestor parameters are used in the BFS and DFS methods and correspond to:
  /// - a numeric `value` that can be stored
  /// - indicator if the vertex has already been `visited` by one of the algorithms or not
  /// - to the first vertex before this one (`null` if there is no previous one -> `root`)
  ///
  /// respectively
  Vertex({
    required this.label,
    this.value = 0,
    List<Edge>? edgesList,
    List<Vertex>? connectedFrom,
    this.ancestor,
    this.visited = false,
  })  : edgesList = edgesList ?? [],
        connectedFrom = connectedFrom ?? [];

  /// Adds an edge across the current and an existing vertex
  ///
  /// If the edge already exists, the `EdgeAlreadyExistsException` exception will be raised.
  void addEdge({required Vertex connectedTo, num? weight}) {
    for (var edge in edgesList) {
      if (edge.destiny.label == connectedTo.label) {
        throw EdgeAlreadyExistsException(
            'Edge between $label and ${connectedTo.label} already exists');
      }
    }

    final newEdge = Edge(
      destiny: connectedTo,
      weight: weight,
    );

    edgesList.add(newEdge);
  }

  /// Remove a single edge from this vertex
  ///
  /// If the edge is not found, `EdgeNotFoundException` will be thrown.
  void excludeEdge({required String destinyLabel}) {
    for (var edge in edgesList) {
      if (edge.destiny.label == destinyLabel) {
        edgesList.remove(edge);

        return;
      }
    }

    throw EdgeNotFoundException(
        'Edge between (vertex $label) and (vertex $destinyLabel) not found!!!!!!');
  }

  /// Returns vertex adjacency list from edgesList
  List<Vertex> get verticesOfEdgesList {
    return [for (var edge in edgesList) edge.destiny];
  }

  /// Checks if this vertex has no edges coming out of it, used only in `oriented graphs`
  bool get isSinkhole {
    assert(vertexType == _OrientedGraph, 'Graph must be oriented type');

    if (edgesList.isEmpty && connectedFrom.isNotEmpty) {
      return true;
    }

    return false;
  }

  /// Checks if this vertex has no edges entering it, used only in `oriented graphs`
  bool get isGenerator {
    assert(vertexType == _OrientedGraph, 'Graph must be oriented type');

    if (edgesList.isNotEmpty && connectedFrom.isEmpty) {
      return true;
    }

    return false;
  }

  /// Number of edges that enter this vertex
  int get entryDegree {
    if (vertexType == _NotOrientedGraph) {
      return edgesList.length;
    } else {
      return connectedFrom.length;
    }
  }

  /// Number of edges coming out of this vertex
  int get exitDegree => edgesList.length;

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
