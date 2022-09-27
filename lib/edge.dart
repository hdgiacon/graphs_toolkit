part of 'graph.dart';

/// Connect two vertices
///
/// can have a weight value, default is 0
class Edge {
  Vertex destiny;

  double value;

  Edge({
    required this.destiny,
    this.value = 0,
  });
}
