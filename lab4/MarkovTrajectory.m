function trajectory = MarkovTrajectory(P, N, s)
    % P - матрица переходов
    % N - количество шагов (итераций)
    % s - начальное состояние (узел)

    L = size(P, 1); % Количество узлов
    trajectory = zeros(1, N);
    trajectory(1) = s; % Сохранение начального состояния
    
    for k = 2:N
        r = rand(); % Генерация случайного числа
        cum_prob = 0; % Кумулятивная вероятность

        for j = 1:L
            cum_prob = cum_prob + P(trajectory(k-1), j);
            if r <= cum_prob
                trajectory(k) = j; % Переход к следующему узлу
                break;
            end
        end
    end
end
