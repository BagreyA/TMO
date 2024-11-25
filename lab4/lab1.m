% 1. Определение функции f(x)
f = @(x) sin(x).^3 + cos(x).^2 + tan(x);  % Анонимная функция f(x)

% 2. Символическая производная
syms x
f_sym = sin(x)^3 + cos(x)^2 + tan(x);  % Символическое выражение функции
f_prime = diff(f_sym, x);              % Символическая производная

% 3. Численная производная
x_vals = -10:0.1:10;   % Диапазон значений x
f_vals = f(x_vals);    % Значения функции f(x) для этих x
f_prime_vals = gradient(f_vals, x_vals);  % Численная производная

% 4. Численный интеграл
I = @(x) integral(@(y) f(y), 0, x);  % Определённый интеграл от 0 до x
f_integral_vals = arrayfun(I, x_vals);  % Применение функции integral к массиву значений x

% 5. Создание фигуры с заголовками и подписями
figure;

% Добавляем заголовок всей работы (выше графиков)
annotation('textbox', [0 0.92 1 0.08], 'String', 'Лабораторная работа №1: Переменные, функции, графика', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');

annotation('textbox', [0 0.87 1 0.08], 'String', 'ФИО: Багрей А.О., Группа: ИА-232', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12);

% 6. График функции f(x)
subplot(3, 1, 1);  % Размещение графика на первом месте (всего 3 строки, 1 столбец)
% Добавляем математическое выражение перед графиком
annotation('textbox', [0 0.72 1 0.05], 'String', 'f(x) = sin(x)^3 + cos(x)^2 + tan(x)', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12);
plot(x_vals, f_vals, 'LineWidth', 1.5);
xlabel('x');
ylabel('f(x)');
title('График функции f(x)');
grid on;

% 7. График производной f'(x)
subplot(3, 1, 2);  % Размещение графика на втором месте
% Добавляем математическое выражение перед графиком
annotation('textbox', [0 0.45 1 0.05], 'String', 'f''(x) = производная от sin(x)^3 + cos(x)^2 + tan(x)', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12);
plot(x_vals, f_prime_vals, 'LineWidth', 1.5, 'Color', 'r');
xlabel('x');
ylabel('f''(x)');
title('График производной f''(x)');
grid on;

% 8. График интеграла \int_0^x f(y) dy
subplot(3, 1, 3);  % Размещение графика на третьем месте
% Добавляем математическое выражение перед графиком
annotation('textbox', [0 0.18 1 0.05], 'String', '\int_0^x f(y) dy = интеграл от sin(x)^3 + cos(x)^2 + tan(x)', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12);
plot(x_vals, f_integral_vals, 'LineWidth', 1.5, 'Color', 'g');
xlabel('x');
ylabel('Интеграл от f(x)');
title('График интеграла \int_0^x f(y) dy');
grid on;

% 9. Добавляем общий заголовок ко всем графикам
sgtitle(' ');  % sgtitle добавляет заголовок над всеми графиками
