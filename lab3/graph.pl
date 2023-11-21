% Определение графа
edge(a, b, 4).
edge(b, c, 1).
edge(a, c, 2).
edge(c, d, 1).
edge(b, d, 5).

% Двунаправленные ребра
connected(X, Y, Z) :- edge(X, Y, Z); edge(Y, X, Z).

% Поиск кратчайшего пути
shortest_path(Start, Finish, Path, Length) :-
    dijkstra([0-Start], Finish, [Start], RevPath, Length),
    reverse(RevPath, Path).

dijkstra(Queue, Finish, Visited, Path, Length) :-
    select(MinDist-Node, Queue, RestQueue),
    ( Node == Finish ->
        Path = Visited,
        Length = MinDist
    ;   findall(Dist-Next, (connected(Node, Next, Weight), \+ memberchk(Next, Visited), Dist is MinDist + Weight), Neighbors),
        append(RestQueue, Neighbors, NewQueue),
        sort(NewQueue, SortedQueue),
        dijkstra(SortedQueue, Finish, [Node|Visited], Path, Length)
    ).

% Пример запроса: shortest_path(a, d, Path, Length).
