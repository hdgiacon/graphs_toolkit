import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'));
    myGraph.addVertex(newVertex: Vertex(label: 'v'));
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'y'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'));
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

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
