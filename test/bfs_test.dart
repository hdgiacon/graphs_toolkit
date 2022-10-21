import 'package:proj/graphs_toolkit.dart';
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
            value: 3,
            ancestor: null,
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
              Edge(destiny: myGraph.getV('z')),
            ],
          ),
        ],
      ),
    );
  });
}
