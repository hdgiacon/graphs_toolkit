part of 'graph.dart';

/// Connect two vertices
///
/// can have a weight value, default is null
class Edge {
  Vertex destiny;

  num? weigth;

  Edge({
    required this.destiny,
    this.weigth,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Edge && other.destiny == destiny && other.weigth == weigth;
  }

  @override
  int get hashCode => destiny.hashCode ^ weigth.hashCode;
}
