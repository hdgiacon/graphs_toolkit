part of '../graphs_toolkit_base.dart';

abstract interface class _Oriented {
  /// get the number of edges on a Oriented Graph
  int get numOfEdges;

  /// List with all existing edges in the graph
  List<Edge> get getAllEdges;

  /// A oriented graph is strongly connected if for every pair of `vertices(u, v)`, `v` is accessible from `u`
  /// ```
  ///   | u |---->| v |
  ///     ^       / |
  ///     |     /   |
  ///     |  </    \|/
  ///   | x |<----| y |
  ///
  ///
  /// ```
  bool get isStronglyConnected;

  /// If its a oriented and acyclic graph
  /// ```
  ///
  /// | v |----->| u |<-----| t |
  ///              ^          ^
  ///              |          |
  ///              |          |
  ///            | w |      | x |
  ///
  ///
  /// ```
  bool isDAG();

  @override
  String toString();
}
