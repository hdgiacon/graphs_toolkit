import 'package:graphs_toolkit/src/interfaces/graph_base.dart';

void main() {
  final myGraph = AdjacencyList.notOriented();

  myGraph
    ..addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'])
    ..addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x'])
    ..addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w'])
    ..addVertex(newVertex: Vertex(label: 'x'))
    ..addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z'])
    ..addVertex(newVertex: Vertex(label: 'z'));

  /*  */

  final myGraph2 = AdjacencyList.notOriented();

  myGraph2
    ..adjacencyList.add(Vertex(label: 'u'))
    ..adjacencyList.add(Vertex(label: 'v'))
    ..adjacencyList.add(Vertex(label: 'y'))
    ..adjacencyList.add(Vertex(label: 'x'))
    ..adjacencyList.add(Vertex(label: 'w'))
    ..adjacencyList.add(Vertex(label: 'z'));

  myGraph2
    ..getV('u').addEdge(connectedTo: myGraph.getV('v'))
    ..getV('v').addEdge(connectedTo: myGraph.getV('u'))
    ..getV('u').addEdge(connectedTo: myGraph.getV('x'))
    ..getV('x').addEdge(connectedTo: myGraph.getV('u'))
    ..getV('v').addEdge(connectedTo: myGraph.getV('y'))
    ..getV('y').addEdge(connectedTo: myGraph.getV('v'))
    ..getV('y').addEdge(connectedTo: myGraph.getV('x'))
    ..getV('x').addEdge(connectedTo: myGraph.getV('v'))
    ..getV('x').addEdge(connectedTo: myGraph.getV('y'))
    ..getV('v').addEdge(connectedTo: myGraph.getV('x'))
    ..getV('w').addEdge(connectedTo: myGraph.getV('y'))
    ..getV('y').addEdge(connectedTo: myGraph.getV('w'))
    ..getV('w').addEdge(connectedTo: myGraph.getV('z'))
    ..getV('z').addEdge(connectedTo: myGraph.getV('w'));

  print(myGraph == myGraph2); // true
}
