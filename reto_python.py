
import numpy as np
import matplotlib.pyplot as plt
import control as ct

# --- Parametros ---
R = 5;  L = 0.1;  Cap = 220e-6
Kp = 10;  Ki = 1000;  Kd = 0.015

# --- Planta RLC ---
num_rlc = [1/(L*Cap)]
den_rlc = [1, R/L, 1/(L*Cap)]
G_RLC   = ct.tf(num_rlc, den_rlc)

# --- Controlador PID ---
num_pid = [Kd, Kp, Ki]
den_pid = [1, 0]
C_PID   = ct.tf(num_pid, den_pid)

# --- Lazo cerrado ---
G_open = ct.series(C_PID, G_RLC)
G_cl   = ct.feedback(G_open, 1)

print('=== Funcion de transferencia en lazo cerrado ===')
print(G_cl)

# --- Polos ---
polos = ct.poles(G_cl)
print('\n=== Polos del sistema ===')
for p in polos:
    print(f'  s = {p:.4f}   Re={p.real:.4f}')

# --- Figura con subplot ---
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
fig.suptitle('Actividad Reto: Sistema PID-RLC en lazo cerrado', fontsize=13)

# Subplot 1: Respuesta al escalon
t, y = ct.step_response(G_cl, T=np.linspace(0, 0.1, 1000))
ax1.plot(t, y, 'b', linewidth=1.5)
ax1.set_title('Respuesta al escalon')
ax1.set_xlabel('Tiempo (s)')
ax1.set_ylabel('Amplitud')
ax1.grid(True)

# Subplot 2: Mapa de polos y ceros
zeros = ct.zeros(G_cl)
ax2.axhline(0, color='k', linewidth=0.8)
ax2.axvline(0, color='k', linewidth=0.8)
ax2.plot(polos.real, polos.imag, 'rx', markersize=10, linewidth=2, label='Polos')
if len(zeros) > 0:
    ax2.plot(zeros.real, zeros.imag, 'bo', markersize=8, label='Ceros')
ax2.set_title('Diagrama de polos y ceros')
ax2.set_xlabel('Parte real')
ax2.set_ylabel('Parte imaginaria')
ax2.legend(); ax2.grid(True)

plt.tight_layout()
# Guardar figura como: reto_python.png
plt.savefig('reto_python.png', dpi=150)
plt.show()
