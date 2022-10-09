part of 'graph.dart';

///
class NotOrientedGraph extends _Graph {
  NotOrientedGraph({
    List<Vertex>? vertices,
  }) : super._(vertices: vertices ?? []);

  ///
  @override
  void addVertex({
    required Vertex newVertex,
    List<String>? connectedTo,
    List<num?>? weigth,
    List<num?>? weigth2,
  }) {
    if (_searchWaitList(newVertex.label)) {
      _waitList.removeWhere((element) {
        if (element.vertex.label == newVertex.label) {
          element.connectedFrom
              .addEdge(connectedTo: newVertex, weigth: element.weigth);
          newVertex.addEdge(
              connectedTo: element.connectedFrom, weigth: element.weigth2);
          return true;
        }
        return false;
      });
    }

    vertices.add(newVertex);

    if (connectedTo != null) {
      final connectedToAsTriple = [
        for (var k = 0; k < connectedTo.length; k++)
          Tuple3(connectedTo[k], weigth?[k], weigth2?[k])
      ];

      for (var t in connectedToAsTriple) {
        if (getV(t.connectedTo) is NullVertex) {
          _waitList.add(Tuple4(
              Vertex(label: t.connectedTo), newVertex, t.weigth, t.weigth2));
        } else {
          newVertex.addEdge(
            connectedTo: getV(t.connectedTo),
            weigth: t.weigth,
          );

          getV(t.connectedTo).addEdge(
            connectedTo: newVertex,
            weigth: t.weigth2,
          );
        }
      }
    }
  }

  /// get the number of edges on a Not Oriented Graph
  int get numOfEdges {
    var cont = 0;

    for (var vertex in vertices) {
      cont += vertex.edgesList.length;
    }

    return cont ~/ 2;
  }

  @override
  String toString() {
    var graphString = "";

    for (var vertex in vertices) {
      graphString = "$graphString(${vertex.label}) - [";

      for (var adj in vertex.edgesList) {
        graphString = "$graphString (${adj.destiny.label})";
      }

      graphString = "$graphString ]\n";
    }

    return graphString.substring(0, graphString.length - 1);
  }

  String print({bool vertexValue = false, bool edgeWeigth = false}) {
    var graphString = "";

    for (var vertex in vertices) {
      graphString =
          "$graphString(${vertex.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(vertex.value) : ""})";

      for (var adj in vertex.edgesList) {
        if (vertex.edgesList.first == adj) {
          graphString =
              "$graphString --${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        } else if (vertex.edgesList.last == adj) {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""})";
        } else {
          graphString =
              "$graphString    ${vertexValue ? "  " : ""}--${edgeWeigth ? _printNum(adj.weigth) ?? "-" : "-"}-- (${adj.destiny.label}${vertexValue ? ":" : ""}${vertexValue ? _printNum(adj.destiny.value) : ""}) \n";
        }
      }

      graphString = "$graphString \n\n";
    }

    return graphString;
  }

  num? _printNum(num? num) {
    if (num != null) {
      if (num % 1 == 0) {
        return num.toInt();
      } else {
        return num;
      }
    }
    return null;
  }
}
