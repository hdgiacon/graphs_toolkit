/// Support for `Graph` data structure based on adjacency lists and adjacency matrix
library graphs_toolkit;

export 'src/interfaces/graph_base.dart'
    show
        Edge,
        Vertex,
        AdjacencyList,
        EdgeAlreadyExistsException,
        EdgeNotFoundException;
