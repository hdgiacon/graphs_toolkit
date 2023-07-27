part of '../graphs_toolkit_base.dart';

abstract interface class _NotOriented {
  /// get the number of edges on a Not Oriented Graph
  int get numOfEdges;

  /// List with all existing edges in the graph
  List<Edge> get getAllEdges;

  /// An not oriented graph is said to be connected if from one vertex it can be reached all others.
  /// ```
  ///   | u |----| v |    | w |
  ///     |      / |      / |
  ///     |    /   |    /   |
  ///     |  /     |  /     |
  ///   | x |----| y |    | z |
  /// ```
  ///
  bool isConnected();

  /// If its a not oriented, acyclic and connected graph
  /// ```
  ///
  ///       | u |-----| t |
  ///       /   \
  ///      /     \
  ///   | v |   | w |
  ///              \
  ///               \
  ///             | x |
  /// ```
  bool isTree();

  /// If its a not oriented and acyclic graph
  /// ```
  ///
  ///       | u |             | y |----| b |
  ///       /   \             /   \
  ///      /     \           /     \
  ///   | v |   | w |     | z |   | a |
  ///              \
  ///               \
  ///             | x |
  /// ```
  bool isForest();
}
