FROM vcatechnology/linux-mint:17.3

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's#http://archive.ubuntu.com/#http://ubuntu.mirrors.tds.net/pub/ubuntu/#' /etc/apt/sources.list

# built-in packages
RUN apt-get update
RUN apt-get install -y python-apt
RUN apt-get install -y --no-install-recommends software-properties-common curl
RUN add-apt-repository -y ppa:fcwu-tw/ppa
RUN apt-get update
RUN apt-get install -y --no-install-recommends --allow-unauthenticated supervisor openssh-server pwgen sudo vim-tiny net-tools \
        x11vnc xserver-xorg-video-dummy gtk2-engines-murrine ttf-ubuntu-font-family firefox \
        nginx python-pip python-dev build-essential mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta \
        dbus-x11 x11-utils
RUN apt-get install -y --allow-unauthenticated marco caja mate-desktop mate-panel mate-session-manager mate-terminal 
RUN apt-get install -y --allow-unauthenticated mate-themes mate-control-center
#RUN apt-get autoclean
#RUN apt-get autoremove 


# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

EXPOSE 80
WORKDIR /root

ENTRYPOINT ["/startup.sh"]
