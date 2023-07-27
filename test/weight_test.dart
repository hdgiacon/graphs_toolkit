import 'package:graphs_toolkit/src/graphs_toolkit_base.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph with edge weight - test', () {
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
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weight: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with edge weight and null - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [null, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['y', 'z'],
        edgeWeigth: [6]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

    expect(
      myGraph,
      OrientedGraph(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: null),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: null),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: null),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: null),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weight: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with edge weight - test', () {
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
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 1),
              Edge(destiny: myGraph.getV('y'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: 5),
              Edge(destiny: myGraph.getV('w'), weight: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 2),
              Edge(destiny: myGraph.getV('v'), weight: 4),
              Edge(destiny: myGraph.getV('y'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weight: 7),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with edge weight and null - test', () {
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
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: null),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 1),
              Edge(destiny: myGraph.getV('y'), weight: null),
              Edge(destiny: myGraph.getV('x'), weight: null),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: null),
              Edge(destiny: myGraph.getV('x'), weight: 5),
              Edge(destiny: myGraph.getV('w'), weight: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: null),
              Edge(destiny: myGraph.getV('v'), weight: null),
              Edge(destiny: myGraph.getV('y'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weight: 7),
            ],
          ),
        ],
      ),
    );
  });

  test('oriented graph with edge weight omiting null at the end - test', () {
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
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: null),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weight: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('not oriented graph with edge weight omiting null at the end - test',
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
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 1),
              Edge(destiny: myGraph.getV('y'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: null),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: 5),
              Edge(destiny: myGraph.getV('w'), weight: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 2),
              Edge(destiny: myGraph.getV('v'), weight: null),
              Edge(destiny: myGraph.getV('y'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weight: null),
            ],
          ),
        ],
      ),
    );
  });
}
