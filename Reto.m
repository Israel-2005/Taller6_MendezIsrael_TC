
clc; clear; close all;

% --- Parametros RLC y PID ---
R = 5;  L = 0.1;  Cap = 220e-6;
Kp = 10;  Ki = 1000;  Kd = 0.015;


% LITERAL 1

% Planta RLC
num_rlc = 1/(L*Cap);
den_rlc = [1, R/L, 1/(L*Cap)];
G_RLC   = tf(num_rlc, den_rlc);

% Controlador PID
num_pid = [Kd, Kp, Ki];
den_pid = [1, 0];
C_PID   = tf(num_pid, den_pid);

% Lazo abierto y lazo cerrado 
G_open = series(C_PID, G_RLC);
G_cl   = feedback(G_open, 1);

disp('=== Funcion de transferencia en lazo cerrado ===')
G_cl


% LITERAL 3

disp('=== Polos del sistema en lazo cerrado ===')
polos = pole(G_cl)

den_num = G_cl.Denominator{1};
disp('=== Raices del denominador via roots() ===')
r = roots(den_num)


% LITERAL 4

figure('Name', 'Reto - Respuesta y Mapa de Polos');

% --- Subplot 1: Respuesta al escalon ---
subplot(1, 2, 1);
step(G_cl);
grid on;
title('Respuesta al escalon - G_{cl}(s)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% --- Subplot 2: Diagrama de polos y ceros ---
subplot(1, 2, 2);
pzmap(G_cl);
grid on;
title('Diagrama de polos y ceros');

% Guardar figura como: reto_subplot.png
saveas(gcf, 'reto_subplot.png');