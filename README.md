[![CI](https://github.com/dart-lang/graphs/actions/workflows/ci.yml/badge.svg)](https://github.com/dart-lang/graphs/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/graphs.svg)](https://pub.dev/packages/graphs)
[![package publisher](https://img.shields.io/pub/publisher/graphs.svg)](https://pub.dev/packages/graphs/publisher)

Graph algorithms that do not specify a particular approach for representing a
Graph.

Functions in this package will take arguments that provide the mechanism for
traversing the graph. For example two common approaches for representing a
graph:

```dart
class Graph {
  Map<Node, List<Node>> nodes;
}
class Node {
  // Interesting data
}
```

```dart
class Graph {
  Node root;
}
class Node {
  List<Node> edges;
  // Interesting data
}
```

Any representation can be adapted to the needs of the algorithm:

- Some algorithms need to associate data with each node in the graph. If the
  node type `T` does not correctly or efficiently implement `hashCode` or `==`,
  you may provide optional `equals` and/or `hashCode` functions are parameters.
- Algorithms which need to traverse the graph take a `edges` function which provides the reachable nodes.
  - `(node) => graph[node]`
  - `(node) => node.edges`


Graphs that are resolved asynchronously will have similar functions which
return `FutureOr`.
