import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('bfs test', () {
    final myGraph = Graph(
      edges: [],
      vertices: [
        Vertex(
          label: "1",
          edgesList: [
            Vertex(label: "2", edgesList: []),
            Vertex(label: "3", edgesList: []),
          ],
        ),
        Vertex(edgesList: []),
        Vertex(edgesList: []),
      ],
    );

    myGraph.bfs(myGraph.vertices[0]);

    expect(
      myGraph,
      Graph(
        edges: [],
        vertices: [
          Vertex(
            label: "1",
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Vertex(
                label: "2",
                edgesList: [],
                value: 1,
                ancestor: myGraph.vertices[0],
                visited: true,
              ),
              Vertex(
                label: "3",
                edgesList: [],
                value: 2,
                ancestor: myGraph.vertices[0],
                visited: true,
              ),
            ],
          ),
          Vertex(edgesList: []),
          Vertex(edgesList: []),
        ],
      ),
    );
  });
}
