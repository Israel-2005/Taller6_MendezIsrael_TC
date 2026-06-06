% Literal 1: Sistema de primer orden

% --- Definicion del sistema ---
Gs = tf([1], [2 1]);          % G(s) = 1/(2s+1)
tau = 2;                       % Constante de tiempo

% --- Polo del sistema 
disp('=== Polo del sistema ===')
polo = roots([2 1])

% --- Respuesta al escalon 
[y, t] = step(Gs);

% --- Posicion donde t = 4*tau 
ts = 4 * tau;                  % ts = 8 segundos
[~, idx] = min(abs(t - ts));   % Indice mas cercano a t=8s
fprintf('En t = 4*tau = %.1f s --> y = %.4f (debe ser ~98%%)\n', ts, y(idx))

% --- Grafica del sistema estable ---
figure('Name', 'Sistema de primer orden - Respuesta estable');
plot(t, y, 'b', 'LineWidth', 1.5); hold on;
yline(1,    '--k', 'Valor final (K=1)', 'LineWidth', 1.2);
yline(0.632,'--g', '63.2% en t=tau',   'LineWidth', 1.0);
yline(0.98, '--r', '98% en t=4*tau',   'LineWidth', 1.0);
xline(tau,  '-.g', 'tau = 2 s',        'LineWidth', 1.0);
xline(ts,   '-.r', '4*tau = 8 s',      'LineWidth', 1.0);
plot(tau, y(find(t >= tau, 1)), 'go', 'MarkerSize', 8, 'LineWidth', 2);
plot(ts,  y(idx),               'ro', 'MarkerSize', 8, 'LineWidth', 2);
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Respuesta al escalon - G(s) = 1/(2s+1)');
legend('Respuesta y(t)', 'Valor final', '63.2%', '98%', ...
    'tau', '4*tau', 'Punto 63.2%', 'Punto 98%', ...
    'Location', 'southeast');
hold off;

% Modificando el signo de tau: G_inest = 1/(-2s+1)
Gs_inest = tf([1], [-2 1]);

disp('=== Polo del sistema inestable ===')
roots([-2 1])

[y_inest, t_inest] = step(Gs_inest, 10);

figure('Name', 'Sistema de primer orden - Respuesta inestable');
plot(t_inest, y_inest, 'r', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Respuesta al escalon - G_{inest}(s) = 1/(-2s+1)  [Sistema inestable]');
legend('Respuesta inestable y(t)');
