import 'package:graphs_toolkit/graphs_toolkit.dart';

void main() {
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
  myGraph.addVertex(newVertex: Vertex(label: 'x'));
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
  myGraph.addVertex(newVertex: Vertex(label: 'z'));

  myGraph.print();
}
