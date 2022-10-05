import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph tunned add vertex test', () {
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
