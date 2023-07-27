import 'package:graphs_toolkit/src/interfaces/graph_base.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph add vertex basic method - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph.adjacencyList.add(Vertex(label: 'u'));
    myGraph.adjacencyList.add(Vertex(label: 'v'));
    myGraph.adjacencyList.add(Vertex(label: 'y'));
    myGraph.adjacencyList.add(Vertex(label: 'x'));
    myGraph.adjacencyList.add(Vertex(label: 'w'));
    myGraph.adjacencyList.add(Vertex(label: 'z'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('y'));

    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('z'));

    myGraph.getV('z').addEdge(connectedTo: myGraph.getV('z'));

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

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

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
