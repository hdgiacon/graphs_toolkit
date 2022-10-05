import 'package:proj/graph.dart';
import 'package:test/test.dart';

void main() {
  test('oriented graph with edge weigth - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], weigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], weigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], weigth: [4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedTo: ['v'], weigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], weigth: [6, 7]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], weigth: [8]);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 1),
              Edge(destiny: myGraph.vertices[3], weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[3], weigth: 4),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 6),
              Edge(destiny: myGraph.vertices[5], weigth: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[5], weigth: 8),
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
        weigth: [null, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], weigth: [3]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'), connectedTo: ['x'], weigth: [null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'x'), connectedTo: ['v'], weigth: [5]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['y', 'z'],
        weigth: [6, null]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'z'), connectedTo: ['z'], weigth: [8]);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: null),
              Edge(destiny: myGraph.vertices[3], weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 3),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[3], weigth: null),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 6),
              Edge(destiny: myGraph.vertices[5], weigth: null),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[5], weigth: 8),
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
        weigth: [1, 2],
        weigth2: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'),
        connectedTo: ['y', 'x'],
        weigth: [3, 4],
        weigth2: [3, 4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'),
        connectedTo: ['x', 'w'],
        weigth: [5, 6],
        weigth2: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['z'],
        weigth: [7],
        weigth2: [7]);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 1),
              Edge(destiny: myGraph.vertices[3], weigth: 2),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[0], weigth: 1),
              Edge(destiny: myGraph.vertices[2], weigth: 3),
              Edge(destiny: myGraph.vertices[3], weigth: 4),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 3),
              Edge(destiny: myGraph.vertices[3], weigth: 5),
              Edge(destiny: myGraph.vertices[4], weigth: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[0], weigth: 2),
              Edge(destiny: myGraph.vertices[1], weigth: 4),
              Edge(destiny: myGraph.vertices[2], weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 6),
              Edge(destiny: myGraph.vertices[5], weigth: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[4], weigth: 7),
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
        weigth: [1, null],
        weigth2: [null, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'),
        connectedTo: ['y', 'x'],
        weigth: [null, null],
        weigth2: [3, 4]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'y'),
        connectedTo: ['x', 'w'],
        weigth: [5, 6],
        weigth2: [5, 6]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(
        newVertex: Vertex(label: 'w'),
        connectedTo: ['z'],
        weigth: [7],
        weigth2: [null]);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 1),
              Edge(destiny: myGraph.vertices[3], weigth: null),
            ],
          ),
          Vertex(
            label: 'v',
            edgesList: [
              Edge(destiny: myGraph.vertices[0], weigth: null),
              Edge(destiny: myGraph.vertices[2], weigth: null),
              Edge(destiny: myGraph.vertices[3], weigth: null),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.vertices[1], weigth: 3),
              Edge(destiny: myGraph.vertices[3], weigth: 5),
              Edge(destiny: myGraph.vertices[4], weigth: 6),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.vertices[0], weigth: 2),
              Edge(destiny: myGraph.vertices[1], weigth: 4),
              Edge(destiny: myGraph.vertices[2], weigth: 5),
            ],
          ),
          Vertex(
            label: 'w',
            edgesList: [
              Edge(destiny: myGraph.vertices[2], weigth: 6),
              Edge(destiny: myGraph.vertices[5], weigth: 7),
            ],
          ),
          Vertex(
            label: 'z',
            edgesList: [
              Edge(destiny: myGraph.vertices[4], weigth: null),
            ],
          ),
        ],
      ),
    );
  });
}
