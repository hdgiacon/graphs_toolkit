import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedFrom: [myGraph.getV('u')]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedFrom: [myGraph.getV('u')]);
    myGraph.getV('v').addEdge(connectedFrom: myGraph.getV('x'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedFrom: [myGraph.getV('v')]);
    myGraph.getV('x').addEdge(connectedFrom: myGraph.getV('y'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'));
    myGraph.getV('y').addEdge(connectedFrom: myGraph.getV('w'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedFrom: [myGraph.getV('w')]);
    myGraph.getV('z').addEdge(connectedFrom: myGraph.getV('z'));

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[3]),
              Edge(destiny: myGraph.vertices[5]),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[5]),
            ],
          ),
        ],
      ),
    );
  });
}
