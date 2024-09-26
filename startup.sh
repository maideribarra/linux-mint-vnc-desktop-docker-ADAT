#!/bin/sh

# Crear directorios necesarios
mkdir -p /var/run/sshd
chown -R root:root /root
#rm -f /tmp/.X0-lock
# Iniciar Xvfb para crear un entorno gráfico
Xvfb :0 -screen 0 1280x720x24 &
sleep 2  # Espera un momento para asegurarte de que Xvfb esté listo

# Establecer la variable de entorno DISPLAY
export DISPLAY=:0

# Iniciar el entorno de escritorio MATE
mate-session &

# Iniciar x11vnc sin contraseña
x11vnc -display :0 -forever -nopw -noxdamage -repeat &
sleep 2  # Espera un momento para asegurarte de que x11vnc esté listo

# Iniciar noVNC
websockify --web /usr/share/novnc/ 6080 localhost:5900 &

# Esperar indefinidamente
wait