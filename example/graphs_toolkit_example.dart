import 'package:graphs_toolkit/graphs_toolkit.dart';

void main() {
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
  myGraph.addVertex(newVertex: Vertex(label: 'x'));
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
  myGraph.addVertex(newVertex: Vertex(label: 'z'));

  final myGraph2 = NotOrientedGraph();

  myGraph2.vertices.add(Vertex(label: 'u'));
  myGraph2.vertices.add(Vertex(label: 'v'));
  myGraph2.vertices.add(Vertex(label: 'y'));
  myGraph2.vertices.add(Vertex(label: 'x'));
  myGraph2.vertices.add(Vertex(label: 'w'));
  myGraph2.vertices.add(Vertex(label: 'z'));

  myGraph2.getV('u').addEdge(connectedTo: myGraph.getV('v'));
  myGraph2.getV('v').addEdge(connectedTo: myGraph.getV('u'));

  myGraph2.getV('u').addEdge(connectedTo: myGraph.getV('x'));
  myGraph2.getV('x').addEdge(connectedTo: myGraph.getV('u'));

  myGraph2.getV('v').addEdge(connectedTo: myGraph.getV('y'));
  myGraph2.getV('y').addEdge(connectedTo: myGraph.getV('v'));

  myGraph2.getV('y').addEdge(connectedTo: myGraph.getV('x'));
  myGraph2.getV('x').addEdge(connectedTo: myGraph.getV('v'));

  myGraph2.getV('x').addEdge(connectedTo: myGraph.getV('y'));
  myGraph2.getV('v').addEdge(connectedTo: myGraph.getV('x'));

  myGraph2.getV('w').addEdge(connectedTo: myGraph.getV('y'));
  myGraph2.getV('y').addEdge(connectedTo: myGraph.getV('w'));

  myGraph2.getV('w').addEdge(connectedTo: myGraph.getV('z'));
  myGraph2.getV('z').addEdge(connectedTo: myGraph.getV('w'));

  myGraph == myGraph2; // true
}
