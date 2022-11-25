import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('toString function - not oriented 1 - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    expect(
      myGraph.toString(),
      "(1) -- [ (2) (3) ]\n(2) -- [ (1) ]\n(3) -- [ (1) ]",
    );
  });

  test('toString function - not oriented 2 - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    expect(myGraph.toString(),
        '(u) -- [ (v) (x) ]\n(v) -- [ (u) (y) (x) ]\n(y) -- [ (v) (x) (w) ]\n(x) -- [ (u) (v) (y) ]\n(w) -- [ (y) (z) ]\n(z) -- [ (w) ]');
  });

  test('toString function - not oriented 3 - test', () {
    final myGraph = NotOrientedGraph();

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

    expect(myGraph.toString(),
        '(u) -- [ (v) (x) ]\n(v) -- [ (u) (y) (x) ]\n(y) -- [ (v) (x) (w) ]\n(x) -- [ (u) (v) (y) ]\n(w) -- [ (y) (z) ]\n(z) -- [ (w) ]');
  });

  test('toString function - oriented 1 - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    expect(
      myGraph.toString(),
      "(1) -> [ (2) (3) ]\n(2) -> [ ]\n(3) -> [ ]",
    );
  });

  test('toString function - oriented 2 - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    expect(myGraph.toString(),
        "(u) -> [ (v) (x) ]\n(v) -> [ (y) ]\n(y) -> [ (x) ]\n(x) -> [ (v) ]\n(w) -> [ (y) (z) ]\n(z) -> [ (z) ]");
  });

  test('toString function - oriented 3 - test', () {
    final myGraph = OrientedGraph();

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

    expect(myGraph.toString(),
        "(u) -> [ (v) (x) ]\n(v) -> [ (y) ]\n(y) -> [ (x) ]\n(x) -> [ (v) ]\n(w) -> [ (y) (z) ]\n(z) -> [ (z) ]");
  });
}
