import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph add vertex basic test', () {
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
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[3]),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: 'y',
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
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2]),
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
