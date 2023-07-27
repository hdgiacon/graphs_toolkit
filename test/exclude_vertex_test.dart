import 'package:graphs_toolkit/src/interfaces/graph_base.dart';
import 'package:test/test.dart';

void main() {
  test('exclude vertex - oriented graph - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    myGraph.excludeVertex(vertexLabel: 'v');

    expect(
      myGraph,
      AdjacencyList.oriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [],
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
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
        ],
      ),
    );
  });

  test('exclude vertex - oriented graph weight value - test', () {
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

    myGraph.excludeVertex(vertexLabel: 'v');

    expect(
      myGraph,
      AdjacencyList.oriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weight: 8),
            ],
          ),
        ],
      ),
    );
  });

  test('exclude vertex not found - oriented graph - test', () {
    final myGraph = AdjacencyList.oriented();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    myGraph.excludeVertex(vertexLabel: '1');
    /* prints a error message */
  });

  test('exclude vertex - not oriented graph - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    myGraph.excludeVertex(vertexLabel: 'v');

    expect(
      myGraph,
      AdjacencyList.notOriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
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

  test('exclude vertex - not oriented graph weight value - test', () {
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

    myGraph.excludeVertex(vertexLabel: 'v');

    expect(
      myGraph,
      AdjacencyList.notOriented(
        adjacencyList: [
          Vertex(
            label: 'u',
            value: 1,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'y',
            value: 3,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 5),
              Edge(destiny: myGraph.getV('w'), weight: 6),
            ],
          ),
          Vertex(
            label: 'x',
            value: 4,
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 2),
              Edge(destiny: myGraph.getV('y'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            value: 5,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            value: 6,
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weight: 7),
            ],
          ),
        ],
      ),
    );
  });

  test('exclude vertex not found - not oriented graph - test', () {
    final myGraph = AdjacencyList.notOriented();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    myGraph.excludeVertex(vertexLabel: '5');
    /* prints a error message */
  });
}
