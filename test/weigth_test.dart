import 'package:proj/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph with edge weigth - test', () {
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
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 5),
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
              Edge(destiny: myGraph.getV('z'), weigth: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with edge weigth and null - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [null, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedTo: ['v'], edgeWeigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['y', 'z'],
        edgeWeigth: [6, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: null),
              Edge(destiny: myGraph.getV('x'), weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weigth: null),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weigth: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with edge weigth - test', () {
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
      newVertex: Vertex(label: 'w'),
      connectedTo: ['z'],
      edgeWeigth: [7],
    );
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

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

  test('not oriented graph with edge weigth and null - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'),
        connectedTo: ['y', 'x'],
        edgeWeigth: [null, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'),
        connectedTo: ['x', 'w'],
        edgeWeigth: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(
      newVertex: Vertex(label: 'w'),
      connectedTo: ['z'],
      edgeWeigth: [7],
    );
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: null),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: 1),
              Edge(destiny: myGraph.getV('y'), weigth: null),
              Edge(destiny: myGraph.getV('x'), weigth: null),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: null),
              Edge(destiny: myGraph.getV('x'), weigth: 5),
              Edge(destiny: myGraph.getV('w'), weigth: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weigth: null),
              Edge(destiny: myGraph.getV('v'), weigth: null),
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

  test('oriented graph with edge weigth omiting null at the end - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedTo: ['v'], edgeWeigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['y', 'z'],
        edgeWeigth: [6, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 1),
              Edge(destiny: myGraph.getV('x'), weigth: null),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weigth: 4),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weigth: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with edge weigth omiting null at the end - test',
      () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'),
        connectedTo: ['y', 'x'],
        edgeWeigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'),
        connectedTo: ['x', 'w'],
        edgeWeigth: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(
      newVertex: Vertex(label: 'w'),
      connectedTo: ['z'],
      edgeWeigth: [],
    );
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

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
              Edge(destiny: myGraph.getV('x'), weigth: null),
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
              Edge(destiny: myGraph.getV('v'), weigth: null),
              Edge(destiny: myGraph.getV('y'), weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weigth: 6),
              Edge(destiny: myGraph.getV('z'), weigth: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weigth: null),
            ],
          ),
        ],
      ),
    );
  });
}
