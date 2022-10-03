import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph tunned add vertex test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertexTunned(
        newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);

    myGraph.addVertexTunned(newVertex: Vertex(label: 'v'), connectedTo: ['y']);

    myGraph.addVertexTunned(newVertex: Vertex(label: 'y'), connectedTo: ['x']);

    myGraph.addVertexTunned(newVertex: Vertex(label: 'x'), connectedTo: ['v']);

    myGraph.addVertexTunned(
        newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);

    myGraph.addVertexTunned(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

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