% Правило для нахождения суммы четных цифр в числе
sum_even_digits(0, 0). % Базовый случай: сумма в пустом числе равна 0
sum_even_digits(N, Sum) :-
    N > 0,
    LastDigit is N mod 10, % Получаем последнюю цифру числа
    NewN is N // 10,       % Убираем последнюю цифру из числа
    (LastDigit mod 2 =:= 0 -> % Если цифра четная
        sum_even_digits(NewN, RestSum), % Рекурсивно считаем сумму в остатке числа
        Sum is RestSum + LastDigit
    ;
        sum_even_digits(NewN, Sum) % Если цифра нечетная, просто продолжаем рекурсию
    ).

% Пример использования:
% Вызов sum_even_digits(1234, Sum) вернет Sum = 6
% Вызов sum_even_digits(236, Sum) вернет Sum = 8
