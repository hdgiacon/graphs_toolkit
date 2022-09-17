part of "graph.dart";

///
class Edge {
  Vertex source;
  Vertex destiny;

  double value;
  bool isOriented;

  Edge({
    required this.source,
    required this.destiny,
    this.value = 0,
    this.isOriented = false,
  }) {
    source.edgesList.add(destiny);

    if (!isOriented) {
      destiny.edgesList.add(source);
    }
  }
}
