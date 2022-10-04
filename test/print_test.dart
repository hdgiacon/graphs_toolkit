import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('print function - not oriented - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.vertices.add(Vertex(label: '1'));
    myGraph.vertices.add(Vertex(label: '2'));
    myGraph.vertices.add(Vertex(label: '3'));

    myGraph.getV('1').addEdge(connectedTo: myGraph.getV('2'));
    myGraph.getV('1').addEdge(connectedTo: myGraph.getV('3'));
    myGraph.getV('2').addEdge(connectedTo: myGraph.getV('1'));
    myGraph.getV('3').addEdge(connectedTo: myGraph.getV('1'));

    myGraph.toString();

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ (1) ]\n(3) - [ (1) ]",
    );
  });

  test('print function - oriented - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.toString();

    expect(
      myGraph.toString(),
      "(1) - [ (2) (3) ]\n(2) - [ ]\n(3) - [ ]",
    );
  });
}
