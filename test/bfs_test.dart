import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('BFS - not oriented - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: '1',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('2')),
              Edge(destiny: myGraph.getV('3')),
            ],
          ),
          Vertex(
            label: '2',
            value: 1,
            ancestor: myGraph.getV('1'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('1')),
            ],
          ),
          Vertex(
            label: '3',
            value: 1,
            ancestor: myGraph.getV('1'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('1')),
            ],
          ),
        ],
      ),
    );
  });

  test('BFS - oriented - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: '1',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('2')),
              Edge(destiny: myGraph.getV('3')),
            ],
          ),
          Vertex(
            label: '2',
            value: 1,
            ancestor: myGraph.getV('1'),
            visited: true,
          ),
          Vertex(
            label: '3',
            value: 1,
            ancestor: myGraph.getV('1'),
            visited: true,
          ),
        ],
      ),
    );
  });

  test('bfs - not oriented graph - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'y',
            value: 2,
            ancestor: myGraph.getV('v'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
          Vertex(
            label: 'x',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('u')),
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('y')),
            ],
          ),
          Vertex(
            label: 'w',
            value: 3,
            ancestor: myGraph.getV('y'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            value: 4,
            ancestor: myGraph.getV('w'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('w')),
            ],
          ),
        ],
      ),
    );
  });

  test('bfs - not oriented graph weight - test', () {
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

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 1),
              Edge(destiny: myGraph.getV('y'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'y',
            value: 2,
            ancestor: myGraph.getV('v'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 3),
              Edge(destiny: myGraph.getV('x'), weight: 5),
              Edge(destiny: myGraph.getV('w'), weight: 6),
            ],
          ),
          Vertex(
            label: 'x',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('u'), weight: 2),
              Edge(destiny: myGraph.getV('v'), weight: 4),
              Edge(destiny: myGraph.getV('y'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            value: 3,
            ancestor: myGraph.getV('y'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            value: 4,
            ancestor: myGraph.getV('w'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('w'), weight: 7),
            ],
          ),
        ],
      ),
    );
  });

  test('bfs - oriented graph - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'v',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
            ],
          ),
          Vertex(
            label: 'y',
            value: 2,
            ancestor: myGraph.getV('v'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('x')),
            ],
          ),
          Vertex(
            label: 'x',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v')),
            ],
          ),
          Vertex(
            label: 'w',
            value: 0,
            ancestor: null,
            visited: false,
            edgesList: [
              Edge(destiny: myGraph.getV('y')),
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
          Vertex(
            label: 'z',
            value: 0,
            ancestor: null,
            visited: false,
            edgesList: [
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
        ],
      ),
    );
  });

  test('bfs - oriented graph weight - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(
        newVertex: Vertex(label: 'u'),
        connectedTo: ['v', 'x'],
        edgeWeigth: [1, 2]);
    myGraph.addVertex(
        newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: [3, 1]);
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

    myGraph.bfs(myGraph.first);

    expect(
      myGraph,
      OrientedGraph(
        vertices: [
          Vertex(
            label: 'u',
            value: 0,
            ancestor: null,
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 1),
              Edge(destiny: myGraph.getV('x'), weight: 2),
            ],
          ),
          Vertex(
            label: 'v',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 3),
            ],
          ),
          Vertex(
            label: 'y',
            value: 2,
            ancestor: myGraph.getV('v'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('x'), weight: 4),
            ],
          ),
          Vertex(
            label: 'x',
            value: 1,
            ancestor: myGraph.getV('u'),
            visited: true,
            edgesList: [
              Edge(destiny: myGraph.getV('v'), weight: 5),
            ],
          ),
          Vertex(
            label: 'w',
            value: 0,
            ancestor: null,
            visited: false,
            edgesList: [
              Edge(destiny: myGraph.getV('y'), weight: 6),
              Edge(destiny: myGraph.getV('z'), weight: 7),
            ],
          ),
          Vertex(
            label: 'z',
            value: 0,
            ancestor: null,
            visited: false,
            edgesList: [
              Edge(destiny: myGraph.getV('z'), weight: 8),
            ],
          ),
        ],
      ),
    );
  });
}
