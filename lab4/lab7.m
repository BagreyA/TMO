% Лабораторная работа - Сравнение систем M/G/1, M/D/1 и M/M/1

% Входные параметры
lambda = 5;   % Интенсивность поступления заявок
mu = 10;      % Интенсивность обслуживания заявок
rho_values = 0.1:0.1:0.9;  % Коэффициент загрузки
x = 1/mu;     % Среднее время обслуживания
Cb2_values = 0:10:100;  % Нормированная дисперсия для M/G/1

% Инициализация переменных для хранения результатов
N_MG1 = zeros(length(Cb2_values), length(rho_values));  % M/G/1
W_MG1 = zeros(length(Cb2_values), length(rho_values));
T_MG1 = zeros(length(Cb2_values), length(rho_values));

N_MD1 = zeros(1, length(rho_values));  % M/D/1
W_MD1 = zeros(1, length(rho_values));
T_MD1 = zeros(1, length(rho_values));

N_MM1 = zeros(1, length(rho_values));  % M/M/1
W_MM1 = zeros(1, length(rho_values));
T_MM1 = zeros(1, length(rho_values));

% Расчет для системы M/G/1
for i = 1:length(Cb2_values)
    Cb2 = Cb2_values(i);
    for j = 1:length(rho_values)
        rho = rho_values(j);
        
        % Средняя длина очереди (7.1)
        Nq_MG1 = rho^2 * ((1 + Cb2)) / (2 * (1 - rho));
        
        % Среднее число заявок в СМО (7.2)
        N_MG1(i, j) = Nq_MG1 + rho;
        
        % Среднее время ожидания (7.3)
        W_MG1(i, j) = (rho * x * (1 + Cb2)) / (2 * (1 - rho));
        
        % Среднее время пребывания в системе (7.4)
        T_MG1(i, j) = x + rho * x * ((1 + Cb2)) / (2 * (1 - rho));
    end
end

% Расчет для системы M/D/1
for j = 1:length(rho_values)
    rho = rho_values(j);
    
    % Средняя длина очереди (7.5)
    Nq_MD1 = rho^2 * (1)/(2 * (1 - rho));
    
    % Среднее число заявок в СМО (7.6)
    N_MD1(j) = Nq_MD1 + rho;
    
    % Среднее время ожидания (7.7)
    W_MD1(j) = (rho * x) / (2 * (1 - rho));
    
    % Среднее время пребывания в системе (7.8)
    T_MD1(j) = (x * (2 - rho)) / (2 * (1 - rho));
end

% Расчет для системы M/M/1
for j = 1:length(rho_values)
    rho = rho_values(j);
    
    % Средняя длина очереди (7.9)
    Nq_MM1 = (rho^2) / (1 - rho);
    
    % Среднее число заявок в СМО (7.10)
    N_MM1(j) = (rho) / (1 - rho);
    
    % Среднее время ожидания (7.11)
    W_MM1(j) = (rho * x) / (1 - rho);
    
    % Среднее время пребывания в системе (7.12)
    T_MM1(j) = x / (1 - rho);
end

% Построение графиков для всех характеристик
figure;

% Среднее число заявок в СМО
subplot(2,2,1);
for i = 1:length(Cb2_values)
    plot(rho_values, N_MG1(i,:), 'DisplayName', ['Cb^2 = ' num2str(Cb2_values(i))]);
    hold on;
end
plot(rho_values, N_MD1, '--', 'DisplayName', 'M/D/1');
plot(rho_values, N_MM1, ':', 'DisplayName', 'M/M/1');
title('Среднее число заявок в СМО');
xlabel('Коэффициент загрузки (\rho)');
ylabel('Среднее число заявок (N)');
legend('show');

% Среднее время ожидания в очереди
subplot(2,2,2);
for i = 1:length(Cb2_values)
    plot(rho_values, W_MG1(i,:), 'DisplayName', ['Cb^2 = ' num2str(Cb2_values(i))]);
    hold on;
end
plot(rho_values, W_MD1, '--', 'DisplayName', 'M/D/1');
plot(rho_values, W_MM1, ':', 'DisplayName', 'M/M/1');
title('Среднее время ожидания в очереди');
xlabel('Коэффициент загрузки (\rho)');
ylabel('Среднее время ожидания (W)');
legend('show');

% Среднее время пребывания в системе
subplot(2,2,3);
for i = 1:length(Cb2_values)
    plot(rho_values, T_MG1(i,:), 'DisplayName', ['Cb^2 = ' num2str(Cb2_values(i))]);
    hold on;
end
plot(rho_values, T_MD1, '--', 'DisplayName', 'M/D/1');
plot(rho_values, T_MM1, ':', 'DisplayName', 'M/M/1');
title('Среднее время пребывания в системе');
xlabel('Коэффициент загрузки (\rho)');
ylabel('Среднее время пребывания (T)');
legend('show');
