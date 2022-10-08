import 'package:proj/src/graph.dart';
import 'package:test/test.dart';

void main() {
  test('BFS - not oriented - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.bfs(myGraph.vertices[0]);

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: '1',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: '2',
            value: 1,
            ancestor: myGraph.vertices[0],
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
            ],
          ),
          Vertex(
            label: '3',
            value: 1,
            ancestor: myGraph.vertices[0],
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.vertices[0]),
            ],
          ),
        ],
      ),
    );
  });

  test('BFS - oriented - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.bfs(myGraph.vertices[0]);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: '1',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.vertices[1]),
              Edge(destiny: myGraph.vertices[2]),
            ],
          ),
          Vertex(
            label: '2',
            value: 1,
            ancestor: myGraph.vertices[0],
            visited: true,
          ),
          Vertex(
            label: '3',
            value: 1,
            ancestor: myGraph.vertices[0],
            visited: true,
          ),
        ],
      ),
    );
  });
}
