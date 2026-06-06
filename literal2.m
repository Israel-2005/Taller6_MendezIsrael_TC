
% --- Definicion de bloques individuales ---
G1 = tf([3], [1 0]);         
G2 = tf([1], [1 0 1]);        
H1 = tf([3], [1]);           

% --- Algebra de bloques ---
G_serie = series(G1, G2);      
G_cl    = feedback(G_serie, H1); 

disp('--- Funcion de transferencia en lazo cerrado ---')
G_cl

% --- Respuesta al escalon unitario ---
figure('Name', 'Literal 2 - Respuesta al escalon');
[y, t] = step(G_cl, 15);
plot(t, y, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Respuesta al escalon del sistema en lazo cerrado');
legend('G_{cl}(s) = 3 / (s^3 + s + 9)');

% Guardar figura como: literal2_step.png
saveas(gcf, 'literal2_step.png');