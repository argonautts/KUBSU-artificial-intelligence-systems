move((_, _, StA), (Type, Number, StB)):-
    route(Type, Number, Stations),
    (   
      divide_list(Stations, [_, [StA, StB], _]);
      divide_list(Stations, [_, [StB, StA], _])
    ).

next(A, B, Used):-
    move(A, B), B = (_, _, Name),
    \+ member((_, _, Name), Used).

path_with_station(Path, Stations, PathWithStation):-
    member(Station, Stations),
    PathWithStation = [Station|Path].

bfs([HeadPath|_], ToStationName, _, Path):-
    HeadPath = [(_, _, ToStationName)|_], !,
    Path = HeadPath.
bfs([HeadPath|TailPath], ToStationName, Used, Path):-
    HeadPath = [HeadStation|_],
    findall(NextStation, next(HeadStation, NextStation, Used), AllNextStations),
    findall(NextPaths, path_with_station(HeadPath, AllNextStations, NextPaths), AllNextPaths),
    append(TailPath, AllNextPaths, NextBuffer),
    append(Used, AllNextStations, NextUsed),
    bfs(NextBuffer, ToStationName, NextUsed, Path).

path(From, To, Path):-
    bfs([[(no, no, From)]], To, [], ReversedPath),
    reverse(ReversedPath, Path).
   
/** <examples>
?- move((_, _, st1), X).
?- bfs([[(bus, 1, st1)]], st1, [], Path).
?- path(st1, st9, Path).
?- path(st1, st99, Path).
**/