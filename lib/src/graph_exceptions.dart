part of 'graphs_toolkit_base.dart';

class EdgeNotFoundException implements Exception {
  final String cause;

  EdgeNotFoundException(this.cause);
}

class EdgeAlreadyExistsException implements Exception {
  final String cause;

  EdgeAlreadyExistsException(this.cause);
}
