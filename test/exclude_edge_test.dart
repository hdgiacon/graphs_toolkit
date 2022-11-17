import 'package:test/test.dart';
import 'dart:developer';
import 'package:logger/logger.dart';
import 'package:graphs_toolkit/graphs_toolkit.dart';

void main() {
  test('exclude oriented edge not found - test', () {
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

  test('exclude oriented edge - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    try {
      myGraph.getV('1').excludeEdge(destinyLabel: '2');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });

  test('exclude not oriented edge not found - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    try {
      myGraph.getV('2').excludeEdge(destinyLabel: '3');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });

  test('exclude not oriented edge - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    try {
      myGraph.getV('3').excludeEdge(destinyLabel: '1');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });
}
