function [INTH, INTD] =interval(D,M,St,N)
disp('Интервальная оценка среднего ДСВ');
disp('Верхнее');
INTH=M+St.*D./sqrt(N);
disp(M+St.*D./sqrt(N));
disp('Нижнее');
INTD=M-St.*D./sqrt(N);
disp(M-St.*D./sqrt(N));
disp('Закончил считать интервальную оценка среднего ДСВ');

end