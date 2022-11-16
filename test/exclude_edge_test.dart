import 'package:test/test.dart';
import 'dart:developer';
import 'package:logger/logger.dart';
import 'package:graphs_toolkit/graphs_toolkit.dart';

//TODO: mais testes

void main() {
  test('exclude edge - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    try {
      myGraph.getV('3').excludeEdge(destinyLabel: '2');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });
}
