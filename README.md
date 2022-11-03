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

&nbsp;&nbsp;&nbsp;&nbsp;Um grafo e uma estrutura de dados composta por dois elementos, um conjunto de vertices ([ver definicao](#o-que-e-um-vertice)) e um conjunto de arestas ([ver definicao](#o-que-e-uma-aresta)). Podem ser do tipo orientado ([ver definicao](#orientado)) ou nao orientado ([ver definicao](#nao-orientado)).

&nbsp;

### Orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos orientados, tambem conhecidos por digrafos, sao aqueles nos quais as suas arestas possuem um sentido definido, ou seja, de um vertice `u` podemos chegar em `v` mas oposto nao ocorre, nao ha uma relacao simetrica. Graficamente podem ser representados da seguinte forma:

&nbsp;

<p align="center">
  <img height="180" src="readme_resources/imgs/oriented_graph.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Ja que possuem um sentido definido, podem os seus vertices podem ter arestas que saem e chegam neles mesmos:

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/oriented_graph_2.png">
</p>

&nbsp;

### Nao Orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos nao orientados sao aqueles nos quais as suas arestas nao possuem um sentido definido, pode-se ir tanto de `u` para `v` quanto de `v` para `u`, ou seja, ocorre a relacao de simetria. Graficamente podem ser representados da seguinte forma:

&nbsp;

<p align="center">
  <img height="180" src="readme_resources/imgs/not_oriented_graph.png">
</p>

&nbsp;

## O que e um Vertice

&nbsp;&nbsp;&nbsp;&nbsp;Um vertice, tambem conhecido por no, e a unidade fundamental para a composicao de um grafo. A partir das suas composicoes com arestas muitos problemas podem ser resolvidos atraves da sua modelagem. No caso da implementacao deste *`package`*, um vertice possui um identificador para diferencia-lo dos demais, pode armazenar um valor numerico em `value` e possui uma lista de arestas nos quais indica com quais outros vertices este esta conectado.

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/vertex.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Caso um `value` nao seja definido inicialmente, nesta implementacao ele tera o valor `0`.

&nbsp;

### *Null* vertex

&nbsp;&nbsp;&nbsp;&nbsp;Para esta implementacao foi necessaria a criacao de um vertice `nulo`, ou seja, um vertice que **`jamais`** deve ser instanciado para compor um grafo, apenas utilizado para verificar a sua existecia em alguns casos, como no retorno do metodo `getv()` ([ver metodo](#getv)).

&nbsp;&nbsp;&nbsp;&nbsp;Caso um vertice nulo esteja sendo adicionado a um grafo, uma `excessao` sera levantada.

&nbsp;

<p align="center">
  <img height="120" src="readme_resources/imgs/null_vertex_assert.png">
</p>

&nbsp;

## O que e uma aresta

&nbsp;&nbsp;&nbsp;&nbsp;Uma aresta tem a funcao de conectar dois vertices alem de definir de qual tipo um grafo sera, orientado ou nao orientado.

&nbsp;&nbsp;&nbsp;&nbsp;Arestas orientadas possuem um sentido definido, ou seja, ha somente um caminho a ser seguido:

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/oriented_edge.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Arestas nao orientadas nao possuem um sentido definido, podendo conectar dois vertices no sentido de ida e volta:

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/not_oriented_edge.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Em ambos os tipos, as arestas podem armazenar um peso numerico:

<p align="center">
  <img height="200" src="readme_resources/imgs/edge_weigth.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Caso um peso nao seja passado, nesta implementacao ele sera `nulo`.

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

&nbsp;&nbsp;&nbsp;&nbsp;`Busca em largura` em um grafo consiste em calcular a distancia para todos os vertices alcancaveis a partir de um vertice de origem. Esse metodo causa um efeito colateral no grafo, gerando uma `arvore de busca em largura`.

&nbsp;&nbsp;&nbsp;&nbsp;A arvore resultante e definida atraves do parametro `ancestor` em cada vertice, no qual armazena o vertice anterior e a distancia calculada e guardada em `value`. Conforme o algoritmo percorre o grafo, o parametro `visited` em cada vertice se torna verdadeiro.

&nbsp;

### Depth First Search - Dfs

&nbsp;&nbsp;&nbsp;&nbsp;`Busca em profundidade` em um grafo consiste em, a cada vertice do grafo, explorar o quanto for possivel as suas listas de adjacencia ate ir para o proximo vertice nao visitado. Esse metodo causa um efeito colateral no grafo, gerando uma `floresta de busca em profundidade`, ou seja, contem varias arvores de busca em profundidade.

&nbsp;&nbsp;&nbsp;&nbsp;Os parametros `value`, `ancestor` e `visited` armazenam a distancia calculada, o vertice anterior e a identificacao de visitado respectivamente.

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

&nbsp;&nbsp;&nbsp;&nbsp;Grafos orientados possuem caracteristicas e metodos exclusivos de sua estrutura, nas quais serao mostradas nesta sessao.

&nbsp;

### Num of edges

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o numero de arestas presentes em um grafo orientado, somando a quantidade de arestas presente em cada vertice.

&nbsp;

### Get all edges

&nbsp;&nbsp;&nbsp;&nbsp;Retorna uma lista com todas as arestas presentes em um grafo orientado.

&nbsp;

### Is strongly connected

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se o grafo orientado e fortemente conexo, ou seja, se para cada par de vertices (`u`,`v`), `v` e acessivel a partir de `u`

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/strongly_connected.png">
</p>

&nbsp;

### Is DAG

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se o grafo e um DAG (grafo aciclico orientado)

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/dag.png">
</p>

&nbsp;

### To string

&nbsp;&nbsp;&nbsp;&nbsp;Metodo no qual mostra uma versao simplificada do grafo na linha de comando utilizando `listas de adjacencia`.

```Dart
    print(myGraph.toString());

    (1) - [ (2) (3) ]
    (2) - [ ]
    (3) - [ ]
```

&nbsp;

### Print

&nbsp;&nbsp;&nbsp;&nbsp;Metodo mais robusto para mostrar o conteudo de um grafo orientado na linha de comando. Mostra utilizando listas de adjacencia com alguns parametros opcionais. Valores `nulos` nao sao mostrados.

```Dart
    myGraph.print();

      (1) -----> (2)
          -----> (3)

      (2)

      (3) -----> (3)
```

Os valores associados a cada vertice podem ser mostrados com o parametro `vertexValue`, seguindo o padrao (`label`:`value`):

```Dart
    myGraph.print(vertexValue: true);
      
      (1:5) -----> (2:4)
            -----> (3:10)

      (2:4)

      (3:10) -----> (3:10)
```

Os pesos de cada aresta tambem podem ser mostrados com o parametro `edgeWeigth`:

```Dart
    myGraph.print(edgeWeigth: true);
    
    (1) --1--> (2)
        --2--> (3)

    (2)

    (3) --8--> (3)
```

&nbsp;

## Metodos de um grafo nao orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos nao orientados possuem caracteristicas e metodos exclusivos de sua estrutura, nas quais serao mostradas nesta sessao.

&nbsp;

### *Num of edges*

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o numero de arestas presentes em um grafo nao orientado, seguindo a equacao abaixo:

```Dart
  numero_total_de_vertices ~/ 2
```

&nbsp;&nbsp;&nbsp;&nbsp;pois para grafos nao orientados, as arestas repetidas mas com sentido oposto sao consideradas as mesmas.

&nbsp;

### *Get all edges*

&nbsp;&nbsp;&nbsp;&nbsp;Retorna uma lista com todas as arestas presentes em um grafo nao orientado orientado, incluindo arestas de `ida` e de `volta`.

&nbsp;

### Is connected

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se um grafo nao orientado e conexo, ou seja, se a partir de um vertice pode-se chegar a todos os outros.

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/is_connected.png">
</p>

&nbsp;

### Is tree

Verifica se um grafo nao orientado e aciclico e conexo.

&nbsp;

<p align="center">
  <img height="250" src="readme_resources/imgs/is_tree.png">
</p>

&nbsp;

### Is forest

Verifica se um grafo e nao orientado e aciclico

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/is_forest.png">
</p>

&nbsp;

### *To string*

&nbsp;&nbsp;&nbsp;&nbsp;Metodo no qual mostra uma versao simplificada do grafo na linha de comando utilizando `listas de adjacencia`.

```Dart
    print(myGraph.toString());

    (1) - [ (2) (3) ]
    (2) - [ (1) ]
    (3) - [ (1) ]
```

&nbsp;

### *Print*

&nbsp;&nbsp;&nbsp;&nbsp;Metodo mais robusto para mostrar o conteudo de um grafo nao orientado na linha de comando. Mostra utilizando listas de adjacencia com alguns parametros opcionais. Valores `nulos` nao sao mostrados.

```Dart
    myGraph.print();
  
    (1) ----- (2)
        ----- (3)

    (2) ----- (1)
    
    (3) ----- (1)
```

Os valores associados a cada vertice podem ser mostrados com o parametro `vertexValue`, seguindo o padrao (`label`:`value`):

```Dart
    myGraph.print(vertexValue: true);
    
    (1:5) ----- (2:4)
          ----- (3:10)
    
    (2:4) ----- (1:5)
    
    (3:10) ----- (1:5)
```

Os pesos de cada aresta tambem podem ser mostrados com o parametro `edgeWeigth`:

```Dart
    myGraph.print(edgeWeigth: true);
  
    (1) --1-- (2)
        --2-- (3)
    
    (2) --5-- (1)
    
    (3) --10-- (1)
```

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
