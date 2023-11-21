% 1. Реверс списка
% 2. Удаление в списке элемента под заданым номером
% 3. Сколько раз повторяется эл-т в списке 

main :- write('Hello World!').
% reverseList([1,2,3], ReversedList).
reverseList([H|T], ReversedList):-
    reverseListHelper(T,[H], ReversedList).
    reverseListHelper([], Acc, Acc).
reverseListHelper([H|T], Acc, ReversedList):-
    reverseListHelper(T, [H|Acc], ReversedList).

