function [E_V, D_V, v_col, v_row, result_matrix] = vector_operations(I, J)
    n = I;
    m = J;

    % Генерация вектора-столбца с случайными числами
    v_col = rand(n, 1) * 10;
    % Генерация вектора-строка с случайными числами
    v_row = rand(1, m) * 10;

    % Перемножение векторов
    result_matrix = v_col * v_row;

    % Вычисление математического ожидания
    E_V = sum(result_matrix(:)) / (n * m);
    
    % Вычисление дисперсии
    D_V = (sum(result_matrix(:).^2) / (n * m)) - E_V^2;

end
