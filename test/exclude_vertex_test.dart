import 'package:graphs_toolkit/graphs_toolkit.dart';
import 'package:test/test.dart';

void main() {
  test('exclude vertex - oriented graph - test', () {
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);

    //myGraph.print();

    print('$myGraph\n');

    myGraph.excludeVertex(vertexLabel: '1');

    //print(myGraph);
/*
    expect(
      myGraph,
      OrientedGraph(
        vertices: [
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
    */
  });

  test('exclude vertex - not oriented graph - test', () {
    final myGraph = NotOrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'));
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'));

    myGraph.excludeVertex(vertexLabel: 'v');

    expect(
      myGraph,
      NotOrientedGraph(
        vertices: [
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
}
