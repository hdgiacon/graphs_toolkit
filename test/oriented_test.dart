import 'package:graphs_toolkit/src/interfaces/graph_base.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph add vertex basic method - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph
      ..adjacencyList.add(Vertex(label: 'u'))
      ..adjacencyList.add(Vertex(label: 'v'))
      ..adjacencyList.add(Vertex(label: 'y'))
      ..adjacencyList.add(Vertex(label: 'x'))
      ..adjacencyList.add(Vertex(label: 'w'))
      ..adjacencyList.add(Vertex(label: 'z'));

    myGraph
      ..getV('u').addEdge(connectedTo: myGraph.getV('v'))
      ..getV('u').addEdge(connectedTo: myGraph.getV('x'))
      ..getV('v').addEdge(connectedTo: myGraph.getV('y'))
      ..getV('y').addEdge(connectedTo: myGraph.getV('x'))
      ..getV('x').addEdge(connectedTo: myGraph.getV('v'))
      ..getV('w').addEdge(connectedTo: myGraph.getV('y'))
      ..getV('w').addEdge(connectedTo: myGraph.getV('z'))
      ..getV('z').addEdge(connectedTo: myGraph.getV('z'));

    expect(
      myGraph,
      AdjacencyList.oriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(label: 'w', edgesList: [
            Edge(destiny: myGraph.getV('y')),
            Edge(destiny: myGraph.getV('z')),
          ], connectedFrom: []),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z')),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with add vertex method - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph
      ..addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'])
      ..addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'])
      ..addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'])
      ..addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v'])
      ..addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'])
      ..addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    expect(
      myGraph,
      AdjacencyList.oriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(label: 'w', edgesList: [
            Edge(destiny: myGraph.getV('y')),
            Edge(destiny: myGraph.getV('z')),
          ], connectedFrom: []),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z')),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });
}
