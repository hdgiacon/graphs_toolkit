import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('not oriented graph add vertex basic method - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));
    myGraph.vertices.add(Vertex(label: 'y'));
    myGraph.vertices.add(Vertex(label: 'x'));
    myGraph.vertices.add(Vertex(label: 'w'));
    myGraph.vertices.add(Vertex(label: 'z'));

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
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[3]),
              Edge(destiny: myGraph.vertices[4]),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[1]),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[5]),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[4]),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with add vertex method - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[3]),
              Edge(destiny: myGraph.vertices[4]),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[1]),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2]),
              Edge(destiny: myGraph.vertices[5]),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[4]),
            ],
          ),
        ],
      ),
    );
  });
}
