import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph add vertex basic method - test', () {
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));
    myGraph.vertices.add(Vertex(label: 'y'));
    myGraph.vertices.add(Vertex(label: 'x'));
    myGraph.vertices.add(Vertex(label: 'w'));
    myGraph.vertices.add(Vertex(label: 'z'));

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
      OrientedGraph(
        vertices: [
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
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
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
