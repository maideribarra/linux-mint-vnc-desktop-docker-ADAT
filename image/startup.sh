#!/bin/sh

# Crear directorios necesarios
mkdir -p /var/run/sshd
chown -R root:root /root

# Iniciar Xvfb
Xvfb :0 -screen 0 1280x720x24 &
while ! xdpyinfo >/dev/null 2>&1; do
    sleep 1
done

export DISPLAY=:0

# Iniciar Supervisor
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
