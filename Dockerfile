FROM linuxmintd/mint19.3-amd64

ENV DEBIAN_FRONTEND noninteractive
ENV TINI_VERSION v0.19.0
ENV HSQLDB_VERSION=2.7.3
ENV HSQLDB_HOME=/opt/hsqldb
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV HSQLDB_HOME /opt/hsqldb
ENV CLASSPATH=$HSQLDB_HOME/lib/hsqldb.jar:/opt/hsqldb/lib/hsqldb.jar:/usr/lib/jvm/java-11-openjdk-amd64:/opt/derby/db-derby-10.16.1.1-bin:/opt/hsqldb:/opt/libs/*
# Actualizar e instalar dependencias del sistema
ENV DERBY_HOME /opt/derby
ENV PATH $DERBY_HOME/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    x11vnc \
    xserver-xorg-video-dummy \
    mate-desktop \
    supervisor \
    novnc \
    xvfb \ 
    dos2unix \
    lxde \
    sqlite3 \
    firefox \
    wget \
    unzip \
    software-properties-common curl \
    supervisor openssh-server pwgen sudo vim-tiny net-tools \
    x11vnc xserver-xorg-video-dummy \
    gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta \
    dbus-x11 x11-utils \
    marco caja mate-desktop mate-panel mate-session-manager mate-terminal \
    mate-themes mate-control-center \
    mate-desktop-environment mate-session-manager marco caja 
     


RUN wget https://dlcdn.apache.org//db/derby/db-derby-10.16.1.1/db-derby-10.16.1.1-bin.tar.gz && \
    tar -xvzf db-derby-10.16.1.1-bin.tar.gz && \
    mv db-derby-10.16.1.1-bin /opt/derby && \
    rm db-derby-10.16.1.1-bin.tar.gz 

RUN wget https://sourceforge.net/projects/hsqldb/files/hsqldb/hsqldb_2_7/hsqldb-2.7.2.zip && \
    unzip hsqldb-2.7.2.zip && \
    mv hsqldb-2.7.2 /opt/hsqldb && \
    rm hsqldb-2.7.2.zip 

RUN wget https://github.com/h2database/h2database/releases/download/version-2.3.232/h2-2024-08-11.zip && \
    unzip h2-2024-08-11.zip && \
    mv h2 /opt/h2 && \
    rm h2-2024-08-11.zip 

 # Limpiar
RUN apt-get remove -y wget unzip && \
    apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Descargar e instalar HSQLDB
#RUN mkdir -p /opt && \
    #wget https://sourceforge.net/projects/hsqldb/files/hsqldb/2.7.3/hsqldb-2.7.3.zip/download -O /tmp/hsqldb.zip && \
    #unzip /tmp/hsqldb.zip -d /opt && \
    #mv /opt/hsqldb-${HSQLDB_VERSION} $HSQLDB_HOME && \
    #rm /tmp/hsqldb.zip

#RUN java -version

#VOLUME ["/db/sQlite/", "/hsqldb/data/","/var/lib/hsqldb","/opt/"]
# Crear directorios necesarios
RUN mkdir -p /var/run/sshd /etc/supervisor/conf.d

# Copiar archivo de configuración de Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN dos2unix /etc/supervisor/conf.d/supervisord.conf
# Exponer puertos para HTTP (noVNC) y VNC
EXPOSE 5900 6080 9001 1527

# Establecer el directorio de trabajo
WORKDIR /root

# Copiar el script de entrada
COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh
RUN dos2unix /root/startup.sh
# Definir el punto de entrada
# Comando por defecto para arrancar el servidor HSQLDB
#CMD ["java", "-cp", "/opt/hsqldb/lib/hsqldb.jar", "org.hsqldb.Server", "-database.0", "file:/var/lib/hsqldb/mydb", "-dbname.0", "mydb"]
ENTRYPOINT ["/root/startup.sh"]
