# Graphs Toolkit

<div align="center">

  Linguagens:
  
  [![Portuguese](https://img.shields.io/badge/Language-Portugues-blue?style=for-the-badge)](README.pt-br.md)
  [![English](https://img.shields.io/badge/Language-Ingles-blue?style=for-the-badge)](README.en.md)
</div>

&nbsp;

Representacao da estrutura de dados `grafo` por meio de `lista de adjacencia`.

Estrutura implementada inteiramente em `Dart` com metodos de insercao e exclusao de vertices e arestas para criacao e manipulacao de grafos orientados e nao orientados.

&nbsp;

Conteudo

- [O que um grafo](#o-que-e-um-grafo)
  - [Orientado](#orientado)
  - [Nao orientado](#nao-orientado)

- [O que e um vertice](#o-que-e-um-vertice)
  - [Null vertex](#null-vertex)

- [O que uma aresta](#o-que-e-uma-aresta)

- [Metodos basicos de um grafo](#metodos-basicos-de-um-grafo)
  - [GetV](#getv)
  - [Adicionar vertices do modo basico](#adicionar-vertices-do-modo-basico)
  - [Adicionar vertices com addVertex](#adicionar-vertices-com-addvertex)
  - [Excluir um vertice](#excluir-um-vertice)
  - [First](#first)
  - [Last](#last)
  - [Breadth First Search - Bfs](#breadth-first-search---bfs)
  - [Depth First Search - Dfs](#depth-first-search---dfs)
  - [Has cycle](#has-cycle)

- [Metodos de um grafo orientado](#metodos-de-um-grafo-orientado)
  - [Num of edges](#num-of-edges)
  - [Get all edges](#get-all-edges)
  - [Is strongly connected](#is-strongly-connected)
  - [Is DAG](#is-dag)
  - [To string](#to-string)
  - [Print](#print)

- [Metodos de grafo nao orientado](#metodos-de-um-grafo-nao-orientado)
  - [Num of edges](#num-of-edges-1)
  - [Get all edges](#get-all-edges-1)
  - [Is connected](#is-connected)
  - [Is tree](#is-tree)
  - [Is forest](#is-forest)
  - [To string](#to-string-1)
  - [Print](#print-1)

- [Metodos de um vertice](#metodos-de-um-vertice)
  - [Add edge](#add-edge)
  - [Exclude edge](#exclude-edge)
  - [Vertices of edges list](#vertices-of-edges-list)
  - [Is sinkhole](#is-sinkhole)
  - [Is generator](#is-generator)
  - [Entry degree](#entry-degree)
  - [Exit degree](#exit-degree)

&nbsp;

## O que e um grafo

&nbsp;

### Orientado

&nbsp;

### Nao Orientado

&nbsp;

## O que e um Vertice

&nbsp;

### *Null* vertex

&nbsp;

## O que e uma aresta

&nbsp;

## Metodos basicos de um grafo

&nbsp;&nbsp;&nbsp;&nbsp;Tanto grafos orientados quanto os nao orientados possuem atributos e metodos em comum. A partir disso, muitas funcionalidades presentes neste *Package* estao implementadas para os dois tipos de estrutura, mostradas nesta sessao.

&nbsp;

### GetV

&nbsp;&nbsp;&nbsp;&nbsp;Este metodo consiste em buscar um vertice no grafo atraves do seu identificador. Caso exista, ele sera retornado, se nao, um `NullVertex` sera retornado.

```Dart
  final myGraph = OrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
  myGraph.addVertex(newVertex: Vertex(label: '2'));
  myGraph.addVertex(newVertex: Vertex(label: '3'));

  myGraph.getV('1');  // return Vertex(label: '1')

  myGraph.getV('w');  // return NullVertex
```

&nbsp;

### Adicionar vertices do modo basico

&nbsp;&nbsp;&nbsp;&nbsp;Como a estrutura padrao para grafos sao listas, entao adicionando novos vertices e arestas a elas, o grafo sera modelado. Um primeiro metodo para isso consiste em primeiramente adicionar os vertices necessarios ao grafo:

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));
    myGraph.vertices.add(Vertex(label: 'y'));
    myGraph.vertices.add(Vertex(label: 'x'));
    myGraph.vertices.add(Vertex(label: 'w'));
    myGraph.vertices.add(Vertex(label: 'z'));
```

&nbsp;&nbsp;&nbsp;&nbsp;Apos todos os vertices serem definidos, as suas arestas precisam ser adicionadas. Para isso em cada vertice e preciso chamar a funcao `addEdge` para que a conexao entre eles seja feita. **Recomenda-se** utilizar o metodo `getV` para encontrar o vertice desejado para uma melhor leitura do codigo, entre o vertice de origem e o de destino.

```Dart
    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('y'));

    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('z'));

    myGraph.getV('z').addEdge(connectedTo: myGraph.getV('z'));
```

&nbsp;&nbsp;&nbsp;&nbsp;Vale ressaltar que, como aqui todos os vertices sao feitos de maneira manual, caso seja um grafo `nao orientado`, e necessario fazer as arestas de volta tambem, para que a estrutura computacional corresponda a modelagem.

&nbsp;

### Adicionar vertices com addVertex

&nbsp;&nbsp;&nbsp;&nbsp;Uma segunda maneira de se povoar um grafo e atraves do metodo `addVertex`. Esta funcao consiste em encapsular toda a criacao de um vertice e criacao das suas arestas para outros vertices mesmo que eles ainda nao tenham sido criados.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);
```

&nbsp;&nbsp;&nbsp;&nbsp;No exemplo acima, quando o vertice `u` e criado, tanto o vertice `v` quando `x` ainda nao existem no grafo, mas este metodo os armazena em uma lista de espera, ate que eles sejam difinitivamente criados, assim as arestas necessarias serao criadas e o grafo seguira a modelagem desejada.

&nbsp;&nbsp;&nbsp;&nbsp;Alem de definir as conexoes com arestas baseados em `connectedTo`, tambem e possivel passar pessos para as arestas atraves do parametro `edgeWeigth`. Este parametro consiste em uma lista de valores para os pesos, dessa forma, posicionalmente com a lista `connectedTo`, as arestas terao um peso definido a cada uma. O valor `null` tambem pode ser atribuido a peso de arestas.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);
```

&nbsp;&nbsp;&nbsp;&nbsp;No exemplo acima existem 4 meneiras de atribuir valores nulos para o peso de arestas: nao utilizando o parametro `edgeWeigth` *(linha 6)*, utilizando uma lista vazia *(linha 4)*, utilizando explicitamente `null` *(linhas 3 e 5)* e omitindo o valor do ultimo peso *(linha 7)*

&nbsp;&nbsp;&nbsp;&nbsp;Dentre as vantagens que este metodo possui em relacao ao basico, pode-se citar principalmente a reducao na quantidade de codigo, principalmente em grafos nao orientados, pois neles a adicao de arestas e sempre dobrada, como mostra o exemplo abaixo:

```Dart

    final myGraph = NotOrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));
    myGraph.vertices.add(Vertex(label: 'y'));
    myGraph.vertices.add(Vertex(label: 'x'));
    myGraph.vertices.add(Vertex(label: 'w'));
    myGraph.vertices.add(Vertex(label: 'z'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('u'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('x'));
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('u'));

    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('x'));
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('v'));
    
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('v').addEdge(connectedTo: myGraph.getV('x'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('y'));
    myGraph.getV('y').addEdge(connectedTo: myGraph.getV('w'));

    myGraph.getV('w').addEdge(connectedTo: myGraph.getV('z'));
    myGraph.getV('z').addEdge(connectedTo: myGraph.getV('w'));


    final myGraph2 = NotOrientedGraph();

    myGraph2.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph2.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y', 'x']);
    myGraph2.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x', 'w']);
    myGraph2.addVertex(newVertex: Vertex(label: 'x'));
    myGraph2.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['z']);
    myGraph2.addVertex(newVertex: Vertex(label: 'z'));

    myGraph == myGraph2; // true
```

&nbsp;&nbsp;&nbsp;&nbsp;Outra vantagem que este metodo possui e a legibilidade do codigo, pois em um mesmo comando sabe qual vertice esta sendo criado, para quais outros ele possui uma aresta e os pesos declarados para cada aresta.

&nbsp;

### Excluir um vertice

&nbsp;&nbsp;&nbsp;&nbsp;Exclui um vertice do grafo pelo seu identificador juntamente com as arestas que saem e chegam nele.

```Dart
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
  myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
  myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

  myGraph.toString();

  // colocar o output

  myGraph.excludeVertex(vertexLabel: 'v');

  myGraph.toString();

  // colocar o output
```

&nbsp;

### First

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o primeiro vertice da lista de vertices do grafo.

```Dart
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
  myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
  myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

  myGraph.first   // Vertex(label: 'u')
```

&nbsp;

### Last

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o ultimo vertice da lista de vertices do grafo.

```Dart
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
  myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
  myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

  myGraph.last   // Vertex(label: 'z')
```

&nbsp;

### Breadth First Search - Bfs

&nbsp;

### Depth First Search - Dfs

&nbsp;

### Has cycle

&nbsp;&nbsp;&nbsp;&nbsp;Metodo que retorna verdadeiro se houver algum ciclo no grafo.

```Dart
  final myGraph = NotOrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
  myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
  myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
  myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
  myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
  myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);

  myGraph.hasCycle   // true
```

&nbsp;

## Metodos de um grafo orientado

&nbsp;

### Num of edges

&nbsp;

### Get all edges

&nbsp;

### Is strongly connected

&nbsp;

### Is DAG

&nbsp;

### To string

&nbsp;

### Print

&nbsp;

## Metodos de um grafo nao orientado

&nbsp;

### *Num of edges*

&nbsp;

### *Get all edges*

&nbsp;

### Is connected

&nbsp;

### Is tree

&nbsp;

### Is forest

&nbsp;

### *To string*

&nbsp;

### *Print*

&nbsp;

## Metodos de um vertice

&nbsp;&nbsp;&nbsp;&nbsp;Metodos exclusivos de um vertice, alguns deles podem ser somente para grafos `orientados` e, caso sejam utilizados em grafos nao orientados, uma mensagem de erro sera retornada.

&nbsp;

### Add edge

&nbsp;&nbsp;&nbsp;&nbsp;Cria uma nova aresta e a adiciona na lista de arestas daquele vertice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
```

&nbsp;&nbsp;&nbsp;&nbsp;A nova aresta pode ser criada com `peso`, caso nao seja passado, sera `null`.

```Dart
    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'), weigth: 5);
```

&nbsp;

### Exclude edge

&nbsp;&nbsp;&nbsp;&nbsp;Remove uma aresta da lista de arestas deste vertice pelo identificador do vertice de destino.

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('u').excludeEdge('v');
```

&nbsp;

### Vertices of edges list

&nbsp;&nbsp;&nbsp;&nbsp;Retorna a lista de adjacencia do vertice a partir da `edgesList`.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);

    myGraph.getV('u').verticesOfEdgesList   //[Vertex(label: 'v'), Vertex(label: 'x')]
```

&nbsp;

### Is sinkhole

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se naquele vertice ha somente arestas que chegam nele, ou seja, nao ha arestas saindo. Valido somente para `grafos orientados`.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('2').isSinkhole;   // true
    myGraph.getV('3').isSinkhole;   // true
```

&nbsp;

### Is generator

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se naquele vertice ha somente arestas que saem dele, ou seja, nao ha arestas chegando. Valido somente para `grafos orientados`.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').isSinkhole;   // true
```

&nbsp;

### Entry degree

&nbsp;&nbsp;&nbsp;&nbsp;Numero de arestas que `entram` no vertice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').entryDegree;   // 0
```

&nbsp;

### Exit degree

&nbsp;&nbsp;&nbsp;&nbsp;Numero de arestas que `saem` do vertice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').entryDegree;   // 2
```
