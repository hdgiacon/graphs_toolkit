import 'package:proj/altertative/graph.dart';

void main() {
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: '1'));
  myGraph.addVertex(
      newVertex: Vertex(label: '2'), connectedFrom: myGraph.vertices[0]);
  myGraph.addVertex(
      newVertex: Vertex(label: '3'), connectedFrom: myGraph.vertices[0]);

  myGraph.bfs(myGraph.vertices[0]);
}
