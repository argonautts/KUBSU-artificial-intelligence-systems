% Проверка, является ли число членом последовательности Фибоначчи
is_fibonacci(N) :-
    fibonacci(0, 1, N).

% Рекурсивно вычисляем числа Фибоначчи
fibonacci(A, _, A).
fibonacci(A, B, N) :-
    C is A + B,
    fibonacci(B, C, N).
