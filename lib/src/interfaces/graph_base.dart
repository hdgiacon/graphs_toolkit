import 'dart:collection' show ListQueue;
import 'dart:developer' show log;
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:logger/logger.dart' show Logger;

part '../graph_exceptions.dart';

part '../vertex.dart';
part '../edge.dart';

part 'oriented.dart';
part 'not_oriented.dart';

part '../adjacency_list/adjacency_list.dart';
part '../adjacency_list/oriented_list_graph.dart';
part '../adjacency_list/not_oriented_list_graph.dart';

part '../adjacency_matrix/adjacency_matrix.dart';
part '../adjacency_matrix/oriented_matrix_graph.dart';
part '../adjacency_matrix/not_oriented_matrix_graph.dart';

abstract interface class _GraphBase {
  /// Add a new vertex to the graph
  ///
  /// if it has adjacents, their `labels` can be passed in `connectedTo`
  /// if such vertices have not yet been created, they will be stored in a waiting list until their declaration occurs,
  /// edges will be created automatically
  ///
  /// * the examples are oriented graphs but they work the same way in `not oriented` graphs
  ///
  /// ```
  ///
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
  /// myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['x']);
  /// myGraph.addVertex(newVertex: Vertex(label: 'x'));
  ///
  ///
  /// ```
  /// The weight of the edges can be passed on `edgeWeight`
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x'],
  ///      edgeWeigth: [1, 2]);
  /// ```
  ///
  /// The values ​​are processed `positionally`, so:
  /// ```
  ///   | u |--1-->| v |
  ///   | u |--2-->| x |
  /// ```
  /// Weights can take on `null` values explicitly
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x'],
  ///      edgeWeigth: [1, null]);
  /// ```
  /// So
  /// ```
  ///   | u |--1-->| v |
  ///   | u |----->| x |
  /// ```
  /// Or omitting the `null` value at the end
  /// ```
  /// myGraph.addVertex(newVertex: Vertex(label: 'u'),
  ///      connectedTo: ['v', 'x', 'y'],
  ///      edgeWeigth: [1]);  // will be [1, null, null]
  ///
  ///   | u |--1-->| v |
  ///   | u |----->| x |
  ///
  ///
  /// ```
  ///
  /// May have edges that leave a vertex and arrive at it.
  /// ```
  ///   | u |----->| u |
  /// ```
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? edgeWeigth,
  });

  /// removes a vertex by its `label` along with the edges that arrived at it from its adjacent ones
  ///
  /// If the vertex is `not found`, a `log` message will be displayed.
  ///
  /// In *`run`* mode only the message will be shown, for more information about the exception and stack
  /// status (StackTrace), run in *`debug`* mode.
  void excludeVertex({required String vertexLabel});

  /// Returns a `vertex` from vertices list according to its label
  ///
  /// If the searched vertex is not found, throws a `[StateError]`
  Vertex getV(String label);

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

  /// Show the graph in ajacencies list mode
  ///
  /// * Not Oriented
  ///
  /// ```
  ///   myGraph.printGraph();
  ///
  ///   (1) ----- (2)
  ///       ----- (3)
  ///
  ///   (2) ----- (1)
  ///
  ///   (3) ----- (1)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue => `(label,value)`
  /// ```
  ///   myGraph.printGraph(vertexValue: true);
  ///
  ///   (1:5) ----- (2:4)
  ///         ----- (3:10)
  ///
  ///   (2:4) ----- (1:5)
  ///
  ///   (3:10) ----- (1:5)
  /// ```
  /// Edge weights can be shown with edgeWeight
  /// ```
  ///   myGraph.printGraph(edgeWeigth: true);
  ///
  ///   (1) --1-- (2)
  ///       --2-- (3)
  ///
  ///   (2) --5-- (1)
  ///
  ///   (3) --10-- (1)
  /// ```
  ///
  /// * Oriented
  ///
  /// ```
  ///   myGraph.printGraph();
  ///
  ///   (1) -----> (2)
  ///       -----> (3)
  ///
  ///   (2)
  ///
  ///   (3) -----> (3)
  /// ```
  /// The values ​​contained in the vertices can be shown with vertexValue :> `(label,value)`
  /// ```
  ///   myGraph.printGraph(vertexValue: true);
  ///
  ///   (1:5) -----> (2:4)
  ///         -----> (3:10)
  ///
  ///   (2:4)
  ///
  ///   (3:10) -----> (3:10)
  /// ```
  /// Edge weights can be shown with edgeWeight
  /// ```
  ///   myGraph.printGraph(edgeWeigth: true);
  ///
  ///   (1) --1--> (2)
  ///       --2--> (3)
  ///
  ///   (2)
  ///
  ///   (3) --8--> (3)
  /// ```
  ///
  /// `null` values ​​are not shown
  String printGraph({bool vertexValue = false, bool edgeWeigth = false});

  @override
  String toString();
}
