import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('not oriented graph test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'));
    myGraph.addVertex(
        newVertex: Vertex(label: '2'), connectedFrom: [myGraph.getV('1')]);
    myGraph.addVertex(
        newVertex: Vertex(label: '3'), connectedFrom: [myGraph.getV('1')]);

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
