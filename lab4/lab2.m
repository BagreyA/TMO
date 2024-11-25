% Параметры размерности векторов
I = 23;  % Число строк в векторе-столбце
J = 13;  % Число столбцов в векторе-строке

% Вызов функции
[E_V, D_V, v_col, v_row, result_matrix] = vector_operations(I, J);

% Вывод результатов
fprintf('Вектор-столбец:\n');
disp(v_col);
    
fprintf('Вектор-строка:\n');
disp(v_row);
    
fprintf('Результирующая матрица:\n');
disp(result_matrix);
    
fprintf('Математическое ожидание E[V]: %.4f\n', E_V);
fprintf('Дисперсия D[V]: %.4f\n', D_V);
