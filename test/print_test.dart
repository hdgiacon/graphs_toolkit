import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('print function - oriented - no weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.printGraph());

    expect(
      myGraph.printGraph(),
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

    print(myGraph.printGraph(edgeWeigth: true));

    expect(
      myGraph.printGraph(edgeWeigth: true),
      "(1) --1-> (2) \n    --2-> (3) \n\n(2) \n\n(3) \n\n",
    );
  });

  test('print function - not oriented - no weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.printGraph());

    expect(
      myGraph.printGraph(),
      "(1) ----- (2) \n    ----- (3)\n\n(2) ----- (1) \n\n(3) ----- (1) \n\n",
    );
  });

  test('print function - not oriented - with weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1'),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    print(myGraph.printGraph(edgeWeigth: true));

    expect(
      myGraph.printGraph(edgeWeigth: true),
      "(1) --1-- (2) \n    --2-- (3)\n\n(2) --1-- (1) \n\n(3) --2-- (1) \n\n",
    );
  });

  test('print function - oriented - vertex value - no weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.printGraph(vertexValue: true));

    expect(
      myGraph.printGraph(vertexValue: true),
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

    print(myGraph.printGraph(vertexValue: true, edgeWeigth: true));

    expect(
      myGraph.printGraph(vertexValue: true, edgeWeigth: true),
      "(1:1) --1-> (2:2) \n      --2-> (3:3) \n\n(2:2) \n\n(3:3) \n\n",
    );
  });

  test('print function - not oriented - vertex value - no weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.printGraph(vertexValue: true));

    expect(
      myGraph.printGraph(vertexValue: true),
      "(1:1) ----- (2:2) \n      ----- (3:3)\n\n(2:2) ----- (1:1) \n\n(3:3) ----- (1:1) \n\n",
    );
  });

  test('print function - not oriented - vertex value - with weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: '1', value: 1),
        connectedTo: ['2', '3'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(newVertex: Vertex(label: '2', value: 2));
    myGraph.addVertex(newVertex: Vertex(label: '3', value: 3));

    print(myGraph.printGraph(vertexValue: true, edgeWeigth: true));

    expect(
      myGraph.printGraph(vertexValue: true, edgeWeigth: true),
      "(1:1) --1-- (2:2) \n      --2-- (3:3)\n\n(2:2) --1-- (1:1) \n\n(3:3) --2-- (1:1) \n\n",
    );
  });

  test('oriented graph no weigth and value - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    print(myGraph.printGraph());

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(label: 'w', edgesList: [
            Edge(destiny: myGraph.getV('y')),
            Edge(destiny: myGraph.getV('z')),
          ], connectedFrom: []),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z')),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedTo: ['v'], edgeWeigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['y', 'z'],
        edgeWeigth: [6, 7]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

    print(myGraph.printGraph(edgeWeigth: true));

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: 2),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 3),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 5),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(label: 'w', edgesList: [
            Edge(destiny: myGraph.getV('y'), weigth: 6),
            Edge(destiny: myGraph.getV('z'), weigth: 7),
          ], connectedFrom: []),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weigth: 8),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with value - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u', value: 1), connectedTo: ['v', 'x']);
    myGraph
        .addVertex(newVertex: Vertex(label: 'v', value: 2), connectedTo: ['y']);
    myGraph
        .addVertex(newVertex: Vertex(label: 'y', value: 3), connectedTo: ['x']);
    myGraph
        .addVertex(newVertex: Vertex(label: 'x', value: 4), connectedTo: ['v']);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w', value: 5), connectedTo: ['y', 'z']);
    myGraph
        .addVertex(newVertex: Vertex(label: 'z', value: 6), connectedTo: ['z']);

    print(myGraph.printGraph(vertexValue: true));

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            value: 2,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('z')),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with weigth and value - test', () {
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

    print(myGraph.printGraph(edgeWeigth: true, vertexValue: true));

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: 2),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'v',
            value: 2,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 3),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('x'),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
            connectedFrom: [
              myGraph.getV('v'),
              myGraph.getV('w'),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 5),
            ],
            connectedFrom: [
              myGraph.getV('u'),
              myGraph.getV('y'),
            ],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: 7),
            ],
            connectedFrom: [],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weigth: 8),
            ],
            connectedFrom: [
              myGraph.getV('w'),
              myGraph.getV('z'),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph no weigth and value - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    print(myGraph.printGraph());

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('y')),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with weigth - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'),
        connectedTo: ['y', 'x'],
        edgeWeigth: [3, 4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'),
        connectedTo: ['x', 'w'],
        edgeWeigth: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'), connectedTo: ['z'], edgeWeigth: [7]);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    print(myGraph.printGraph(edgeWeigth: true));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: 1),
              Edge(destiny: myGraph.getV('y'), weigth: 3),
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 3),
              Edge(destiny: myGraph.getV('x'), weigth: 5),
              Edge(destiny: myGraph.getV('w'), weigth: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: 2),
              Edge(destiny: myGraph.getV('v'), weigth: 4),
              Edge(destiny: myGraph.getV('y'), weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weigth: 7),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with value - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u', value: 1), connectedTo: ['v', 'x']);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v', value: 2), connectedTo: ['y', 'x']);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y', value: 3), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x', value: 4));
    myGraph
        .addVertex(newVertex: Vertex(label: 'w', value: 5), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z', value: 6));

    print(myGraph.printGraph(vertexValue: true));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            value: 2,
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('y')),
            ],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with weigth and value - test', () {
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

    print(myGraph.printGraph(edgeWeigth: true, vertexValue: true));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            value: 2,
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: 1),
              Edge(destiny: myGraph.getV('y'), weigth: 3),
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 3),
              Edge(destiny: myGraph.getV('x'), weigth: 5),
              Edge(destiny: myGraph.getV('w'), weigth: 6),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: 2),
              Edge(destiny: myGraph.getV('v'), weigth: 4),
              Edge(destiny: myGraph.getV('y'), weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: 7),
            ],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weigth: 7),
            ],
          ),
        ],
      ),
    );
  });
}
