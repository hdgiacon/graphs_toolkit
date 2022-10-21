import 'package:proj/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('print function - oriented - no weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.print());

    expect(
      myGraph.print(),
      "(1) ----> (2) \n    ----> (3) \n\n(2) \n\n(3) \n\n",
    );
  });

  test('print function - oriented - with weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1'),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.print(edgeWeigth: true));

    expect(
      myGraph.print(edgeWeigth: true),
      "(1) --1-> (2) \n    --2-> (3) \n\n(2) \n\n(3) \n\n",
    );
  });

  test('print function - not oriented - no weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.print());

    expect(
      myGraph.print(),
      "(1) ----- (2) \n    ----- (3) \n\n(2) ----- (1) \n \n\n(3) ----- (1) \n \n\n",
    );
  });

  test('print function - not oriented - with weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1'),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2],
        edgeWeigthBack: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.print(edgeWeigth: true));

    expect(
      myGraph.print(edgeWeigth: true),
      "(1) --1-- (2) \n    --2-- (3) \n\n(2) --1-- (1) \n \n\n(3) --2-- (1) \n \n\n",
    );
  });

  test('print function - oriented - vertex value - no weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.print(vertexValue: true));

    expect(
      myGraph.print(vertexValue: true),
      "(1:1) ----> (2:2) \n      ----> (3:3) \n\n(2:2) \n\n(3:3) \n\n",
    );
  });

  test('print function - oriented - vertex value - with weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.print(vertexValue: true, edgeWeigth: true));

    expect(
      myGraph.print(vertexValue: true, edgeWeigth: true),
      "(1:1) --1-> (2:2) \n      --2-> (3:3) \n\n(2:2) \n\n(3:3) \n\n",
    );
  });

  test('print function - not oriented - vertex value - no weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.print(vertexValue: true));

    expect(
      myGraph.print(vertexValue: true),
      "(1:1) ----- (2:2) \n      ----- (3:3) \n\n(2:2) ----- (1:1) \n \n\n(3:3) ----- (1:1) \n \n\n",
    );
  });

  test('print function - not oriented - vertex value - with weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2],
        edgeWeigthBack: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.print(vertexValue: true, edgeWeigth: true));

    expect(
      myGraph.print(vertexValue: true, edgeWeigth: true),
      "(1:1) --1-- (2:2) \n      --2-- (3:3) \n\n(2:2) --1-- (1:1) \n \n\n(3:3) --2-- (1:1) \n \n\n",
    );
  });
}
