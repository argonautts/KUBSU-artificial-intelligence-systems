% Вариант 7. Prolog найти произведение таких делителей числа, сумма цифр которых меньше
% чем сумма цифр исходного числа

% Предикат, который находит сумму цифр числа
sum_of_digits(0, 0). % Если число равно 0, то сумма цифр также равна 0.
sum_of_digits(N, Sum) :-
    N > 0,
    NextDigit is N mod 10, % вычисляем последнюю цифру числа и сохраняем её в NextDigit,
    Rest is N // 10, % вычисляем "остаток" числа без последней цифры и сохраняем его в Rest,
    sum_of_digits(Rest, RestSum), % рекурсивно вызываем sum_of_digits для остатка числа и получаем сумму цифр остатка (RestSum),
    Sum is RestSum + NextDigit. % суммируем NextDigit и RestSum, чтобы получить сумму цифр всего числа.

% Предикат, который находит делители числа с заданными условиями
find_divisors_with_condition(Number, Divisors) :-
    findall(Divisor,
            (between(1, Number, Divisor), % перебираем числа от 1 до Number
             0 is Number mod Divisor, % проверяем, что Number делится на Divisor без остатка,
             Divisor \= Number, % исключаем случай, когда Divisor равен самому Number
             sum_of_digits(Divisor, DivisorSum), % вычисляем сумму цифр делителя Divisor
             sum_of_digits(Number, NumberSum), % вычисляем сумму цифр исходного числа Number
             DivisorSum < NumberSum), % проверяем условие, что сумма цифр делителя меньше суммы цифр Number
            Divisors).

% Предикат, который вычисляет произведение элементов списка
product([], 1). % Если список пуст, произведение равно 1 (нейтральный элемент для умножения).
product([H | T], Result) :- % Если список не пуст,
    product(T, Rest), % рекурсивно вычисляем произведение оставшихся элементов списка и сохраняем его в Rest,
    Result is H * Rest. % вычисляем произведение текущего элемента H и Rest.

% Главный предикат для нахождения произведения делителей с заданными условиями
find_product_of_divisors(Number, Product) :-
    find_divisors_with_condition(Number, Divisors), % находим делители числа с заданными условиями
    product(Divisors, Product). % вычисляем произведение этих делителей и сохраняем его в Product.

% swipl lab/lab1.pl 
% find_product_of_divisors(24, Product).