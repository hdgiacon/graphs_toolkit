part of 'graph.dart';

///
class Edge {
  Vertex destiny;

  double value;

  Edge({
    required this.destiny,
    this.value = 0,
  });
}
