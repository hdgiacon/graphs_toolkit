part of 'interfaces/graph_base.dart';

class Edge {
  Vertex destiny;

  num? weight;

  /// Connect two vertices
  ///
  /// can have a weight value, default is `null`
  Edge({
    required this.destiny,
    this.weight,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Edge && other.destiny == destiny && other.weight == weight;
  }

  @override
  int get hashCode => destiny.hashCode ^ weight.hashCode;
}
