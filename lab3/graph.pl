% Найти кратчайший путь в графе

% Предикат findneighbor проверяет, является ли элемент соседом в списке соседей.
findneighbor([], _, X):- X is 0, !.
findneighbor([Neigh|_], Neigh, X):- X is 1, !.
findneighbor([_|Tail], Neigh, X):- findneighbor(Tail, Neigh, X), !.

% Предикат findnode находит узел в графе по его метке.
findnode([[Node|Neighbors]|_], Node, [Node|Neighbors]):-!.
findnode([_|Tail], Node, X):- findnode(Tail, Node, X).

% Предикат memberCheckSimple проверяет принадлежность элемента списку.
memberCheckSimple([], _, X):- X is 0, !.
memberCheckSimple([H|_], H, X):- X is 1, !.
memberCheckSimple([_|T], H, X):- memberCheckSimple(T, H, X).

% Предикат addvisit добавляет узел к списку посещенных, если он еще не был посещен.
addvisit([], _, ToVisit, ToVisit):-!.
addvisit([H|Neighbors], Visited, ToVisit, X):-
    memberCheckSimple(ToVisit, H, X1),
    memberCheckSimple(Visited, H, X2),
    (X1 =:= 0) ->(
    (X2 =:= 0) ->
    addvisit(Neighbors, Visited, [H|ToVisit], X)
    ;
    addvisit(Neighbors, Visited, ToVisit, X)
    );
    addvisit(Neighbors, Visited, ToVisit, X),
    !.

% Предикат bfshelper реализует вспомогательную функцию для BFS, обходящую граф в ширину.
bfshelper(_, [ToDest|_], X, ToDest, [ToDest|X]):-!.
bfshelper([[Head|Neighbors]|Tail], [CurrentVertex|ToVisit], Visited, ToDest, X):-
    findnode([[Head|Neighbors]|Tail], CurrentVertex, [_|[CurrentNeighbors|_]]),
    addvisit(CurrentNeighbors, [CurrentVertex|Visited], ToVisit, NewToVisit),
    memberCheckSimple(NewToVisit, CurrentVertex, X1),
    memberCheckSimple([CurrentVertex|Visited], CurrentVertex, X2),
    (X1 =:= 0) ->(
    (X2 =:= 0) ->
    bfshelper([[Head|Neighbors]|Tail], NewToVisit, [CurrentVertex|Visited], ToDest, [CurrentVertex|X])
    ;
    bfshelper([[Head|Neighbors]|Tail], NewToVisit, [CurrentVertex|Visited], ToDest, X)
    );
    bfshelper([[Head|Neighbors]|Tail], NewToVisit, [CurrentVertex|Visited], ToDest, X),
    !.

% Предикат bfs запускает поиск в ширину (BFS) в графе.
bfs([[Head|Neighbors]|Tail], From, To, X):-
    findnode([[Head|Neighbors]|Tail], From, [_|[StartNeighbors|_]]),
    bfshelper([[Head|Neighbors]|Tail], StartNeighbors, [From], To, X),
    !.
