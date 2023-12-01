% Поиск кратчайшего пути в графе

% Соединения в графе (путь, вес)
edge(a, b, 2).
edge(a, c, 1).
edge(b, d, 3).
edge(c, d, 2).
edge(c, e, 4).
edge(d, e, 1).

% Собственная реализация сортировки
bubble_sort(List, SortedList) :-
    (   bubbling(List, NewList),
        bubble_sort(NewList, SortedList)
    ;   SortedList = List
    ).

bubbling([X, Y | Rest], [Y, X | Rest]) :-
    edge(_, X, WeightX),
    edge(_, Y, WeightY),
    WeightX > WeightY.
bubbling([Z | Rest], [Z | NewRest]) :-
    bubbling(Rest, NewRest).

% Поиск пути в графе
path(Start, End, Path, Weight) :-
    travel(Start, End, [Start], Q, Weight),
    reverse(Q, Path).

travel(Current, End, Visited, [End | Visited], Weight) :-
    edge(Current, End, Weight).
travel(Current, End, Visited, Path, Weight) :-
    edge(Current, Next, Step),
    Next \== End,
    \+ member(Next, Visited),
    travel(Next, End, [Next | Visited], Path, RestWeight),
    Weight is Step + RestWeight.

% Поиск кратчайшего пути
shortest_path(Start, End, Path, Weight) :-
    findall([P, W], path(Start, End, P, W), Paths),
    bubble_sort(Paths, SortedPaths),
    member([Path, Weight], SortedPaths).

% Пример вызова
% Найти кратчайший путь от a до e
?- shortest_path(a, e, Path, Weight).
% Ожидаемый результат: Path = [a, c, d, e], Weight = 5.
