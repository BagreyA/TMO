% Установка значений входных параметров
lambda = 4; % Интенсивность поступления
mu = 5;     % Интенсивность обслуживания
rho = lambda / mu; % Коэффициент загрузки (должен быть < 1)

% Параметры моделирования
N = 1000; % Количество итераций
time = 0:N-1; % Время

% Модели

%% M/M/1
arrivals_mm1 = cumsum(exprnd(1/lambda, 1, N)); % Время поступления
services_mm1 = exprnd(1/mu, 1, N); % Время обслуживания
finish_mm1 = zeros(1, N);
for i = 1:N
    if i == 1
        finish_mm1(i) = arrivals_mm1(i) + services_mm1(i);
    else
        finish_mm1(i) = max(arrivals_mm1(i), finish_mm1(i-1)) + services_mm1(i);
    end
end

%% M/G/1
% Генерируем распределение обслуживания с использованием нормального распределения
services_mg1 = normrnd(1/mu, 0.1, 1, N); % Время обслуживания
finish_mg1 = zeros(1, N);
for i = 1:N
    if i == 1
        finish_mg1(i) = arrivals_mm1(i) + services_mg1(i);
    else
        finish_mg1(i) = max(arrivals_mm1(i), finish_mg1(i-1)) + services_mg1(i);
    end
end

%% G/M/1
arrivals_gm1 = cumsum(exprnd(1/lambda, 1, N)); % Время поступления
services_gm1 = exprnd(1/mu, 1, N); % Время обслуживания
finish_gm1 = zeros(1, N);
for i = 1:N
    if i == 1
        finish_gm1(i) = arrivals_gm1(i) + services_gm1(i);
    else
        finish_gm1(i) = max(arrivals_gm1(i), finish_gm1(i-1)) + services_gm1(i);
    end
end

%% G/G/1
arrivals_gg1 = cumsum(exprnd(1/lambda, 1, N)); % Время поступления
services_gg1 = normrnd(1/mu, 0.1, 1, N); % Время обслуживания
finish_gg1 = zeros(1, N);
for i = 1:N
    if i == 1
        finish_gg1(i) = arrivals_gg1(i) + services_gg1(i);
    else
        finish_gg1(i) = max(arrivals_gg1(i), finish_gg1(i-1)) + services_gg1(i);
    end
end

%% Графики
figure;

% M/M/1
subplot(2, 2, 1);
plot(time, arrivals_mm1, 'b', time, finish_mm1, 'r');
title('M/M/1: Поступления и Обслуживание');
xlabel('Время');
ylabel('Количество');
legend('Поступления', 'Обслуживание');

% M/G/1
subplot(2, 2, 2);
plot(time, arrivals_mm1, 'b', time, finish_mg1, 'r');
title('M/G/1: Поступления и Обслуживание');
xlabel('Время');
ylabel('Количество');
legend('Поступления', 'Обслуживание');

% G/M/1
subplot(2, 2, 3);
plot(time, arrivals_gm1, 'b', time, finish_gm1, 'r');
title('G/M/1: Поступления и Обслуживание');
xlabel('Время');
ylabel('Количество');
legend('Поступления', 'Обслуживание');

% G/G/1
subplot(2, 2, 4);
plot(time, arrivals_gg1, 'b', time, finish_gg1, 'r');
title('G/G/1: Поступления и Обслуживание');
xlabel('Время');
ylabel('Количество');
legend('Поступления', 'Обслуживание');

%% Расчет статистических характеристик для каждого типа СМО
results = struct();
models = {'MM1', 'MG1', 'GM1', 'GG1'};
for i = 1:4
    if i == 1
        arrivals = arrivals_mm1;
        finish = finish_mm1;
    elseif i == 2
        arrivals = arrivals_mm1;
        finish = finish_mg1;
    elseif i == 3
        arrivals = arrivals_gm1;
        finish = finish_gm1;
    else
        arrivals = arrivals_gg1;
        finish = finish_gg1;
    end
    
    % Коэффициент загрузки
    rho = lambda / mu;
    
    % Среднее число заявок в СМО
    avg_customers = mean(arrivals < finish);
    
    % Среднее время пребывания заявок в очереди
    avg_time_queue = mean(finish - arrivals);
    
    % Среднее время пребывания заявок в СМО
    avg_time_system = mean(finish);
    
    results.(models{i}) = struct('Rho', rho, ...
                                  'AvgCustomers', avg_customers, ...
                                  'AvgTimeQueue', avg_time_queue, ...
                                  'AvgTimeSystem', avg_time_system);
end

%% Вывод результатов
disp(results);
