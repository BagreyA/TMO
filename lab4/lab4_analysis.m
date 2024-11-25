% Определение параметров
L = 15; % Количество узлов
epsilon = 1e-5; % Заданная точность
max_iterations = 100; % Максимальное количество итераций

% Пример матрицы переходов (P)
P = [
    0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0;
    1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;
    1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0;
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1;
    0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1;
    0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0;
    1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];

% Нормализация матрицы P
for i = 1:L
    if sum(P(i, :)) ~= 0  % Проверка на нулевую строку
        P(i, :) = P(i, :) / sum(P(i, :));
    end
end

% Задание начального состояния и количества шагов
initial_node = 1; % Начальный узел
N = 100; % Количество шагов

% Вызов функции MarkovTrajectory
trajectory = MarkovTrajectory(P, N, initial_node);

% Отображение графика траектории
figure;
plot(trajectory, 'o-');
xlabel('Шаги');
ylabel('Узлы');
title('Траектория движения пакета по сети');
grid on;

% Расчеты вероятностей пребывания в узлах, первого перехода, кратчайшего пути и т.д.
m = 1; % начальное количество коммутаций
P_m = eye(L); % Инициализация P^m

% Инициализация переменных для расчетов
stay_probabilities = zeros(L, 1);
first_transition_probabilities = zeros(L, 1);
shortest_path_lengths = inf(L, 1);
expected_lengths = zeros(L, 1);
variances = zeros(L, 1);

while m <= max_iterations
    % Расчет вероятности пребывания пакета в узлах
    P_m = P_m * P; % P^m
    stay_probabilities = P_m(initial_node, :)'; % Вероятности пребывания в узлах

    % Вероятность первого перехода
    first_transition_probabilities = zeros(L, 1);
    for j = 1:L
        if m > 1
            first_transition_probabilities(j) = stay_probabilities(j) * prod(1 - P_m(initial_node, j) * ones(1, m-1));
        else
            first_transition_probabilities(j) = P(initial_node, j); % Для первого перехода
        end
    end

    % Длина кратчайшего пути
    for j = 1:L
        shortest_path_lengths(j) = min(shortest_path_lengths(j), m);
    end

    % Математическое ожидание длины пути
    expected_lengths = expected_lengths + (m * first_transition_probabilities);
    
    % Дисперсия длины пути
    variances = variances + (m^2 * first_transition_probabilities) - expected_lengths.^2;

    % Проверка условия завершения
    if all(first_transition_probabilities <= epsilon)
        break;
    end

    m = m + 1; % Увеличение итерации
end

% Отображение результатов
disp('Вероятности пребывания пакета в узлах:');
disp(stay_probabilities);

disp('Вероятности первого перехода пакета в узел:');
disp(first_transition_probabilities);

disp('Длины кратчайших путей:');
disp(shortest_path_lengths);

disp('Математическое ожидание длины пути:');
disp(expected_lengths);

disp('Дисперсия длины пути:');
disp(variances);

% Построение графиков зависимостей
figure;
subplot(2, 2, 1);
bar(stay_probabilities);
title('Вероятности пребывания пакета в узлах');
xlabel('Узлы');
ylabel('Вероятность');

subplot(2, 2, 2);
bar(first_transition_probabilities);
title('Вероятности первого перехода пакета');
xlabel('Узлы');
ylabel('Вероятность');

subplot(2, 2, 3);
bar(shortest_path_lengths);
title('Длину кратчайшего пути');
xlabel('Узлы');
ylabel('Длина');

subplot(2, 2, 4);
bar(expected_lengths);
title('Математическое ожидание длины пути');
xlabel('Узлы');
ylabel('Ожидание');

figure;
bar(variances);
title('Дисперсия длины пути');
xlabel('Узлы');
ylabel('Дисперсия');
