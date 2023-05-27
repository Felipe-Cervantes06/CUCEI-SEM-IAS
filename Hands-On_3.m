%% Carga y visualización de datos
clear; clc;

data = readtable('C:\Users\felip\Downloads\Parabol.csv');
x = table2array(data(:,1)); % Variable predictora 
y = table2array(data(:,2)); % Variable de respuesta

% Calcular la matriz A y el vector b
A = [x.^2, x, ones(size(x))];
b = y;

% Calcular los coeficientes a, b y c
coeff = A \ b;
a = coeff(1);
b = coeff(2);
c = coeff(3);

% Crear la función y = ax^2 + bx + c
y_fit = a * x.^2 + b * x + c;

% Calcular el coeficiente de determinación (R^2)
y_mean = mean(y);
SS_tot = sum((y - y_mean).^2);
SS_res = sum((y - y_fit).^2);
R2 = 1 - SS_res / SS_tot;

% Imprimir la ecuación y_fit
eq = sprintf('y_fit = %0.4f*x^2 + %0.4f*x + %0.4f', a, b, c);
disp(eq);

% Obtener un valor X de entrada y calcular su respectivo y predecido
x_input = input('Ingrese un valor de X: ');
y_pred = a * x_input^2 + b * x_input + c;
fprintf('y_pred = %0.4f\n', y_pred);

% Calcular el coeficiente de determinación (R^2)
y_mean = mean(y);
SS_tot = sum((y - y_mean).^2);
SS_res = sum((y - y_fit).^2);
R2 = 1 - SS_res / SS_tot;

% Imprimir el valor de R^2 en un archivo de texto
filename = 'R2_value.txt';
fileID = fopen(filename, 'w');
fprintf(fileID, 'R^2 = %0.4f', R2);
fclose(fileID);

% Gráfico de dispersión de los datos y la función de ajuste
figure;
scatter(x, y, 'filled');
grid on;
hold on;
plot(x, y_fit, '-');
xlim([-6, 6]);
ylim([-4, 16]);
xlabel('X');
ylabel('Y');
title('Optimizaciónn para análisis predictivo con QLR');
plot([0, 0], ylim, 'k-', xlim, [0, 0], 'k-');
text(x(1), y_mean, sprintf('R^2 = %0.4f', R2));
legend('Datos', 'Ajuste');
hold off;
