import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('not oriented graph test', () {
    final myGraph = NotOrientedGraph();

    myGraph.vertices.add(Vertex(label: '1'));
    myGraph.vertices.add(Vertex(label: '2'));
    myGraph.vertices.add(Vertex(label: '3'));

    myGraph.getV('1').addEdge(connectedTo: myGraph.getV('2'));
    myGraph.getV('1').addEdge(connectedTo: myGraph.getV('3'));
    myGraph.getV('2').addEdge(connectedTo: myGraph.getV('1'));
    myGraph.getV('3').addEdge(connectedTo: myGraph.getV('1'));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: '1',
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: '2',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
            ],
          ),
          Vertex(
            label: '3',
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
            ],
          ),
        ],
      ),
    );
  });
}
