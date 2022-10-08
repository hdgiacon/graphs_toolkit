import 'package:proj/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('toString function - not oriented - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ (1) ]\n(3) - [ (1) ]",
    );
  });

  test('toString function - oriented - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ ]\n(3) - [ ]",
    );
  });
}
