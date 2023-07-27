import 'package:graphs_toolkit/src/interfaces/graph_base.dart';
import 'package:test/test.dart';

void main() {
  test('not oriented graph add vertex basic method - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph.adjacencyList.add(Vertex(label: 'u'));
    myGraph.adjacencyList.add(Vertex(label: 'v'));
    myGraph.adjacencyList.add(Vertex(label: 'y'));
    myGraph.adjacencyList.add(Vertex(label: 'x'));
    myGraph.adjacencyList.add(Vertex(label: 'w'));
    myGraph.adjacencyList.add(Vertex(label: 'z'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('u'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('x'));
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('u'));

    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('x'));
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('y'));

    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('v'));
    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('w'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('z'));
    myGraph.getV('z').addEdge(connectedTo: myGraph.getV('w'));

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

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

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
