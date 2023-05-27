%% Carga y visualización de datos
clear; clc;

data = readtable('C:\Users\felip\Downloads\Advertising.csv');
x = table2array(data(:,3)); % Variable predictora (Gasto en publicidad)
y = table2array(data(:,2)); % Variable de respuesta (Ventas)

[m, b] = linear_regression(x, y);

% Gráfico de dispersión de los datos
figure
scatter(x,y,'filled')
xlabel('Gasto en Publicidad (Millones de EUR)')
ylabel('Ventas (Millones de EUR)')
title('Relación entre Gasto en Publicidad y Ventas')

% Calcular el coeficiente de determinación R-cuadrado
y_pred = m*x + b; % Valores predichos de y
SSres = sum((y - y_pred).^2); % Suma de los cuadrados de los residuos
SStot = sum((y - mean(y)).^2); % Suma total de cuadrados
R2 = 1 - SSres/SStot; % Coeficiente de determinación R-cuadrado


% Gráfico de los valores ajustados
hold on
x_fit = min(x):0.1:max(x);
y_fit = predict_y(x_fit, m, b);
plot(x_fit, y_fit, '-r', 'LineWidth', 2)
%legend({'Datos','Ajuste del modelo'},'Location','northwest')
legend('Datos',['Regresión lineal (R2 = ' num2str(R2) ')'], 'Location','northwest')
hold off



% Función que realiza un ajuste de regresión lineal simple por mínimos cuadrados
function [m, b] = linear_regression(x, y)
% a partir de dos vectores de datos x e y.

n = length(x);
sum_x = sum(x);
sum_y = sum(y);
sum_xy = sum(x.*y);
sum_x_sq = sum(x.^2);

% Coeficientes de regresión
m = (n*sum_xy - sum_x*sum_y) / (n*sum_x_sq - sum_x^2);
b = (sum_y - m*sum_x) / n;
end

% Esta función predice los valores de 'y' basados en los valores de 'x'
function y_fit = predict_y(x_fit, m, b)

y_fit = m*x_fit + b;
disp('x_fit:');
disp(x_fit);
disp('y_fit:');
disp(y_fit);
dlmwrite('C:\Users\felip\Downloads\fit_results.txt', [x_fit' y_fit'], 'delimiter', '\t');

end


