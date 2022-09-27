import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('print function - toString - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'));
    myGraph.addVertex(
        newVertex: Vertex(label: '2'), connectedFrom: [myGraph.getV('1')]);
    myGraph.addVertex(
        newVertex: Vertex(label: '3'), connectedFrom: [myGraph.getV('1')]);

    myGraph.toString();

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ (1) ]\n(3) - [ (1) ]",
    );
  });
}
