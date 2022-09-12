import 'package:proj/proj.dart';
import 'package:test/test.dart';

void main() {
  test('bfs test', () {
    final myGraph = Graph(
      vertices: [
        Vertex(
          label: "1",
          edgesList: [
            Vertex(label: "2", edgesList: []),
            Vertex(label: "3", edgesList: []),
          ],
        ),
        Vertex(label: "2", edgesList: []),
        Vertex(label: "3", edgesList: []),
      ],
    );

    myGraph.toString();

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ ]\n(3) - [ ]",
    );
  });
}
