# Graphs Toolkit

<div align="center">

  Idiomas:
  
  [![Português](https://img.shields.io/badge/Language-Portugues-blue?style=for-the-badge)](README.pt-br.md)
  [![Inglês](https://img.shields.io/badge/Language-Ingles-blue?style=for-the-badge)](README.en.md)
</div>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Representação da estrutura de dados `grafo` por meio de `lista de adjacência`.

&nbsp;&nbsp;&nbsp;&nbsp;Estrutura implementada inteiramente em `Dart` com métodos de inserção e exclusão de vértices e arestas para criação e manipulação de grafos orientados e não orientados.

&nbsp;

Conteúdo

- [O que é um grafo](#o-que-é-um-grafo)
  - [Orientado](#orientado)
  - [Não orientado](#não-orientado)

- [O que é um vértice](#o-que-é-um-vértice)
  - [Null vertex](#null-vertex)

- [O que é uma aresta](#o-que-é-uma-aresta)

- [Métodos básicos de um grafo](#métodos-básicos-de-um-grafo)
  - [GetV](#getv)
  - [Adicionar vértices do modo básico](#adicionar-vértices-do-modo-básico)
  - [Adicionar vértices com addVertex](#adicionar-vértices-com-addvertex)
  - [Excluir um vértice](#excluir-um-vértice)
  - [First](#first)
  - [Last](#last)
  - [Breadth First Search - Bfs](#breadth-first-search---bfs)
  - [Depth First Search - Dfs](#depth-first-search---dfs)
  - [Has cycle](#has-cycle)

- [Métodos de um grafo orientado](#métodos-de-um-grafo-orientado)
  - [Num of edges](#num-of-edges)
  - [Get all edges](#get-all-edges)
  - [Is strongly connected](#is-strongly-connected)
  - [Is DAG](#is-dag)
  - [To string](#to-string)
  - [Print](#print)

- [Métodos de grafo não orientado](#métodos-de-um-grafo-não-orientado)
  - [Num of edges](#num-of-edges-1)
  - [Get all edges](#get-all-edges-1)
  - [Is connected](#is-connected)
  - [Is tree](#is-tree)
  - [Is forest](#is-forest)
  - [To string](#to-string-1)
  - [Print](#print-1)

- [Métodos de um vértice](#métodos-de-um-vértice)
  - [Add edge](#add-edge)
  - [Exclude edge](#exclude-edge)
  - [Vertices of edges list](#vertices-of-edges-list)
  - [Is sinkhole](#is-sinkhole)
  - [Is generator](#is-generator)
  - [Entry degree](#entry-degree)
  - [Exit degree](#exit-degree)

&nbsp;

## O que é um Grafo

&nbsp;&nbsp;&nbsp;&nbsp;Um grafo é uma estrutura de dados composta por dois elementos, um conjunto de vértices ([ver definicao](#o-que-é-um-vértice)) e um conjunto de arestas ([ver definicao](#o-que-é-uma-aresta)). Podem ser do tipo orientado ([ver definicao](#orientado)) ou não orientado ([ver definicao](#não-orientado)).

&nbsp;

### Orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos orientados, também conhecidos por digrafos, são aqueles nos quais as suas arestas possuem um sentido definido, ou seja, de um vértice `u` pode-se chegar em `v` mas oposto não ocorre, não há uma relação simétrica. Graficamente podem ser representados da seguinte forma:

&nbsp;

<p align="center">
  <img height="180" src="readme_resources/imgs/oriented_graph.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Já que possuem um sentido definido, podem os seus vértices podem ter arestas que saem e chegam neles mesmos:

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/oriented_graph_2.png">
</p>

&nbsp;

### Não Orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos não orientados são aqueles nos quais as suas arestas não possuem um sentido definido, pode-se ir tanto de `u` para `v` quanto de `v` para `u`, ou seja, ocorre a relação de simetria. Graficamente podem ser representados da seguinte forma:

&nbsp;

<p align="center">
  <img height="180" src="readme_resources/imgs/not_oriented_graph.png">
</p>

&nbsp;

## O que é um Vértice

&nbsp;&nbsp;&nbsp;&nbsp;Um vértice, também conhecido por nó, e a unidade fundamental para a composição de um grafo. A partir das suas composições com arestas muitos problemas podem ser resolvidos através da sua modelagem. No caso da implementação deste *`package`*, um vértice possui um identificador para diferenciá-lo dos demais, pode armazenar um valor numérico em `value` e possui uma lista de arestas nos quais indica com quais outros vértices este está conectado.

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/vertex.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Caso um `value` não seja definido inicialmente, nesta implementação ele terá o valor `0`.

&nbsp;

### *Null* vertex

&nbsp;&nbsp;&nbsp;&nbsp;Para esta implementação foi necessária a criação de um vértice `nulo`, ou seja, um vértice que **`jamais`** deve ser instanciado para compor um grafo, apenas utilizado para verificar a sua existência em alguns casos, como no retorno do método `getv()` ([ver método](#getv)).

&nbsp;&nbsp;&nbsp;&nbsp;Caso um vértice nulo esteja sendo adicionado a um grafo, uma `excessao` será levantada.

&nbsp;

<p align="center">
  <img height="120" src="readme_resources/imgs/null_vertex_assert.png">
</p>

&nbsp;

## O que é uma aresta

&nbsp;&nbsp;&nbsp;&nbsp;Uma aresta tem a função de conectar dois vértices além de definir de qual tipo um grafo será, orientado ou não orientado.

&nbsp;&nbsp;&nbsp;&nbsp;Arestas orientadas possuem um sentido definido, ou seja, há somente um caminho a ser seguido:

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/oriented_edge.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Arestas não orientadas não possuem um sentido definido, podendo conectar dois vértices no sentido de ida e volta:

&nbsp;

<p align="center">
  <img height="100" src="readme_resources/imgs/not_oriented_edge.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Em ambos os tipos, as arestas podem armazenar um peso numérico:

<p align="center">
  <img height="200" src="readme_resources/imgs/edge_weigth.png">
</p>

&nbsp;

&nbsp;&nbsp;&nbsp;&nbsp;Caso um peso não seja passado, nesta implementação ele será `nulo`.

&nbsp;

## Métodos básicos de um grafo

&nbsp;&nbsp;&nbsp;&nbsp;Tanto grafos orientados quanto os não orientados possuem atributos e métodos em comum. A partir disso, muitas funcionalidades presentes neste *Package* estão implementadas para os dois tipos de estrutura, mostradas nesta sessão.

&nbsp;

### GetV

&nbsp;&nbsp;&nbsp;&nbsp;Este método consiste em buscar um vértice no grafo através do seu identificador. Caso exista, ele será retornado, se não, será lançado um `[StateError]`.

```Dart
  final myGraph = OrientedGraph();

  myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
  myGraph.addVertex(newVertex: Vertex(label: '2'));
  myGraph.addVertex(newVertex: Vertex(label: '3'));

  myGraph.getV('1');  // return Vertex(label: '1')

  myGraph.getV('w');  // throw `[StateError]`
```

&nbsp;

### Adicionar vértices do modo básico

&nbsp;&nbsp;&nbsp;&nbsp;Como a estrutura padrão para grafos são listas, então adicionando novos vértices e arestas a elas, o grafo será modelado. Um primeiro método para isso consiste em primeiramente adicionar os vértices necessários ao grafo:

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));
    myGraph.vertices.add(Vertex(label: 'y'));
    myGraph.vertices.add(Vertex(label: 'x'));
    myGraph.vertices.add(Vertex(label: 'w'));
    myGraph.vertices.add(Vertex(label: 'z'));
```

&nbsp;&nbsp;&nbsp;&nbsp;Após todos os vértices serem definidos, as suas arestas precisam ser adicionadas. Para isso em cada vértice e preciso chamar a função `addEdge` para que a conexão entre eles seja feita. **Recomenda-se** utilizar o método `getV` para encontrar o vértice desejado para uma melhor leitura do código, entre o vértice de origem e o de destino.

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

&nbsp;&nbsp;&nbsp;&nbsp;Vale ressaltar que, como aqui todos os vértices são feitos de maneira manual, caso seja um grafo `não orientado`, e necessário fazer as arestas de volta também, para que a estrutura computacional corresponda a modelagem.

&nbsp;

### Adicionar vértices com addVertex

&nbsp;&nbsp;&nbsp;&nbsp;Uma segunda maneira de se povoar um grafo e através do método `addVertex`. Esta função consiste em encapsular toda a criação de um vértice e criação das suas arestas para outros vértices mesmo que eles ainda não tenham sido criados.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y']);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x']);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z']);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z']);
```

&nbsp;&nbsp;&nbsp;&nbsp;No exemplo acima, quando o vértice `u` e criado, tanto o vértice `v` quando `x` ainda não existem no grafo, mas este método os armazena em uma lista de espera, até que eles sejam difinitivamente criados, assim as arestas necessárias serão criadas e o grafo seguir a modelagem desejada.

&nbsp;&nbsp;&nbsp;&nbsp;Além de definir as conexoes com arestas baseados em `connectedTo`, também e possível passar pesos para as arestas através do parâmetro `edgeWeigth`. Este parâmetro consiste em uma lista de valores para os pesos, dessa forma, posicionalmente com a lista `connectedTo`, as arestas terão um peso definido a cada uma. O valor `null` também pode ser atribuido a peso de arestas.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x'], edgeWeigth: [null, 2]);
    myGraph.addVertex(newVertex: Vertex(label: 'v'), connectedTo: ['y'], edgeWeigth: []);
    myGraph.addVertex(newVertex: Vertex(label: 'y'), connectedTo: ['x'], edgeWeigth: [null]);
    myGraph.addVertex(newVertex: Vertex(label: 'x'), connectedTo: ['v']);
    myGraph.addVertex(newVertex: Vertex(label: 'w'), connectedTo: ['y', 'z'], edgeWeigth: [6]);
    myGraph.addVertex(newVertex: Vertex(label: 'z'), connectedTo: ['z'], edgeWeigth: [8]);
```

&nbsp;&nbsp;&nbsp;&nbsp;No exemplo acima existem 4 meneiras de atribuir valores nulos para o peso de arestas: não utilizando o parâmetro `edgeWeigth` *(linha 6)*, utilizando uma lista vazia *(linha 4)*, utilizando explicitamente `null` *(linhas 3 e 5)* e omitindo o valor do ultimo peso *(linha 7)*

&nbsp;&nbsp;&nbsp;&nbsp;Dentre as vantagens que este método possui em relação ao básico, pode-se citar principalmente a redução na quantidade de código, principalmente em grafos não orientados, pois neles a adição de arestas é sempre dobrada, como mostra o exemplo abaixo:

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

&nbsp;&nbsp;&nbsp;&nbsp;Outra vantagem que este método possui e a legibilidade do código, pois em um mesmo comando sabe qual vértice está sendo criado, para quais outros ele possui uma aresta e os pesos declarados para cada aresta.

&nbsp;

### Excluir um vértice

&nbsp;&nbsp;&nbsp;&nbsp;Exclui um vértice do grafo pelo seu identificador juntamente com as arestas que saem e chegam nele.

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

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o primeiro vértice da lista de vértices do grafo.

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

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o ultimo vértice da lista de vértices do grafo.

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

&nbsp;&nbsp;&nbsp;&nbsp;`Busca em largura` em um grafo consiste em calcular a distância para todos os vértices alcançáveis a partir de um vértice de origem. Esse método causa um efeito colateral no grafo, gerando uma `árvore de busca em largura`.

&nbsp;&nbsp;&nbsp;&nbsp;A árvore resultante e definida através do parâmetro `ancestor` em cada vértice, no qual armazena o vértice anterior e a distância calculada e guardada em `value`. Conforme o algoritmo percorre o grafo, o parâmetro `visited` em cada vértice se torna verdadeiro.

&nbsp;

### Depth First Search - Dfs

&nbsp;&nbsp;&nbsp;&nbsp;`Busca em profundidade` em um grafo consiste em, a cada vértice do grafo, explorar o quanto for possível as suas listas de adjacência até ir para o próximo vértice não visitado. Esse método causa um efeito colateral no grafo, gerando uma `floresta de busca em profundidade`, ou seja, contém várias árvores de busca em profundidade.

&nbsp;&nbsp;&nbsp;&nbsp;Os parâmetros `value`, `ancestor` e `visited` armazenam a distância calculada, o vértice anterior e a identificação de visitado respectivamente.

&nbsp;

### Has cycle

&nbsp;&nbsp;&nbsp;&nbsp;Método que retorna verdadeiro se houver algum ciclo no grafo.

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

## Métodos de um grafo orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos orientados possuem características e métodos exclusivos de sua estrutura, nas quais serão mostradas nesta sessão.

&nbsp;

### Num of edges

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o número de arestas presentes em um grafo orientado, somando a quantidade de arestas presente em cada vértice.

&nbsp;

### Get all edges

&nbsp;&nbsp;&nbsp;&nbsp;Retorna uma lista com todas as arestas presentes em um grafo orientado.

&nbsp;

### Is strongly connected

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se o grafo orientado é fortemente conexo, ou seja, se para cada par de vértices (`u`,`v`), `v` e acessível a partir de `u`

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/strongly_connected.png">
</p>

&nbsp;

### Is DAG

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se o grafo é um DAG (grafo acíclico orientado)

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/dag.png">
</p>

&nbsp;

### To string

&nbsp;&nbsp;&nbsp;&nbsp;Método no qual mostra uma versão simplificada do grafo na linha de comando utilizando `listas de adjacência`.

```Dart
    print(myGraph.toString());

    (1) - [ (2) (3) ]
    (2) - [ ]
    (3) - [ ]
```

&nbsp;

### Print

&nbsp;&nbsp;&nbsp;&nbsp;Método mais robusto para mostrar o conteudo de um grafo orientado na linha de comando. Mostra utilizando listas de adjacência com alguns parâmetros opcionais. Valores `nulos` não são mostrados.

```Dart
    myGraph.print();

      (1) -----> (2)
          -----> (3)

      (2)

      (3) -----> (3)
```

&nbsp;&nbsp;&nbsp;&nbsp;Os valores associados a cada vértice podem ser mostrados com o parâmetro `vertexValue`, seguindo o padrão (`label`:`value`):

```Dart
    myGraph.print(vertexValue: true);
      
      (1:5) -----> (2:4)
            -----> (3:10)

      (2:4)

      (3:10) -----> (3:10)
```

&nbsp;&nbsp;&nbsp;&nbsp;Os pesos de cada aresta também podem ser mostrados com o parâmetro `edgeWeigth`:

```Dart
    myGraph.print(edgeWeigth: true);
    
    (1) --1--> (2)
        --2--> (3)

    (2)

    (3) --8--> (3)
```

&nbsp;

## Métodos de um grafo não orientado

&nbsp;&nbsp;&nbsp;&nbsp;Grafos não orientados possuem caracteristicas e métodos exclusivos de sua estrutura, nas quais serão mostradas nesta sessão.

&nbsp;

### *Num of edges*

&nbsp;&nbsp;&nbsp;&nbsp;Retorna o número de arestas presentes em um grafo não orientado, seguindo a equacao abaixo:

```Dart
  numero_total_de_vertices ~/ 2
```

&nbsp;&nbsp;&nbsp;&nbsp;pois para grafos não orientados, as arestas repetidas mas com sentido oposto são consideradas as mesmas.

&nbsp;

### *Get all edges*

&nbsp;&nbsp;&nbsp;&nbsp;Retorna uma lista com todas as arestas presentes em um grafo não orientado orientado, incluindo arestas de `ida` e de `volta`.

&nbsp;

### Is connected

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se um grafo não orientado e conexo, ou seja, se a partir de um vértice pode-se chegar a todos os outros.

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/is_connected.png">
</p>

&nbsp;

### Is tree

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se um grafo não orientado é acíclico e conexo.

&nbsp;

<p align="center">
  <img height="250" src="readme_resources/imgs/is_tree.png">
</p>

&nbsp;

### Is forest

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se um grafo é não orientado e acíclico

&nbsp;

<p align="center">
  <img height="200" src="readme_resources/imgs/is_forest.png">
</p>

&nbsp;

### *To string*

&nbsp;&nbsp;&nbsp;&nbsp;Método no qual mostra uma versão simplificada do grafo na linha de comando utilizando `listas de adjacência`.

```Dart
    print(myGraph.toString());

    (1) - [ (2) (3) ]
    (2) - [ (1) ]
    (3) - [ (1) ]
```

&nbsp;

### *Print*

&nbsp;&nbsp;&nbsp;&nbsp;Método mais robusto para mostrar o conteudo de um grafo não orientado na linha de comando. Mostra utilizando listas de adjacência com alguns parâmetros opcionais. Valores `nulos` não são mostrados.

```Dart
    myGraph.print();
  
    (1) ----- (2)
        ----- (3)

    (2) ----- (1)
    
    (3) ----- (1)
```

&nbsp;&nbsp;&nbsp;&nbsp;Os valores associados a cada vértice podem ser mostrados com o parâmetro `vertexValue`, seguindo o padrão (`label`:`value`):

```Dart
    myGraph.print(vertexValue: true);
    
    (1:5) ----- (2:4)
          ----- (3:10)
    
    (2:4) ----- (1:5)
    
    (3:10) ----- (1:5)
```

&nbsp;&nbsp;&nbsp;&nbsp;Os pesos de cada aresta também podem ser mostrados com o parâmetro `edgeWeigth`:

```Dart
    myGraph.print(edgeWeigth: true);
  
    (1) --1-- (2)
        --2-- (3)
    
    (2) --5-- (1)
    
    (3) --10-- (1)
```

&nbsp;

## Métodos de um vértice

&nbsp;&nbsp;&nbsp;&nbsp;Métodos exclusivos de um vértice, alguns deles podem ser somente para grafos `orientados` e, caso sejam utilizados em grafos não orientados, uma mensagem de erro será retornada.

&nbsp;

### Add edge

&nbsp;&nbsp;&nbsp;&nbsp;Cria uma nova aresta e a adiciona na lista de arestas daquele vértice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));
```

&nbsp;&nbsp;&nbsp;&nbsp;A nova aresta pode ser criada com `peso`, caso não seja passado, será `null`.

```Dart
    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'), weigth: 5);
```

&nbsp;

### Exclude edge

&nbsp;&nbsp;&nbsp;&nbsp;Remove uma aresta da lista de arestas deste vértice pelo identificador do vértice de destino.

```Dart
    final myGraph = OrientedGraph();

    myGraph.vertices.add(Vertex(label: 'u'));
    myGraph.vertices.add(Vertex(label: 'v'));

    myGraph.getV('u').addEdge(connectedTo: myGraph.getV('v'));

    myGraph.getV('u').excludeEdge('v');
```

&nbsp;

### Vertices of edges list

&nbsp;&nbsp;&nbsp;&nbsp;Retorna a lista de adjacência do vértice a partir da `edgesList`.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: 'u'), connectedTo: ['v', 'x']);

    myGraph.getV('u').verticesOfEdgesList   //[Vertex(label: 'v'), Vertex(label: 'x')]
```

&nbsp;

### Is sinkhole

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se naquele vértice há somente arestas que chegam nele, ou seja, não há arestas saindo. Válido somente para `grafos orientados`.

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

&nbsp;&nbsp;&nbsp;&nbsp;Verifica se naquele vértice há somente arestas que saem dele, ou seja, não há arestas chegando. Válido somente para `grafos orientados`.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').isSinkhole;   // true
```

&nbsp;

### Entry degree

&nbsp;&nbsp;&nbsp;&nbsp;Número de arestas que `entram` no vértice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').entryDegree;   // 0
```

&nbsp;

### Exit degree

&nbsp;&nbsp;&nbsp;&nbsp;Número de arestas que `saem` do vértice.

```Dart
    final myGraph = OrientedGraph();

    myGraph.addVertex(newVertex: Vertex(label: '1'), connectedTo: ['2', '3']);
    myGraph.addVertex(newVertex: Vertex(label: '2'));
    myGraph.addVertex(newVertex: Vertex(label: '3'));

    myGraph.getV('1').entryDegree;   // 2
```
