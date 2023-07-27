import 'dart:collection' show ListQueue;
import 'dart:developer' show log;
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:logger/logger.dart' show Logger;

part 'graph_exceptions.dart';

part 'vertex.dart';
part 'edge.dart';

part 'interfaces/oriented.dart';
part 'interfaces/not_oriented.dart';

part 'adjacency_list/adjacency_list.dart';
part 'adjacency_list/oriented_graph.dart';
part 'adjacency_list/not_oriented_graph.dart';

part 'adjacency_matrix/adjacency_matrix.dart';

abstract interface class _GraphBase {
  /// Returns a `vertex` from vertices list according to its label
  ///
  /// If the searched vertex is not found, throws a `[StateError]`
  Vertex getV(String label);

  void setInitialValues();

  /// First vertex of the list of vertices
  Vertex get first;

  /// Last vertex of the list of vertices
  Vertex get last;

  /// Breadth First Search
  ///
  /// Calculates distance to all reachable vertices from a vertex of origin
  ///
  /// Causes a side effect on the graph, generating a `breadth-first search tree`
  ///
  /// The tree is defined by the `ancestor` field at each vertex
  ///
  /// The `distance` calculated and stored in `value`
  ///
  /// `ancestor` saves the previous vertex
  ///
  /// `visited` becomes true
  void bfs(Vertex initialNode);

  /// Depth-first search
  ///
  /// At each vertex of the graph, explore as much as possible until going to the next unvisited vertex
  ///
  /// Causes a side effect on the graph, building a depth-first search forest
  ///
  /// Contains several depth-first search trees
  ///
  /// The `distance` calculated and stored in `value`
  ///
  /// `ancestor` saves the previous vertex
  ///
  /// `visited` becomes true
  void dfs();

  int dfsVisit(Vertex actual, int time, bool cicleSearch);

  /// Checks if there are any cycles in the whole graph
  ///
  /// valid for Not Oriented Graphs
  /// ```
  ///   | u |----| v |    | w |
  ///     |      / |      / |
  ///     |    /   |    /   |
  ///     |  /     |  /     |
  ///   | x |----| y |    | z |
  ///
  ///
  /// ```
  /// and Oriented Graphs
  /// ```
  ///   | u |---->| v |      | w |
  ///     ^      /> |        / ^
  ///     |    /    |      /   |
  ///     |  /     \ /  </     |
  ///   | x |<----| y |      | z |
  ///
  ///
  /// ```
  bool hasCycle();

  String printGraph({bool vertexValue = false, bool edgeWeigth = false});

  @override
  String toString();
}
