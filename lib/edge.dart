part of "graph.dart";

class Edge {
  Vertex source;
  Vertex destiny;

  double value;
  bool oriented;

  Edge({
    required this.source,
    required this.destiny,
    this.value = 0,
    this.oriented = false,
  }) {
    source.edgesList.add(destiny);

    if (!oriented) {
      destiny.edgesList.add(source);
    }
  }
}
