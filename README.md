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
  - [Bfs](#bfs)
  - [Dfs](#dfs)
  - [Has cicle](#has-cicle)

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

- [Metodos de uma aresta](#metodos-de-uma-aresta)

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
    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('y'));

    myGraph.getV('x').addEdge(connectedTo: myGraph.getV('v'));
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

    // dar um equals aqui pra mostrar que ta igual
```

&nbsp;&nbsp;&nbsp;&nbsp;Outra vantagem que este metodo possui e a legibilidade do codigo, pois em um mesmo comando sabe qual vertice esta sendo criado, para quais outros ele possui uma aresta e os pesos declarados para cada aresta.

&nbsp;

### Excluir um vertice

&nbsp;

### First

&nbsp;

### Last

&nbsp;

### Bfs

&nbsp;

### Dfs

&nbsp;

### Has cicle

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

&nbsp;

### Add edge

&nbsp;

### Exclude edge

&nbsp;

### Vertices of edges list

&nbsp;

### Is sinkhole

&nbsp;

### Is generator

&nbsp;

### Entry degree

&nbsp;

### Exit degree

&nbsp;

## Metodos de uma aresta
