import 'package:graphs_toolkit/src/interfaces/graph_base.dart';
import 'package:test/test.dart';

void main() {
  test('not oriented graph add vertex basic method - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph
      ..adjacencyList.add(Vertex(label: 'u'))
      ..adjacencyList.add(Vertex(label: 'v'))
      ..adjacencyList.add(Vertex(label: 'y'))
      ..adjacencyList.add(Vertex(label: 'x'))
      ..adjacencyList.add(Vertex(label: 'w'))
      ..adjacencyList.add(Vertex(label: 'z'));

    myGraph
      ..getV('u').addEdge(connectedTo: myGraph.getV('v'))
      ..getV('v').addEdge(connectedTo: myGraph.getV('u'))
      ..getV('u').addEdge(connectedTo: myGraph.getV('x'))
      ..getV('x').addEdge(connectedTo: myGraph.getV('u'))
      ..getV('v').addEdge(connectedTo: myGraph.getV('y'))
      ..getV('y').addEdge(connectedTo: myGraph.getV('v'))
      ..getV('y').addEdge(connectedTo: myGraph.getV('x'))
      ..getV('x').addEdge(connectedTo: myGraph.getV('y'))
      ..getV('x').addEdge(connectedTo: myGraph.getV('v'))
      ..getV('v').addEdge(connectedTo: myGraph.getV('x'))
      ..getV('w').addEdge(connectedTo: myGraph.getV('y'))
      ..getV('y').addEdge(connectedTo: myGraph.getV('w'))
      ..getV('w').addEdge(connectedTo: myGraph.getV('z'))
      ..getV('z').addEdge(connectedTo: myGraph.getV('w'));

    expect(
      myGraph,
      AdjacencyList.notOriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('v')),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with add vertex method - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph
      ..addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'])
      ..addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x'])
      ..addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w'])
      ..addVertex(newVertex: Vertex(label: 'x'))
      ..addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z'])
      ..addVertex(newVertex: Vertex(label: 'z'));

    expect(
      myGraph,
      AdjacencyList.notOriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('y')),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
        ],
      ),
    );
  });
}
