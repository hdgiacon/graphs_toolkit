import 'package:graphs_toolkit/src/graphs_toolkit_base.dart';
import 'package:test/test.dart';
import 'dart:developer';
import 'package:logger/logger.dart';

void main() {
  test('exclude oriented edge not found - test', () {
    final myGraph = AdjacencyList.oriented();

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
    final myGraph = AdjacencyList.oriented();

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
    final myGraph = AdjacencyList.notOriented();

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
    final myGraph = AdjacencyList.notOriented();

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

  test('exclude not oriented edge weight - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u', value: 1),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v', value: 2),
        connectedTo: ['y', 'x'],
        edgeWeigth: [3, 4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y', value: 3),
        connectedTo: ['x', 'w'],
        edgeWeigth: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x', value: 4));
    myGraph.addVertex(
        newVertex: Vertex(label: 'w', value: 5),
        connectedTo: ['z'],
        edgeWeigth: [7]);
    myGraph.addVertex(newVertex: Vertex(label: 'z', value: 6));

    try {
      myGraph.getV('v').excludeEdge(destinyLabel: 'u');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });

  test('exclude oriented edge wigth - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u', value: 1),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v', value: 2),
        connectedTo: ['y'],
        edgeWeigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y', value: 3),
        connectedTo: ['x'],
        edgeWeigth: [4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x', value: 4),
        connectedTo: ['v'],
        edgeWeigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w', value: 5),
        connectedTo: ['y', 'z'],
        edgeWeigth: [6, 7]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z', value: 6),
        connectedTo: ['z'],
        edgeWeigth: [8]);

    try {
      myGraph.getV('v').excludeEdge(destinyLabel: 'y');
    } on EdgeNotFoundException catch (e, s) {
      final logger = Logger();
      logger.e(e.cause);

      log('', error: e, stackTrace: s);
    }
  });
}
