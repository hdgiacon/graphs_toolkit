part of '../interfaces/graph_base.dart';

abstract class AdjacencyMatrix implements _GraphBase {
  ///
  final Int64List adjacencyMatrix;

  ///
  final Type graphType;

  ///
  AdjacencyMatrix._({required this.adjacencyMatrix, required this.graphType});

  ///
  factory AdjacencyMatrix.oriented({Int64List? adjacencyMatrix}) {
    return _OrientedMatrixGraph(adjacencyMatrix: adjacencyMatrix);
  }

  ///
  factory AdjacencyMatrix.notOriented({Int64List? adjacencyMatrix}) {
    return _NotOrientedMatrixGraph(adjacencyMatrix: adjacencyMatrix);
  }
}
