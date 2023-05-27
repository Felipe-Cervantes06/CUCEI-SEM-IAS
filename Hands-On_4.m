%% Limpiamos workspace
clear; clc;

%% Parámetros del algoritmo genético
pop_size        = 100;  % Tamaño de la población
chrom_len       = 20;   % Longitud del cromosoma
cross_rate      = 0.75; % Tasa de cruce
mut_rate        = 0.6;  % Tasa de mutación
max_generations = 500;  % Número máximo de generaciones

%% Creación de la población inicial
pop = randi([0 1], pop_size, chrom_len);

%% Bucle principal del algoritmo genético
found_solution = false;
num_generations = 0;

while ~found_solution
    % Evaluación de la función de fitness
    fitness = sum(pop, 2);
    
    % Verificación de la solución óptima
    if any(fitness == chrom_len)
        found_solution = true;
        break
    end

    %Verificamos si estamos dentro del rango de generaciones
    if num_generations > max_generations
        break
    end
    
    % Selección de padres con la ruleta
    prob = fitness / sum(fitness);
    parents = pop(randsample(pop_size, 2, true, prob), :);
    
    % Crossover
    if rand < cross_rate
        cross_point = randi([1 chrom_len-1]);
        parents = [parents(1, 1:cross_point), parents(2, cross_point+1:end);
                   parents(2, 1:cross_point), parents(1, cross_point+1:end)];
    end
    
    % Mutación
    if rand < mut_rate
        mutation_point = randi([1 pop_size*chrom_len]);
        pop(mutation_point) = ~pop(mutation_point);
    end
    
    % Reemplazo de la población
    [~, worst_idx] = min(fitness);
    pop(worst_idx, :) = parents(1, :);
    
    % Actualización del contador de generaciones
    num_generations = num_generations + 1;

end

%% Resultados
if found_solution == true
    fprintf('Solución encontrada en la generación: %d', num_generations);
else
    fprintf('La Solución no fue encontrada en %d generaciones', max_generations);
end
disp(newline)