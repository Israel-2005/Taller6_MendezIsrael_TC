
G1 = tf([3], [1 0]);
G2 = tf([1], [1 0 1]);
H1 = tf([3], [1]);
G_serie = series(G1, G2);
G_cl    = feedback(G_serie, H1);
 
disp('=== Polos del sistema ===')
polos = pole(G_cl)

den = G_cl.Denominator{1};
disp('=== Raices del polinomio denominador ===')
r = roots(den)

% --- Diagrama de polos y ceros 
figure('Name', 'Literal 4 - Mapa de polos y ceros');
pzmap(G_cl);
grid on;
title('Diagrama de polos y ceros - G_{cl}(s)');


% --- Clasificacion automatica del sistema ---
disp('=== Clasificacion del sistema ===')
partes_reales = real(polos);

if any(partes_reales > 1e-6)
    disp('ESTABILIDAD : INESTABLE (existen polos con parte real positiva)')
else
    disp('ESTABILIDAD : ESTABLE')
end

if any(abs(imag(polos)) > 1e-6)
    disp('TIPO        : OSCILANTE (hay polos complejos conjugados)')
else
    disp('TIPO        : NO OSCILANTE')
end

% Factor de amortiguamiento del par dominante (mayor parte real)
[~, idx] = max(real(polos));
polo_dom = polos(idx);
wn   = abs(polo_dom);
zeta = -real(polo_dom) / wn;
fprintf('Par dominante : sigma = %.4f , wd = %.4f\n', real(polo_dom), abs(imag(polo_dom)))
fprintf('wn = %.4f rad/s  |  zeta = %.4f\n', wn, zeta)

if zeta < -1
    disp('AMORTIGUAMIENTO: Inestable no oscilante (zeta < -1)')
elseif zeta < 0
    disp('AMORTIGUAMIENTO: Subamortiguado inestable (zeta < 0)')
elseif zeta == 0
    disp('AMORTIGUAMIENTO: No amortiguado (zeta = 0)')
elseif zeta < 1
    disp('AMORTIGUAMIENTO: Subamortiguado (0 < zeta < 1)')
elseif zeta == 1
    disp('AMORTIGUAMIENTO: Criticamente amortiguado (zeta = 1)')
else
    disp('AMORTIGUAMIENTO: Sobreamortiguado (zeta > 1)')
end