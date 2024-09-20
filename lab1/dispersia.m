function [DISPH,DISPD] = dispersia(SKO,KSIH,KSID,N)
disp('Интервальная оценка дисперсии ДСВ');
disp('Верхнее');
DISPH=(SKO.*SKO.*(N-1))./KSIH;
disp((SKO.*SKO.*(N-1))./KSIH);
disp('Нижнее');
DISPD=(SKO.*SKO.*(N-1))./KSID;
disp((SKO.*SKO.*(N-1))./KSID);
disp('Закончил считать интервальную оценку дисперсии ДСВ');
end