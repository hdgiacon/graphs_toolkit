import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('exclude edge - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print('$myGraph\n');

    myGraph.getV('1').excludeEdge(destinyLabel: '3');

    myGraph.getV('3').excludeEdge(destinyLabel: '2');

    print(myGraph);
  });
}
